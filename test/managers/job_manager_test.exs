defmodule Librecov.JobManagerTest do
  use Librecov.ModelCase

  alias Librecov.Job
  alias Librecov.JobManager

  test "changeset with valid attributes" do
    changeset = JobManager.changeset(%Job{}, Map.put(params_for(:job), :build_id, 1))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = JobManager.changeset(%Job{}, %{})
    refute changeset.valid?
  end

  test "set_job_number" do
    previous_job = insert(:job) |> Repo.preload(:build)

    job =
      insert_with_changeset(JobManager, Job, :job,
        job_number: nil,
        build_id: previous_job.build.id
      )

    assert job.job_number == previous_job.job_number + 1
  end

  test "create_from_json!" do
    dummy_coverage = Librecov.Fixtures.dummy_coverage()
    job = JobManager.create_from_json!(insert(:build), dummy_coverage)
    assert job.id != nil
    assert Enum.count(job.files) == Enum.count(dummy_coverage["source_files"])
    assert job.files_count == Enum.count(dummy_coverage["source_files"])
    assert job.coverage > 90
  end

  test "set_previous_values when no previous job exists" do
    job = insert(:job)
    assert job.previous_job_id == nil
  end

  test "set_previous_values when a previous job exists" do
    project = insert(:project)
    build_1 = insert(:build, project: project, build_number: 1)
    build_2 = insert(:build, project: project, build_number: 2, previous_build_id: build_1.id)

    previous_job =
      insert_with_changeset(JobManager, Job, :job, job_number: 1, build_id: build_1.id)

    job = insert_with_changeset(JobManager, Job, :job, job_number: 1, build_id: build_2.id)
    assert job.previous_job_id == previous_job.id
    assert job.previous_coverage == previous_job.coverage
  end
end
