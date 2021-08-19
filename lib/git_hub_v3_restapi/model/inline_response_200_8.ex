# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.InlineResponse2008 do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :total_count,
    :repositories
  ]

  @type t :: %__MODULE__{
          :total_count => float(),
          :repositories => [GitHubV3RESTAPI.Model.MinimalRepository.t()]
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.InlineResponse2008 do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:repositories, :list, GitHubV3RESTAPI.Model.MinimalRepository, options)
  end
end