defmodule LibrecovWeb.BuildLiveTest do
  use Librecov.ConnCase

  import Phoenix.LiveViewTest

  defp create_build(_) do
    build = insert(:build)
    %{build: build}
  end

  describe "Show" do
    setup [:create_build]

    @tag :skip
    test "displays build", %{conn: conn, build: build} do
      {:ok, _show_live, html} = live(conn, Routes.build_show_path(conn, :show, build))

      assert html =~ "Show Build"
    end
  end
end
