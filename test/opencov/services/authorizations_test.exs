defmodule Librecov.Services.AuthorizationsTest do
  use ExUnit.Case
  import Mock

  alias Librecov.Services.Authorizations
  alias Librecov.User.Authorization

  describe "ensure_fresh" do
    test "it gets the same token if it is still valid" do
      auth = %Authorization{expires_at: (Timex.now() |> Timex.to_unix()) + 120, token: "token"}
      {:ok, fresh_auth} = Authorizations.ensure_fresh(auth)
      assert auth == fresh_auth
    end

    test "it gets error when refresh token is bad" do
      auth = %Authorization{
        expires_at: (Timex.now() |> Timex.to_unix()) + 120,
        token: nil,
        refresh_token: "my_refresh_token"
      }

      {:error, fresh_auth} = Authorizations.ensure_fresh(auth)
      assert fresh_auth
    end

    test "it gets new token if it is still valid, but token is empty" do
      with_mock OAuth2.Client,
                [:passthrough],
                refresh_token: fn _ ->
                  {:ok,
                   %{
                     token: %OAuth2.AccessToken{
                       access_token: "new_token",
                       expires_at: Timex.now() |> Timex.to_unix(),
                       other_params: %{},
                       refresh_token: "my_refresh_token",
                       token_type: "Bearer"
                     }
                   }}
                end do
        auth =
          EctoFactory.schema(Authorization,
            user_id: nil,
            provider: "github",
            expires_at: (Timex.now() |> Timex.to_unix()) + 120,
            token: nil,
            refresh_token: "my_refresh_token"
          )
          |> Librecov.Repo.insert!()

        {:ok, %Authorization{} = fresh_auth} = Authorizations.ensure_fresh(auth)
        assert auth != fresh_auth
      end
    end

    test "it gets new token if it is expired" do
      with_mock OAuth2.Client,
                [:passthrough],
                refresh_token: fn _ ->
                  {:ok,
                   %{
                     token: %OAuth2.AccessToken{
                       access_token: "new_token",
                       expires_at: Timex.now() |> Timex.to_unix(),
                       other_params: %{},
                       refresh_token: "my_refresh_token",
                       token_type: "Bearer"
                     }
                   }}
                end do
        auth =
          EctoFactory.schema(Authorization,
            user_id: nil,
            provider: "github",
            expires_at: (Timex.now() |> Timex.to_unix()) - 120,
            token: "token",
            refresh_token: "my_refresh_token"
          )
          |> Librecov.Repo.insert!()

        {:ok, %Authorization{} = fresh_auth} = Authorizations.ensure_fresh(auth)
        assert auth != fresh_auth
      end
    end
  end
end
