defmodule JackMarchantWeb.PageController do
  use JackMarchantWeb, :controller

  def index(conn, _params) do
    posts = [
      %{
        title: "this is a title",
        blurb: "this is a blurb this is a blurb this is a blurb this is a blurb this is a blurb",
        slug: "/articles/this-is-a-slug",
        published_date: "2018-06-22"
      },
      %{
        title: "this is another title",
        blurb:
          "this is another blurb this is a blurb this is a blurb this is a blurb this is a blurbthis is a blurbthis is a blurb this is a blurb",
        slug: "/articles/slug-another-title",
        published_date: "2018-06-21"
      }
    ]

    render(conn, "posts.html", posts: posts)
  end

  def post(conn, %{"slug" => post_slug}) do
    IO.inspect(post_slug)

    render(
      conn,
      "post.html",
      post: %{
        title: "title goes here",
        content: "<p>hello content</p>"
      }
    )
  end
end
