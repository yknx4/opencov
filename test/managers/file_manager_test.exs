defmodule Librecov.FileManagerTest do
  use Librecov.ModelCase

  alias Librecov.File
  alias Librecov.Job
  alias Librecov.FileManager
  alias Librecov.JobManager

  @coverage_lines [0, nil, 3, nil, 0, 1]

  test "changeset with valid attributes" do
    changeset = FileManager.changeset(%File{}, Map.put(params_for(:file), :job_id, 1))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FileManager.changeset(%File{}, %{})
    refute changeset.valid?
  end

  test "empty coverage" do
    job = insert(:job, previous_job: nil)
    file = insert_with_changeset(FileManager, File, :file, coverage_lines: [], job: job)
    assert file.coverage == 0
  end

  test "normal coverage" do
    job = insert(:job, previous_job: nil)

    file =
      insert_with_changeset(FileManager, File, :file, coverage_lines: @coverage_lines, job: job)

    assert file.coverage == 50
  end

  test "set_previous_file when a previous file exists" do
    project = insert(:project)

    previous_build = insert(:build, project: project, build_number: 1)

    previous_job =
      insert(:job,
        job_number: 1,
        build_id: previous_build.id,
        build: nil
      )

    build =
      insert(:build, project: project, build_number: 2, previous_build_id: previous_build.id)

    job = insert_with_changeset(JobManager, Job, :job, job_number: 1, build_id: build.id)
    assert job.previous_job_id == previous_job.id

    previous_file =
      insert_with_changeset(FileManager, File, :file, job_id: previous_job.id, name: "file")

    file = insert_with_changeset(FileManager, File, :file, job_id: job.id, name: "file")

    assert file.previous_file_id == previous_file.id
    assert file.previous_coverage == previous_file.coverage
  end
end
