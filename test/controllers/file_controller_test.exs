defmodule Librecov.FileControllerTest do
  use Librecov.ConnCase
  import Mock
  alias Librecov.Services.Authorizations
  alias Librecov.User.Authorization
  alias Librecov.Services.Github.Files

  setup do
    conn = build_conn() |> with_login
    {:ok, conn: conn}
  end

  test "shows chosen resource", %{conn: conn} do
    with_mocks([
      {Authorizations, [],
       [
         ensure_fresh!: fn _ -> %Authorization{} end,
         first_for_provider: fn _, _ -> %Authorization{} end
       ]},
      {Files, [], [file!: fn _, _, _ -> %{content: Base.encode64("hello world")} end]}
    ]) do
      file = insert(:file)
      conn = get(conn, file_path(conn, :show, file))
      assert html_response(conn, 200) =~ file.name
    end
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get(conn, file_path(conn, :show, -1))
    end
  end
end
