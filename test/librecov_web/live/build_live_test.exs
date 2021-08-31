defmodule LibrecovWeb.BuildLiveTest do
  use Librecov.ConnCase
  use Snapshy

  import Phoenix.LiveViewTest

  defp create_build(_) do
    project =
      insert(:project,
        id: 1337,
        token: "p4ssw0rd",
        repo_id: "github_1296269",
        name: "octocat/Hello-World",
        base_url: "https://github.com/octocat/Hello-World"
      )

    build =
      insert(:build,
        id: 443,
        build_number: "1234",
        coverage: 99.9,
        previous_coverage: 50.1,
        completed: true,
        commit_sha: "",
        commit_message: "oie shi",
        branch: "main",
        inserted_at: Timex.now() |> Timex.shift(hours: -18) |> Timex.to_datetime(),
        project: project
      )

    user = insert(:user)
    insert(:authorization, user: user)
    %{build: build, user: user}
  end

  describe "Show" do
    setup [:create_build]

    test "displays barebones build", %{conn: conn, build: build, user: user} do
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

      conn = init_test_session(conn, guardian_default_token: token)
      {:ok, view, _html} = live(conn, Routes.build_show_path(conn, :show, build))

      html =
        view
        |> element("#build-info")
        |> render()

      match_snapshot(html)
    end
  end
end
