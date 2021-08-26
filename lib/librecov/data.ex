defmodule Librecov.Data do
  @moduledoc """
  The Data context.
  """

  use Unsafe.Generator,
    docs: false

  import Librecov.Helpers.Happy

  import Ecto.Query, warn: false

  alias Librecov.Services.Github.Repos
  alias Librecov.Services.Github.AuthData

  @unsafe [
    {:list_repositories, 1, :unwrap},
    {:get_repository, 3, :unwrap}
  ]

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories(%{provider: "github", token: token, refresh_token: _refresh_token}) do
    Repos.available_repos(token, sort: "pushed")
  end

  @doc """
  Gets a single repository.

  Raises if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

  """
  def get_repository(
        %{provider: "github", token: token, refresh_token: _refresh_token},
        owner,
        repo
      ) do
    Repos.repo(%AuthData{token: token, owner: owner, repo: repo})
  end

  @doc """
  Returns a data structure for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Todo{...}

  """
  def change_repository(_repository, _attrs \\ %{}) do
    raise "TODO"
  end
end
