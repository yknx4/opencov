ExUnit.start()

Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(Librecov.Repo, :manual)
