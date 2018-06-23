defmodule JackMarchant do
  @moduledoc """
  JackMarchant domain logic
  """

  import Ecto.Query

  def get_all_posts do
    JackMarchant.Post
    |> where(published: true)
    |> JackMarchant.Repo.all()
  end

  def find_post_by_slug(slug) do
    JackMarchant.Post
    |> where(slug: ^slug)
    |> JackMarchant.Repo.one()
  end
end
