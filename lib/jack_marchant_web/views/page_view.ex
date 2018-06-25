defmodule JackMarchantWeb.PageView do
  use JackMarchantWeb, :view

  def format_date(datetime) do
    Timex.today()
    |> Timex.diff(datetime, :days)
    |> get_date_text(datetime)
  end

  defp get_date_text(days_ago, _) when days_ago == 0, do: "today"
  defp get_date_text(days_ago, _) when days_ago < 30, do: "#{days_ago} days ago"
  defp get_date_text(_, datetime), do: Timex.format!(datetime, "{D} {Mshort} {YY}")
end
