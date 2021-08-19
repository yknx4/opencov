# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.InlineObject125 do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :commit_id,
    :body,
    :event,
    :comments
  ]

  @type t :: %__MODULE__{
          :commit_id => String.t() | nil,
          :body => String.t() | nil,
          :event => String.t() | nil,
          :comments =>
            [GitHubV3RESTAPI.Model.ReposOwnerRepoPullsPullNumberReviewsComments.t()] | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.InlineObject125 do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :comments,
      :list,
      GitHubV3RESTAPI.Model.ReposOwnerRepoPullsPullNumberReviewsComments,
      options
    )
  end
end