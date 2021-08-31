defmodule Librecov.FileLive.Show do
  use Librecov.Web, :live_view
  import Librecov.CommonView

  alias Librecov.File
  alias Librecov.Services.Authorizations
  alias Librecov.Services.Github.Auth
  alias Librecov.Services.Github.Files
  alias Librecov.Parser.Highlight
  alias Librecov.Repo

  @impl true
  def mount(_params, session, socket) do
    {:ok, user, _} = Authentication.resource_from_session(session)
    {:ok, socket |> assign(user: user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user = socket.assigns.user

    file = Repo.get!(File, id) |> Repo.preload(job: [build: :project])

    auth = user |> Authorizations.first_for_provider("github") |> Authorizations.ensure_fresh!()

    Auth.with_auth_data!(file.job.build.project, auth, fn auth_data ->
      file_content = Files.file!(auth_data, file.name, file.job.build.commit_sha)

      raw_content =
        file_content.content
        |> String.split("\n")
        |> Enum.map(&Base.decode64!/1)
        |> Enum.join("")

      file =
        file
        |> Map.put(
          :source,
          raw_content
        )

      content_to_render = Highlight.parse(file)

      {:ok,
       {:noreply,
        socket
        |> assign(:page_title, page_title(socket.assigns.live_action))
        |> assign(:content, content_to_render)
        |> assign(:file, file)}}
    end)
  end

  defp page_title(:show), do: "Show File"
  defp page_title(:edit), do: "Edit File"

  @max_length 20

  def filters do
    %{
      "changed" => "Changed",
      "cov_changed" => "Coverage changed",
      "covered" => "Covered",
      "unperfect" => "Unperfect"
    }
  end

  def class_for_coverage(nil), do: ""
  def class_for_coverage(0), do: "bg-warning"
  def class_for_coverage(_), do: ""

  def content_for_coverage(nil), do: ""
  def content_for_coverage(0), do: "<span class=\"badge rounded-pill bg-danger\">0</span>"

  def content_for_coverage(coverage),
    do: "<span class=\"badge rounded-pill bg-success\">#{coverage}</span>"

  def short_name(name) do
    if String.length(name) < @max_length do
      name
    else
      name
      |> String.split("/")
      |> Enum.reverse()
      |> Enum.reduce({[], 0}, fn s, {n, len} ->
        if len + String.length(s) <= @max_length do
          {[s | n], len + String.length(s)}
        else
          {[String.first(s) | n], len + 1}
        end
      end)
      |> elem(0)
      |> Enum.join("/")
    end
  end
end
