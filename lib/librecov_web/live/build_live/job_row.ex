defmodule Librecov.RepositoryLive.JobRow do
  use Surface.Component
  alias Librecov.Router.Helpers, as: Routes

  import Librecov.CommonView
  alias Surface.Components.Link
  alias Librecov.RepositoryLive.CoverageDiff
  alias Surface.Components.LiveRedirect

  prop job, :struct, required: true

  def render(assigns) do
    ~F"""
    <tr>
      <td class="text-center fs-sm">
        <span class="fw-semibold">
          <LiveRedirect label={"##{@job.job_number}"} to={Routes.job_show_path(@socket, :show, @job)} />
        </span>
      </td>
      <td class="text-center fs-sm">
        <span class={"fw-semibold text-#{coverage_badge(@job.coverage)}"}>{format_coverage(@job.coverage)}</span>
      </td>
      <td class="text-start fs-sm">
        <span class="fw-semibold">
          {#if !is_nil(@job.previous_coverage)}
            <CoverageDiff diff={@job.coverage - @job.previous_coverage} />
          {#else}
            N/A
          {/if}
        </span>
      </td>
      <td class="text-start d-none d-sm-table-cell">
        {@job |> Librecov.JobView.job_time() |> human_time_ago}
      </td>
      <td class="text-center d-none d-sm-table-cell">
        {@job.files_count}
      </td>
    </tr>
    """
  end
end
