defmodule LibrecovWeb.FileLiveTest do
  use Librecov.ConnCase

  import Phoenix.LiveViewTest

  defp create_file(_) do
    file = insert(:file)
    %{file: file}
  end

  describe "Show" do
    setup [:create_file]

    @tag :skip
    test "displays file", %{conn: conn, file: file} do
      {:ok, _show_live, html} = live(conn, Routes.file_show_path(conn, :show, file))

      assert html =~ "Show File"
    end
  end
end
