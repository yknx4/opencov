defmodule Librecov.RepositoryLive.ElementComponent do
  use Librecov.Web, :live_component
  import Librecov.CommonView
  alias Librecov.Project

  def project_for_repo(projects, repository) do
    Enum.find(
      projects,
      %Project{current_coverage: nil, builds: []},
      &(&1.repo_id == "github_#{repository.id}")
    )
  end

  @impl true
  def render(assigns) do
    project = project_for_repo(assigns.projects, assigns.repository)
    latest_build = List.first(project.builds)

    ~L"""
    <li class="project">
    <main class="clearfix">
      <div class="content">
        <h3>
        <%= if !is_nil(project.id) do %>
        <%= link @repository.full_name , to: Routes.repository_show_path(@socket, :show, @repository.owner.login, @repository.name) %>
        <% else %>
        <%= @repository.full_name %>
        <small><%= link "Setup", to: "#{@repository.html_url}/settings/installations", target: "_blank" %></small>
        <% end %>
        </h3>
      </div>
      <div class="coverage <%= coverage_color(project.current_coverage) %>">
        <%= format_coverage(project.current_coverage) %>
      </div>
    </main>
    <%= if latest_build && latest_build.commit_message do %>
      <%= link latest_build.commit_message, to: Routes.build_path(@socket, :show, latest_build) %>
      <%= if latest_build.branch do %>
        on branch <%= latest_build.branch %>
      <% end %>
      <%= human_time_ago(latest_build.inserted_at) %>
    <% end %>
    </li>
    """
  end
end
