# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.ContainerMetadata do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :tags
  ]

  @type t :: %__MODULE__{
          :tags => List
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.ContainerMetadata do
  def decode(value, _options) do
    value
  end
end