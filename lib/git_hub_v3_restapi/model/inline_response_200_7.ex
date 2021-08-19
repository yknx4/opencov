# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.InlineResponse2007 do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :total_count,
    :runner_groups
  ]

  @type t :: %__MODULE__{
          :total_count => float(),
          :runner_groups => [GitHubV3RESTAPI.Model.RunnerGroupsOrg.t()]
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.InlineResponse2007 do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:runner_groups, :list, GitHubV3RESTAPI.Model.RunnerGroupsOrg, options)
  end
end