defmodule JackMarchantWeb.PageView do
  use JackMarchantWeb, :view

  def format_date(datetime) do
    Timex.today()
    |> Timex.diff(datetime, :days)
    |> get_date_text(datetime)
  end

  defp get_date_text(days, _) when days == 0, do: "today"
  defp get_date_text(days, _) when days == 1, do: "yesterday"
  defp get_date_text(days, _) when days < 30, do: "#{days} days ago"
  defp get_date_text(_, datetime), do: Timex.format!(datetime, "{D} {Mshort} {YY}")
end
