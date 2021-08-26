defmodule Librecov.Helpers.Github do
  def wrap_errors({:ok, %ExOctocat.Model.BasicError{} = e}), do: {:error, e}
  def wrap_errors(r), do: r
end
