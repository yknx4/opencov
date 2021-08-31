defmodule Librecov.FileLive.List do
  use Surface.Component
  import Librecov.CommonView
  alias Surface.Components.Link
  alias Librecov.Common.Icon
  alias Librecov.RepositoryLive.CoverageDiff
  alias Librecov.Router.Helpers, as: Routes
  import Scrivener.HTML
  prop paginator, :struct, required: true
  prop files, :list, required: true
  prop filters, :list, required: false
  prop order, :tuple, required: true
  prop path_fn, :fun, required: true
  prop path_args, :list, required: true

  def raw_filters do
    %{
      "changed" => "Changed",
      "cov_changed" => "Coverage changed",
      "covered" => "Covered",
      "unperfect" => "Unperfect"
    }
  end

  defp row_order(order, k) do
    if elem(order, 0) == k && elem(order, 1) == "desc", do: "asc", else: "desc"
  end

  defp sort_icon("desc"), do: "down"
  defp sort_icon(:desc), do: "down"
  defp sort_icon("asc"), do: "up"
  defp sort_icon(:asc), do: "up"

  def render(assigns) do
    order_args = [order_field: elem(assigns.order, 0), order_direction: elem(assigns.order, 1)]

    ~F"""
    <div class="block block-rounded">
      <div class="block-header block-header-default">
        <h3 class="block-title">Files <span class="small">({@paginator.total_entries})</span></h3>
        <div class="block-options">
          <div class="dropdown">
            <button
              type="button"
              class="btn-block-option"
              id="dropdown-ecom-filters"
              data-bs-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >
              Filters <i class="fa fa-angle-down ms-1" />
            </button>
            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdown-ecom-filters" style="">
              {#for {k, v} <- raw_filters()}
                {#if Enum.any?(@filters, &(&1 == k))}
                  <Link
                    class="dropdown-item d-flex align-items-center justify-content-between"
                    label={v}
                    to={apply(@path_fn, @path_args ++ [[{:filters, @filters -- [k]} | order_args]])}
                  />
                {#else}
                  <Link
                    class="dropdown-item d-flex align-items-center justify-content-between"
                    label={v}
                    to={apply(@path_fn, @path_args ++ [[{:filters, [k | @filters]} | order_args]])}
                  />
                {/if}
              {/for}
            </div>
          </div>
        </div>
      </div>
      <div class="block-content">
        <!-- All Orders Table -->
        <div class="table-responsive">
          <table class="table table-borderless table-striped table-vcenter">
            <thead>
              <tr>
                {#for {k, v} <- %{"coverage" => "Coverage", "diff" => "Diff", "name" => "Name"}}
                  <th class="d-none d-sm-table-cell text-center">
                    <Link to={apply(
                      @path_fn,
                      @path_args ++ [[filters: @filters, order_field: k, order_direction: row_order(@order, k)]]
                    )}>
                      <span>{v}</span>
                      <Icon family="fas" icon={"sort-#{elem(@order, 1) |> sort_icon}"} :if={elem(@order, 0) == k} />
                    </Link>
                  </th>
                {/for}
              </tr>
            </thead>
            <tbody>
              {#for file <- @files}
                <tr>
                  <td class="d-none d-sm-table-cell text-center fs-sm">{format_coverage(file.coverage)}</td>
                  <td class="text-center fs-sm">
                    <span class="fw-semibold">
                      <CoverageDiff diff={file.coverage - file.previous_coverage} :if={file.previous_coverage} />
                    </span>
                  </td>

                  <td class="text-center d-none d-xl-table-cell fs-sm">
                    <Link class="fw-semibold" label={file.name} to={Routes.file_path(@socket, :show, file)} />
                  </td>
                </tr>
              {/for}
            </tbody>
          </table>
        </div>
        <!-- END All Orders Table -->

        <!-- Pagination -->
        <nav aria-label="Photos Search Navigation" :if={@paginator.total_pages > 1}>
          {pagination_links(
            @socket,
            @paginator,
            Enum.drop(@path_args, 2),
            path: @path_fn,
            action: Enum.at(@path_args, 1),
            filters: @filters,
            order_field: elem(@order, 0),
            order_direction: elem(@order, 1)
          )}
        </nav>
        <!-- END Pagination -->
      </div>
    </div>
    """
  end
end
