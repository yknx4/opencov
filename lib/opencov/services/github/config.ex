defmodule Librecov.Services.Github.Config do
  def config do
    Application.get_env(:librecov, :github, [])
  end

  def github_app_id, do: config() |> Keyword.get(:app_id, "")
  def github_client_id, do: config() |> Keyword.get(:client_id, "")
  def github_client_secret, do: config() |> Keyword.get(:client_secret, "")
  def github_app_name, do: config() |> Keyword.get(:app_name, "")
end
