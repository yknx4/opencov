defmodule Librecov.FileView do
  use Librecov.Web, :view

  import Librecov.CommonView
  import Scrivener.HTML

  @max_length 20

  def filters do
    %{
      "changed" => "Changed",
      "cov_changed" => "Coverage changed",
      "covered" => "Covered",
      "unperfect" => "Unperfect"
    }
  end

  def class_for_coverage(nil), do: ""
  def class_for_coverage(0), do: "bg-warning"
  def class_for_coverage(_), do: ""

  def content_for_coverage(nil), do: ""
  def content_for_coverage(0), do: "<span class=\"badge rounded-pill bg-danger\">0</span>"

  def content_for_coverage(coverage),
    do: "<span class=\"badge rounded-pill bg-success\">#{coverage}</span>"

  def short_name(name) do
    if String.length(name) < @max_length do
      name
    else
      name
      |> String.split("/")
      |> Enum.reverse()
      |> Enum.reduce({[], 0}, fn s, {n, len} ->
        if len + String.length(s) <= @max_length do
          {[s | n], len + String.length(s)}
        else
          {[String.first(s) | n], len + 1}
        end
      end)
      |> elem(0)
      |> Enum.join("/")
    end
  end
end
