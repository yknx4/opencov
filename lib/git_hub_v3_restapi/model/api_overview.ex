# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.ApiOverview do
  @moduledoc """
  Api Overview
  """

  @derive [Poison.Encoder]
  defstruct [
    :verifiable_password_authentication,
    :ssh_key_fingerprints,
    :hooks,
    :web,
    :api,
    :git,
    :packages,
    :pages,
    :importer,
    :actions,
    :dependabot
  ]

  @type t :: %__MODULE__{
          :verifiable_password_authentication => boolean(),
          :ssh_key_fingerprints => GitHubV3RESTAPI.Model.ApiOverviewSshKeyFingerprints.t() | nil,
          :hooks => [String.t()] | nil,
          :web => [String.t()] | nil,
          :api => [String.t()] | nil,
          :git => [String.t()] | nil,
          :packages => [String.t()] | nil,
          :pages => [String.t()] | nil,
          :importer => [String.t()] | nil,
          :actions => [String.t()] | nil,
          :dependabot => [String.t()] | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.ApiOverview do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :ssh_key_fingerprints,
      :struct,
      GitHubV3RESTAPI.Model.ApiOverviewSshKeyFingerprints,
      options
    )
  end
end