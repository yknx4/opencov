# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.RepositoryTemplateRepositoryPermissions do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :admin,
    :push,
    :pull
  ]

  @type t :: %__MODULE__{
          :admin => boolean() | nil,
          :push => boolean() | nil,
          :pull => boolean() | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.RepositoryTemplateRepositoryPermissions do
  def decode(value, _options) do
    value
  end
end