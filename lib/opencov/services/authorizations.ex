defmodule Librecov.Services.Authorizations do
  alias Librecov.Repo
  alias Librecov.User.Authorization
  alias Librecov.Services.Github.Auth

  use Unsafe.Generator,
    docs: false

  import Librecov.Helpers.Happy

  @unsafe [
    {:ensure_fresh, 1, :unwrap}
  ]

  use EctoResource

  using_repo(Repo) do
    resource(Authorization)
  end

  def first_for_provider(%{authorizations: authorizations}, provider) do
    authorizations |> Enum.find(&(&1.provider == provider))
  end

  def ensure_fresh(%Authorization{expires_at: expires_at, token: token} = auth) do
    now = (Timex.now() |> Timex.to_unix()) + 60

    if !is_nil(token) && now < expires_at do
      {:ok, auth}
    else
      case Auth.github_client()
           |> Map.put(:token, %{refresh_token: auth.refresh_token})
           |> OAuth2.Client.refresh_token() do
        {:ok, %{token: %{other_params: %{"error" => msg}}}} ->
          {:error, msg}

        {:ok, %{token: new_token}} ->
          auth
          |> Authorization.changeset(
            new_token
            |> Map.from_struct()
            |> Map.put(:token, new_token.access_token)
          )
          |> Repo.update()
      end
    end
  end

  def find_or_update_by(%Ueberauth.Auth{provider: provider, uid: uid, credentials: credentials}) do
    provider = provider |> to_string()
    uid = uid |> to_string()
    authorization = Repo.get_by(Authorization, provider: provider, uid: uid)

    if is_nil(authorization) do
      nil
    else
      Authorization.changeset(
        authorization,
        %{provider: provider, uid: uid} |> Map.merge(credentials |> Map.from_struct())
      )
      |> Repo.update()
    end
  end
end
