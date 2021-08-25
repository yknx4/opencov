defmodule Librecov.Services.Github.Files do
  require Logger

  alias ExOctocat.Connection
  alias ExOctocat.Api.Repos
  alias Librecov.Services.Github.AuthData

  def file(%AuthData{token: token, owner: owner, repo: repo}, path, ref) do
    token
    |> Connection.new()
    |> get_content(owner, repo, path, ref: ref)
  end

  defp get_content(connection, owner, repo, path, opts \\ []) do
    optional_params = %{
      :ref => :query
    }

    %{}
    |> ExOctocat.RequestBuilder.method(:get)
    |> ExOctocat.RequestBuilder.url("/repos/#{owner}/#{repo}/contents/#{path}")
    |> ExOctocat.RequestBuilder.add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&ExOctocat.Connection.request(connection, &1)).()
    |> ExOctocat.RequestBuilder.evaluate_response([
      {200, %ExOctocat.Model.ContentFile{}},
      {404, %ExOctocat.Model.BasicError{}},
      {403, %ExOctocat.Model.BasicError{}},
      {302, false}
    ])
  end
end
