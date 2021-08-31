defmodule LibrecovWeb.JobLiveTest do
  use Librecov.ConnCase

  import Phoenix.LiveViewTest

  defp create_job(_) do
    job = insert(:job)
    %{job: job}
  end

  describe "Show" do
    setup [:create_job]

    test "displays job", %{conn: conn, job: job} do
      {:ok, _show_live, html} = live(conn, Routes.job_show_path(conn, :show, job))

      assert html =~ "Show Job"
    end
  end
end
