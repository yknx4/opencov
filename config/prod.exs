import Config

config :tesla, Tesla.Middleware.Logger, filter_headers: ["authorization"]

config :librecov, Librecov.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :librecov, Librecov.Repo,
  adapter: Ecto.Adapters.Postgres,
  ssl: true

config :logger, :console, metadata: [:request_id, :mfa]

config :logger, level: :info

config Librecov.Plug.Github,
  path: "/api/v1/github_webhook",
  action: {Librecov.GithubService, :handle}

config :sentry,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  tags: %{
    env: "production"
  },
  included_environments: ["prod", "staging"]

config :logger, Sentry.LoggerBackend,
  level: :error,
  excluded_domains: [],
  capture_log_messages: true

config :event_bus,
  error_handler: {Librecov.Helpers.SentryErrorLogger, :log}

if File.exists?(Path.join(__DIR__, "prod.secret.exs")) do
  import_config "prod.secret.exs"
end
