defmodule JackMarchant do
  @moduledoc """
  JackMarchant domain logic
  """

  import Ecto.Query

  alias JackMarchant.{Repo, Post, Subscriber}

  require Logger

  @spec get_all_posts() :: list(Post.t())
  def get_all_posts do
    Post
    |> where(published: true)
    |> order_by(desc: :published_date)
    |> Repo.all()
  end

  @spec find_post_by_slug(String.t()) :: Post.t()
  def find_post_by_slug(slug) do
    Post
    |> where(slug: ^slug)
    |> Repo.one()
  end

  @spec upsert_post(map()) :: Post.t()
  def upsert_post(params) do
    Post
    |> Repo.get_by(slug: params.slug)
    |> case do
      nil ->
        %Post{}
        |> Post.changeset(params)
        |> Repo.insert()

      post ->
        post
        |> Post.changeset(params)
        |> Repo.update()
    end
  end

  @spec subscribe(map()) :: Subscriber.t()
  def subscribe(params) do
    %Subscriber{}
    |> Subscriber.changeset(params)
    |> Repo.insert()
    |> case do
      {:ok, subscriber} = result ->
        campaign_monitor_subscribe(subscriber)
        result

      {:error, changeset} ->
        {:error, get_errors(changeset.errors)}
    end
  end

  defp campaign_monitor_subscribe(%{email: email}) do
    Task.start(fn ->
      params = %{email: email, consent_to_track: "Yes"}
      with {:ok, _} <- ExCampaignMonitor.add_subscriber(params) do
        Logger.info("Added subscriber to email list")
      else
        {:error, reason} -> Logger.error(reason)
      end
    end)
  end

  defp get_errors(email: {error, _}) do
    %{email: error}
  end
end
