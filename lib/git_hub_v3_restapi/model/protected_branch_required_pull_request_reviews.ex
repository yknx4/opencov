# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.ProtectedBranchRequiredPullRequestReviews do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :url,
    :dismiss_stale_reviews,
    :require_code_owner_reviews,
    :required_approving_review_count,
    :dismissal_restrictions
  ]

  @type t :: %__MODULE__{
          :url => String.t(),
          :dismiss_stale_reviews => boolean() | nil,
          :require_code_owner_reviews => boolean() | nil,
          :required_approving_review_count => integer() | nil,
          :dismissal_restrictions =>
            GitHubV3RESTAPI.Model.ProtectedBranchRequiredPullRequestReviewsDismissalRestrictions.t()
            | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.ProtectedBranchRequiredPullRequestReviews do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :dismissal_restrictions,
      :struct,
      GitHubV3RESTAPI.Model.ProtectedBranchRequiredPullRequestReviewsDismissalRestrictions,
      options
    )
  end
end