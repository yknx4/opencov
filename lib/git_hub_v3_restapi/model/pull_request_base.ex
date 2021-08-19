# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.PullRequestBase do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :label,
    :ref,
    :repo,
    :sha,
    :user
  ]

  @type t :: %__MODULE__{
          :label => String.t(),
          :ref => String.t(),
          :repo => GitHubV3RESTAPI.Model.PullRequestBaseRepo.t(),
          :sha => String.t(),
          :user => GitHubV3RESTAPI.Model.PullRequestHeadRepoOwner.t()
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.PullRequestBase do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:repo, :struct, GitHubV3RESTAPI.Model.PullRequestBaseRepo, options)
    |> deserialize(:user, :struct, GitHubV3RESTAPI.Model.PullRequestHeadRepoOwner, options)
  end
end