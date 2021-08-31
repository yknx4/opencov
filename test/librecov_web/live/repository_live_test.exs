defmodule Librecov.RepositoryLiveTest do
  use Librecov.ConnCase

  import Phoenix.LiveViewTest

  defp create_repository(_) do
    repository = insert(:project)
    %{repository: repository}
  end

  describe "Index" do
    setup [:create_repository]

    test "lists all repositories", %{conn: conn, repository: repository} do
      {:ok, _index_live, html} = live(conn, Routes.repository_index_path(conn, :index))

      assert html =~ "Listing Repositories"
    end
  end

  describe "Show" do
    setup [:create_repository]

    test "displays repository", %{conn: conn, repository: repository} do
      {:ok, _show_live, html} =
        live(conn, Librecov.Views.Helper.project_path(conn, :show, repository))

      assert html =~ "Show Repository"
    end
  end
end
