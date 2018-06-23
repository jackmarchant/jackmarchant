defmodule JackMarchantWeb.PageView do
  use JackMarchantWeb, :view

  def format_date(datetime) do
    days_ago = Timex.diff(Timex.today(), datetime, :days)

    if days_ago < 30 do
      "#{days_ago} days ago"
    else
      Timex.format!(datetime, "{D} {Mshort} {YY}")
    end
  end
end
