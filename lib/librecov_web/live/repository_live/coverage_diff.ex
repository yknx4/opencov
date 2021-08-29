defmodule Librecov.RepositoryLive.CoverageDiff do
  use Surface.Component

  import Librecov.CommonView

  prop diff, :number, required: true

  def render(assigns) do
    ~F"""
    {#if abs(@diff) >= 0.001}
      <span class={"text-#{if @diff > 0, do: "success", else: "danger"}"}>
        <i class={"fas fa-arrow-circle-#{if @diff > 0, do: "up", else: "down"}"} />{format_coverage(abs(@diff))}
      </span>
    {/if}
    """
  end
end
