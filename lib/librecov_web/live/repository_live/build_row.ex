defmodule Librecov.RepositoryLive.BuildRow do
  use Surface.Component
  alias Librecov.Router.Helpers, as: Routes

  import Librecov.CommonView
  alias Surface.Components.Link
  alias Librecov.RepositoryLive.CoverageDiff
  alias Surface.Components.LiveRedirect
  alias Librecov.Common.Icon

  prop build, :struct, required: true

  def render(assigns) do
    ~F"""
    <tr>
      <td>
        <span class="fw-semibold">
          <LiveRedirect label={"##{@build.build_number}"} to={Routes.build_show_path(@socket, :show, @build.id)} />
        </span>
      </td>
      <td class="d-none d-sm-table-cell">
        <span class="fs-sm text-muted">{@build.branch}</span>
      </td>
      <td>
        <span class={"fw-semibold text-#{coverage_badge(@build.coverage)}"}>{format_coverage(@build.coverage)}</span>
      </td>
      <td>
        <span class="fw-semibold">
          {#if !is_nil(@build.previous_coverage)}
            <CoverageDiff diff={@build.coverage - @build.previous_coverage} />
          {#else}
            N/A
          {/if}
        </span>
      </td>
      <td>
        <span class="fw-semibold">
          {@build.commit_message}
          {#if @build.commit_sha}
            <Link to={commit_link(@build.project, @build.commit_sha)}><Icon family="fab" icon={repository_class(@build.project)} /></Link>
          {/if}
        </span>
      </td>
      <td class="d-none d-sm-table-cell">
        {@build.committer_name}
      </td>
      <td class="d-none d-sm-table-cell">
        {human_time_ago(@build.inserted_at)}
      </td>
      <td class="d-none d-sm-table-cell">
        {@build.service_name}
      </td>
    </tr>
    """
  end
end
