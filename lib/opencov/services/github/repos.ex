defmodule Librecov.Services.Github.Repos do
  require Logger
  import Librecov.Helpers.Github

  alias ExOctocat.Connection
  alias ExOctocat.Api.Repos
  alias Librecov.Services.Github.AuthData

  def available_repos(user_token, params \\ []) do
    user_token
    |> Connection.new()
    |> Repos.repos_list_for_authenticated_user(params)
    |> wrap_errors()
  end

  def repo(%AuthData{token: token, owner: owner, repo: repo}) do
    token
    |> Connection.new()
    |> Repos.repos_get(owner, repo)
    |> wrap_errors()
  end
end
