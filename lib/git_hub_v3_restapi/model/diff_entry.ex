# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule GitHubV3RESTAPI.Model.DiffEntry do
  @moduledoc """
  Diff Entry
  """

  @derive [Poison.Encoder]
  defstruct [
    :sha,
    :filename,
    :status,
    :additions,
    :deletions,
    :changes,
    :blob_url,
    :raw_url,
    :contents_url,
    :patch,
    :previous_filename
  ]

  @type t :: %__MODULE__{
          :sha => String.t(),
          :filename => String.t(),
          :status => String.t(),
          :additions => integer(),
          :deletions => integer(),
          :changes => integer(),
          :blob_url => String.t(),
          :raw_url => String.t(),
          :contents_url => String.t(),
          :patch => String.t() | nil,
          :previous_filename => String.t() | nil
        }
end

defimpl Poison.Decoder, for: GitHubV3RESTAPI.Model.DiffEntry do
  def decode(value, _options) do
    value
  end
end