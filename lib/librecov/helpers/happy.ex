defmodule Librecov.Helpers.Happy do
  def unwrap({_, bool}),
    do: bool

  def unwrap({_, bool, _}),
    do: bool
end
