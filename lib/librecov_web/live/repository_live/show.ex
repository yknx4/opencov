defmodule Librecov.RepositoryLive.Show do
  use Librecov.Web, :live_view

  import Librecov.CommonView
  alias Librecov.Data
  alias Librecov.Project
  alias Librecov.Services.Projects
  alias Librecov.Services.Authorizations
  alias Librecov.Build
  alias Librecov.Services.Builds
  alias Librecov.Repo

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign(socket, user: Authentication.resource_from_session!(session))}
  end

  @impl true
  def handle_params(%{"repo" => repo, "owner" => owner}, _, socket) do
    repository = get_repository(socket.assigns.user, repo, owner)

    project =
      Projects.get_project_by(repo_id: "github_#{repository.id}")
      |> Projects.with_latest_10_builds() ||
        %Librecov.Project{builds: []}

    latest_build =
      List.first(project.builds) |> Repo.preload([:project]) || %Build{project: %Project{}}

    total_builds = if(is_nil(project.id), do: 0, else: Builds.count_for_project(project.id))

    total_builds_main =
      if(is_nil(project.id),
        do: 0,
        else: Builds.count_for_project_and_branch(project.id, repository.default_branch || "main")
      )

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:repository, repository)
     |> assign(:latest_build, latest_build)
     |> assign(:builds, project.builds |> Repo.preload([:project]))
     |> assign(:total_builds, total_builds)
     |> assign(:total_builds_main, total_builds_main)
     |> assign(
       :project,
       project
     )}
  end

  defp get_repository(user, repo, owner) do
    user.authorizations
    |> List.first()
    |> Authorizations.ensure_fresh!()
    |> Data.get_repository!(owner, repo)
  end

  defp page_title(:show), do: "Show Repository"
  defp page_title(:edit), do: "Edit Repository"
end
