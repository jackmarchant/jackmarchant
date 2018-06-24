defmodule JackMarchantWeb.PageController do
  use JackMarchantWeb, :controller

  def index(conn, %{"page" => _}) do
    conn
    |> put_flash(:info, "That page does not exist")
    |> index(%{})
  end

  def index(conn, _params) do
    posts = JackMarchant.get_all_posts()

    render(conn, "posts.html", posts: posts)
  end

  def post(conn, %{"slug" => post_slug}) do
    post = JackMarchant.find_post_by_slug(post_slug)

    render(conn, "post.html", post: post)
  end
end
