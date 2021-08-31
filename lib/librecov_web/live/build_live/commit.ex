defmodule Librecov.BuildLive.Commit do
  use Surface.Component
  alias Librecov.Common.Icon
  alias Surface.Components.Link
  import Librecov.CommonView

  prop build, :struct, required: true

  def render(assigns) do
    ~F"""
    {#if @build.commit_message}
      {@build.commit_message}
      {#if @build.commit_sha}
        <Link to={commit_link(@build.project, @build.commit_sha)}>
          <Icon family="fab" icon={repository_class(@build.project)} />
        </Link>
      {/if}
    {/if}
    """
  end
end
