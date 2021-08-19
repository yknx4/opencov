# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.CommitStats do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :additions,
    :deletions,
    :total
  ]

  @type t :: %__MODULE__{
          :additions => integer() | nil,
          :deletions => integer() | nil,
          :total => integer() | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.CommitStats do
  def decode(value, _options) do
    value
  end
end