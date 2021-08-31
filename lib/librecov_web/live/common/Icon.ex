defmodule Librecov.Common.Icon do
  use Surface.Component

  prop family, :string, required: true
  prop icon, :string, required: true

  def render(assigns) do
    ~F"""
      <i class={"#{@family} fa-#{@icon}"} />
    """
  end
end
