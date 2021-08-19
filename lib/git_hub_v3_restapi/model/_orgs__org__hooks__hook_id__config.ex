# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.OrgsOrgHooksHookIdConfig do
  @moduledoc """
  Key/value pairs to provide settings for this webhook. [These are defined below](https://docs.github.com/rest/reference/orgs#update-hook-config-params).
  """

  @derive [Poison.Encoder]
  defstruct [
    :url,
    :content_type,
    :secret,
    :insecure_ssl
  ]

  @type t :: %__MODULE__{
          :url => String.t(),
          :content_type => String.t() | nil,
          :secret => String.t() | nil,
          :insecure_ssl => GitHubV3RESTAPI.Model.WebhookConfigInsecureSsl.t() | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.OrgsOrgHooksHookIdConfig do
  import GitHubV3RESTAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :insecure_ssl,
      :struct,
      GitHubV3RESTAPI.Model.WebhookConfigInsecureSsl,
      options
    )
  end
end