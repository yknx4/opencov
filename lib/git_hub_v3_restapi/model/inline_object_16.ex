# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.InlineObject16 do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :runners
  ]

  @type t :: %__MODULE__{
          :runners => [integer()]
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.InlineObject16 do
  def decode(value, _options) do
    value
  end
end