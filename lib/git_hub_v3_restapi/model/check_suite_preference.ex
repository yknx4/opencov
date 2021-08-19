# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.CheckSuitePreference do
  @moduledoc """
  Check suite configuration preferences for a repository.
  """

  @derive [Poison.Encoder]
  defstruct [
    :preferences,
    :repository
  ]

  @type t :: %__MODULE__{
          :preferences => GitHubV3RESTAPI.Model.CheckSuitePreferencePreferences.t(),
          :repository => GitHubV3RESTAPI.Model.MinimalRepository.t()
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.CheckSuitePreference do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :preferences,
      :struct,
      GitHubV3RESTAPI.Model.CheckSuitePreferencePreferences,
      options
    )
    |> deserialize(:repository, :struct, GitHubV3RESTAPI.Model.MinimalRepository, options)
  end
end