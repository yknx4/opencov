defmodule Librecov.ProfileController do
  use Librecov.Web, :controller

  alias Librecov.User
  alias Librecov.UserManager

  def show(conn, _params) do
    user = Librecov.Authentication.get_current_account(conn)
    render(conn, "edit.html", user: user, changeset: UserManager.changeset(user))
  end

  def update(conn, params) do
    case Librecov.UserService.update_user(
           params,
           Librecov.Authentication.get_current_account(conn)
         ) do
      {:ok, _user, redirect_path, flash_message} ->
        conn
        |> put_flash(:info, flash_message)
        |> redirect(to: redirect_path)

      {:error, assigns} ->
        render(conn, "edit.html", assigns)
    end
  end

  def edit_password(conn, _params) do
    user = Librecov.Authentication.get_current_account(conn)
    render(conn, "edit_password.html", user: user, changeset: UserManager.changeset(user))
  end

  def update_password(conn, %{"user" => user_params}) do
    user = Librecov.Authentication.get_current_account(conn)
    changeset = UserManager.password_update_changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn |> put_flash(:info, "Your password has been updated") |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "edit_password.html", user: user, changeset: changeset)
    end
  end

  def reset_password_request(conn, _params) do
    render(conn, "reset_password_request.html")
  end

  def send_reset_password(conn, %{"user" => %{"email" => email}}) do
    Librecov.UserService.send_reset_password(email)

    conn
    |> put_flash(:info, "An email has been sent to reset your password.")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  def reset_password(conn, %{"token" => token}) do
    case Repo.get_by(User, password_reset_token: token) do
      %User{} = user ->
        changeset = UserManager.changeset(user)
        render(conn, "reset_password.html", user: user, changeset: changeset, token: token)

      _ ->
        password_reset_error(conn)
    end
  end

  def finalize_reset_password(conn, %{"user" => %{"password_reset_token" => token} = user_params}) do
    case Librecov.UserService.finalize_reset_password(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Your password has been reset.")
        |> Librecov.Authentication.log_in(user)
        |> redirect(to: "/")

      {:error, :not_found} ->
        password_reset_error(conn)

      {:error, changeset} ->
        render(conn, "reset_password.html",
          user: changeset.data,
          changeset: changeset,
          token: token
        )
    end
  end

  defp password_reset_error(conn) do
    conn
    |> put_flash(
      :error,
      "Could not reset your password. Check your email or try the process again."
    )
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
