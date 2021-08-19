# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.InlineObject127 do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :message,
    :event
  ]

  @type t :: %__MODULE__{
          :message => String.t(),
          :event => String.t() | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.InlineObject127 do
  def decode(value, _options) do
    value
  end
end