defmodule JackMarchant do
  @moduledoc """
  JackMarchant domain logic
  """

  import Ecto.Query

  alias JackMarchant.{Repo, Post}

  def get_all_posts do
    Post
    |> where(published: true)
    |> order_by(desc: :published_date)
    |> Repo.all()
  end

  def find_post_by_slug(slug) do
    Post
    |> where(slug: ^slug)
    |> Repo.one()
  end

  def upsert_post(params) do
    Post
    |> Repo.get_by(slug: params.slug)
    |> IO.inspect()
    |> case do
      nil ->
        IO.inspect(params)

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
