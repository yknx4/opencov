defmodule Librecov.Subscriber.GithubSubscriber do
  require Logger
  alias EventBus.Model.Event
  alias Librecov.Build
  alias Librecov.Repo
  alias Librecov.Services.Github.Auth
  alias Librecov.Services.Github.Checks
  alias Librecov.Services.Github.Comments
  alias Librecov.Services.Github.PullRequests
  alias Librecov.Templates.CommentTemplate
  alias Librecov.Services.Github.AuthData

  @topics [:build_finished, :pull_request_synced, :check_suite_requested]

  def topics, do: @topics

  def process({_topic, _id} = event_shadow) do
    try do
      event_shadow |> EventBus.fetch_event() |> process()
    after
      EventBus.mark_as_completed({__MODULE__, event_shadow})
    end
  end

  def process(%Event{topic: :build_finished, data: %Build{} = build}) do
    build = build |> Repo.preload([:project])

    Auth.with_auth_data(build.project, fn auth ->
      with %Librecov.Build{} = updated_build <- Repo.reload(build) do
        Logger.debug("""
        Build##{updated_build.id}/#{updated_build.build_number}
        Coverage: #{updated_build.coverage}
        Previous Coverages: #{updated_build.previous_coverage}
        Performing Github Integrations
        """)

        perform_github_integrations(auth, build)
      end
    end)
  end

  def process(%Event{topic: :check_suite_requested, data: payload}) do
    Auth.with_auth_data(payload, fn auth ->
      Checks.create_check(auth, payload["check_suite"]["head_sha"])
    end)
  end

  def process(%Event{}) do
  end

  def perform_github_integrations(%AuthData{} = auth, %Build{branch: branch} = build)
      when branch in [nil, ""] do
    Checks.finish_check(auth, build)
  end

  def perform_github_integrations(%AuthData{} = auth, %Build{} = build) do
    Checks.finish_check(auth, build)

    with {:ok, prs} <- PullRequests.find_prs_for_build(auth, build) do
      prs
      |> Enum.map(&CommentTemplate.coverage_message(build, &1))
      |> Enum.map(&Comments.add_pr_comment(&1, auth, build))
    end
  end
end
