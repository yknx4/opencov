defmodule Librecov.FileController do
  use Librecov.Web, :controller

  alias Librecov.File
  alias Librecov.Services.Authorizations
  alias Librecov.Services.Github.Auth
  alias Librecov.Services.Github.Files

  def show(conn, %{"id" => id}) do
    user = Authentication.get_current_account(conn)
    file = Repo.get!(File, id) |> Librecov.Repo.preload(job: [build: :project])

    {:ok, auth} =
      user |> Authorizations.first_for_provider("github") |> Authorizations.ensure_fresh()

    Auth.with_auth_data(file.job.build.project, auth, fn auth_data ->
      {:ok, file_content} = Files.file(auth_data, file.name, file.job.build.commit_sha)

      file_json =
        file
        |> Map.put(
          "source",
          file_content.content
          |> String.split("\n")
          |> Enum.map(&Base.decode64!/1)
          |> Enum.join("")
        )
        |> Jason.encode!()

      render(conn, "show.html", file: file, file_json: file_json, content: file_content)
    end)
  end
end
