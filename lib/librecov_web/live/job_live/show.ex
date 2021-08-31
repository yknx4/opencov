defmodule Librecov.JobLive.Show do
  use Librecov.Web, :live_view
  import Librecov.CommonView

  alias Librecov.Job
  alias Librecov.FileService
  alias Librecov.Repo
  alias Surface.Components.LiveRedirect

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    job = Repo.get!(Job, id) |> Repo.preload(build: :project)
    file_params = FileService.files_with_filter(job, params)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:job, job)
     |> assign(file_params)}
  end

  defp page_title(:show), do: "Show Job"
  defp page_title(:edit), do: "Edit Job"
end
