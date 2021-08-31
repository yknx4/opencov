defmodule Librecov.DataTest do
  use Librecov.ModelCase
  use ExVCR.Mock

  alias Librecov.Data

  setup do
    Application.put_env(:tesla, :adapter, Tesla.Adapter.Ibrowse)
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  describe "repositories" do
    test "list_repositories/1 returns all repositories" do
      use_cassette "list_repositories" do
        {:ok, repos} =
          Data.list_repositories(%{
            provider: "github",
            token: "ghp_qwertyuiasdfghj",
            refresh_token: ""
          })

        assert is_list(repos)

        repos
        |> Enum.each(fn %ExOctocat.Model.Repository{} = r ->
          assert r.id
        end)
      end
    end

    test "list_repositories/1 returns error with invalid token" do
      use_cassette "list_repositories_invalid" do
        {:error, error} =
          Data.list_repositories(%{
            provider: "github",
            token: "ghp_aMdZasdasdasdasdas",
            refresh_token: ""
          })

        assert %ExOctocat.Model.BasicError{message: "Bad credentials"} = error
      end
    end

    test "get_repository!/1 returns the repository with given id with token" do
      use_cassette "get_repository" do
        {:ok, repo} =
          Data.get_repository(
            %{
              provider: "github",
              token: "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",
              refresh_token: ""
            },
            "yknx4",
            "librecov"
          )

        assert repo
      end
    end

    test "get_repository!/1 returns invalid when repo is not avilable" do
      use_cassette "get_repository_invalid" do
        {:error, error} =
          Data.get_repository(
            %{
              provider: "github",
              token: "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",
              refresh_token: ""
            },
            "github",
            "ultra-secret"
          )

        assert %ExOctocat.Model.BasicError{message: "Not Found"} = error
      end
    end
  end
end
