defmodule Librecov.FileController do
  use Librecov.Web, :controller

  alias Librecov.File
  alias Librecov.Services.Authorizations
  alias Librecov.Services.Github.Auth
  alias Librecov.Services.Github.Files
  alias Librecov.Parser.Highlight

  def show(conn, %{"id" => id}) do
    user = Authentication.get_current_account(conn)
    file = Repo.get!(File, id) |> Librecov.Repo.preload(job: [build: :project])

    {:ok, auth} =
      user |> Authorizations.first_for_provider("github") |> Authorizations.ensure_fresh()

    Auth.with_auth_data(file.job.build.project, auth, fn auth_data ->
      {:ok, file_content} = Files.file(auth_data, file.name, file.job.build.commit_sha)

      raw_content =
        file_content.content
        |> String.split("\n")
        |> Enum.map(&Base.decode64!/1)
        |> Enum.join("")

      file =
        file
        |> Map.put(
          "source",
          raw_content
        )

      file_json =
        file
        |> Jason.encode!()

      content_to_render = Highlight.parse(file)

      render(conn, "show.html", file: file, file_json: file_json, content: content_to_render)
    end)
  end
end
