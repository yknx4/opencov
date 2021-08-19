# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.ContributorActivityWeeks do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :w,
    :a,
    :d,
    :c
  ]

  @type t :: %__MODULE__{
          :w => integer() | nil,
          :a => integer() | nil,
          :d => integer() | nil,
          :c => integer() | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.ContributorActivityWeeks do
  def decode(value, _options) do
    value
  end
end