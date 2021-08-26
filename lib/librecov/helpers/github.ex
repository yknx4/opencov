defmodule Librecov.Helpers.Github do
  @doc """
  Github API returns errors as :ok, convert them back to error

  ## Examples
    iex> Librecov.Helpers.Github.wrap_errors({:ok, %ExOctocat.Model.BasicError{}})
    {:error, %ExOctocat.Model.BasicError{}}
    iex> Librecov.Helpers.Github.wrap_errors({:ok, "foo"})
    {:ok, "foo"}
  """
  def wrap_errors({:ok, %ExOctocat.Model.BasicError{} = e}), do: {:error, e}
  def wrap_errors(r), do: r
end
