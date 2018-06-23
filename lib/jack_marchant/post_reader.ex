defmodule JackMarchant.PostReader do
  use Task

  require Logger

  def start_link(_) do
    Logger.info(fn -> "Starting JackMarchant.PostReader Task" end)
    Task.start_link(__MODULE__, :run, [])
  end

  def run do
    "priv/posts/*"
    |> Path.wildcard()
    |> Enum.map(&read_file/1)
  end

  defp read_file(path) do
    [metadata, content] =
      path
      |> File.read!()
      |> String.split("---")
      |> List.delete_at(0)

    metadata
    |> process_metadata()
    |> Map.merge(process_content!(content))
    |> Map.update!(:published_date, &NaiveDateTime.from_iso8601!/1)
    |> JackMarchant.upsert_post()
  end

  defp process_content!(markdown) do
    content =
      markdown
      |> String.trim()
      |> Earmark.as_html()
      |> case do
        {:ok, html, []} -> html
        {:error, _, _} -> raise ArgumentError, "Unable to parse Markdown"
      end

    %{content: content}
  end

  defp process_metadata(metadata) do
    metadata
    |> String.split("\n")
    |> List.delete_at(0)
    |> List.delete_at(-1)
    |> Enum.into(%{}, fn line ->
      [key, value] = String.split(line, ": ")
      {String.to_atom(key), value}
    end)
  end
end
