defmodule JackMarchant.CampaignMonitor do
  @base_api "https://api.createsend.com/api/v3.2"

  def add_subscriber(%{email: email}) do
    url = "#{@base_api}/subscribers/#{campaign_monitor_list_id()}.json"
    body = Jason.encode!(%{"EmailAddress" => email, "ConsentToTrack" => "Yes"})
    do_request(url, body)
  end

  defp do_request(url, body), do: HTTPoison.post(url, body, headers())

  defp token do
    Base.encode64("#{campaign_monitor_api_key()}:x")
  end

  defp headers do
    [
      Authorization: "Basic #{token()}",
      "Content-Type": "application/json",
      Accept: "application/json"
    ]
  end

  defp campaign_monitor_api_key, do: Keyword.fetch!(campaign_monitor_config(), :api_key)
  defp campaign_monitor_list_id, do: Keyword.fetch!(campaign_monitor_config(), :list_id)
  defp campaign_monitor_config, do: Application.get_env(:jack_marchant, :ex_campaign_monitor)
end
