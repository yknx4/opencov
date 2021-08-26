defmodule Librecov.Services.Builds do
  alias Librecov.Repo
  alias Librecov.Build
  import Librecov.Queries.BuildQueries

  use EctoResource

  using_repo(Repo) do
    resource(Build)
  end

  def count_for_project(project_id) do
    query_for_project(project_id)
    |> Repo.aggregate(:count)
  end

  def count_for_project_and_branch(project_id, branch) do
    query_for_project(project_id)
    |> for_branch(branch)
    |> Repo.aggregate(:count)
  end
end
