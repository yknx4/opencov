defmodule Librecov.BuildLive.Show do
  use Librecov.Web, :live_view
  import Librecov.CommonView

  alias Librecov.Repo
  alias Librecov.Build
  alias Librecov.BuildLive.Commit
  alias Librecov.FileService

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    build = Repo.get!(Build, id) |> Repo.preload([:jobs, :project])
    job_ids = Enum.map(build.jobs, & &1.id)
    file_params = FileService.files_with_filter(job_ids, params)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:build, build)
     |> assign(:file_params, file_params)}
  end

  defp page_title(:show), do: "Show Build"
  defp page_title(:edit), do: "Edit Build"
end
