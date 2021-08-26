defmodule Librecov.Parser.Highlight do
  require Logger
  alias Librecov.File, as: InternalFile

  def parse(%InternalFile{source: string, coverage_lines: coverage_lines}) do
    with {:ok, styled_code} <- NodeJS.call("#{File.cwd!()}/code.js", [string]) do
      lines_with_style = styled_code |> String.split("\n")

      if length(lines_with_style) != length(coverage_lines) do
        Logger.warn(
          "File content and coverage differs in line count. Content Lines: #{length(lines_with_style)} Coverage Lines: #{length(coverage_lines)}"
        )
      end

      Enum.zip(lines_with_style, coverage_lines)
    end
  end
end
