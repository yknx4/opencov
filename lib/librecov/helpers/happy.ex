defmodule Librecov.Helpers.Happy do
  @doc """
  Unwraps any tuple.

  ## Examples
    iex> Librecov.Helpers.Happy.unwrap({:ok, "foo"})
    "foo"
    iex> Librecov.Helpers.Happy.unwrap({:ok, "foo", 1})
    "foo"
  """
  def unwrap({_, bool}),
    do: bool

  def unwrap({_, bool, _}),
    do: bool
end
