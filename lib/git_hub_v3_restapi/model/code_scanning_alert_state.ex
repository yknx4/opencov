# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.CodeScanningAlertState do
  @moduledoc """
  State of a code scanning alert.
  """

  @derive [Poison.Encoder]
  defstruct []

  @type t :: %__MODULE__{}
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.CodeScanningAlertState do
  def decode(value, _options) do
    value
  end
end