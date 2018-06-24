defmodule JackMarchant do
  @moduledoc """
  JackMarchant domain logic
  """

  import Ecto.Query

  alias JackMarchant.{Repo, Post}

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
end
