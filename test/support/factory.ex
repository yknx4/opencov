defmodule Librecov.Factory do
  use ExMachina.Ecto, repo: Librecov.Repo

  def authorization_factory do
    %Librecov.User.Authorization{
      expires_at: Timex.now() |> Timex.to_unix() |> Kernel.+(120),
      provider: ["github"] |> Enum.random(),
      refresh_token: sequence(:refresh_token, &"refresh_token_#{&1}"),
      token: sequence(:token, &"my_secret_token_#{&1}"),
      uid: UUID.uuid1(),
      user: fn -> build(:user) end
    }
  end

  def project_factory do
    %Librecov.Project{
      name: sequence(:name, &"name/#{&1}"),
      base_url: sequence(:base_url, &"https://github.com/tuvistavie/name-#{&1}"),
      current_coverage: 50.0,
      repo_id: sequence(:repo_id, &"github_#{&1}"),
      token: sequence(:token, &"my_secret_token_#{&1}")
    }
  end

  def settings_factory do
    %Librecov.Settings{
      signup_enabled: false,
      restricted_signup_domains: nil,
      default_project_visibility: "internal"
    }
  end

  def user_factory do
    %Librecov.User{
      id: sequence(:id, &(&1 + 2)),
      name: sequence(:name, &"name-#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "my-secure-password"
    }
  end

  def build_factory do
    %Librecov.Build{
      build_number: sequence(:build_number, & &1),
      project: fn -> build(:project) end,
      build_started_at: Timex.now() |> Timex.to_datetime()
    }
  end

  def job_factory do
    %Librecov.Job{
      job_number: sequence(:job_number, & &1),
      build: fn -> build(:build) end
    }
  end

  def file_factory do
    %Librecov.File{
      job: fn -> build(:job) end,
      name: sequence(:name, &"file-#{&1}"),
      source: "return 0",
      coverage_lines: [nil],
      coverage: 0.0
    }
  end

  def badge_factory do
    %Librecov.Badge{
      project: fn -> build(:project) end,
      coverage: 50.0,
      image: "encoded_image",
      format: to_string(Librecov.Badge.default_format())
    }
  end

  def with_project(build) do
    project = insert(:project)
    %{build | project_id: project.id}
  end

  def with_secure_password(user, password) do
    changeset = Librecov.UserManager.changeset(user, %{password: password})
    %{user | password_digest: changeset.changes[:password_digest]}
  end

  def confirmed_user(user) do
    %{user | confirmed_at: Timex.now(), password_initialized: true}
  end

  def insert_with_changeset(manager, model, kind, params \\ %{}) do
    apply(manager, :changeset, [struct(model, []), params_for(kind, params)])
    |> Librecov.Repo.insert!()
  end
end
