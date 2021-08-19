# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.PullRequestMinimalHead do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :ref,
    :sha,
    :repo
  ]

  @type t :: %__MODULE__{
          :ref => String.t(),
          :sha => String.t(),
          :repo => GitHubV3RESTAPI.Model.PullRequestMinimalHeadRepo.t()
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.PullRequestMinimalHead do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:repo, :struct, GitHubV3RESTAPI.Model.PullRequestMinimalHeadRepo, options)
  end
end