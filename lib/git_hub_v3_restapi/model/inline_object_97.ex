# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.InlineObject97 do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :use_lfs
  ]

  @type t :: %__MODULE__{
          :use_lfs => String.t()
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.InlineObject97 do
  def decode(value, _options) do
    value
  end
end