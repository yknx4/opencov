# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.CombinedCommitStatus do
  @moduledoc """
  Combined Commit Status
  """

  @derive [Poison.Encoder]
  defstruct [
    :state,
    :statuses,
    :sha,
    :total_count,
    :repository,
    :commit_url,
    :url
  ]

  @type t :: %__MODULE__{
          :state => String.t(),
          :statuses => [GitHubV3RESTAPI.Model.SimpleCommitStatus.t()],
          :sha => String.t(),
          :total_count => integer(),
          :repository => GitHubV3RESTAPI.Model.MinimalRepository.t(),
          :commit_url => String.t(),
          :url => String.t()
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.CombinedCommitStatus do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:statuses, :list, GitHubV3RESTAPI.Model.SimpleCommitStatus, options)
    |> deserialize(:repository, :struct, GitHubV3RESTAPI.Model.MinimalRepository, options)
  end
end