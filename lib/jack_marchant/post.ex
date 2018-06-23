defmodule JackMarchant.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :title,
    :content,
    :slug,
    :blurb,
    :published_date,
    :published
  ]

  schema "post" do
    field(:title, :string, null: false)
    field(:content, :string, null: false)
    field(:slug, :string, null: false)
    field(:blurb, :string, null: false)
    field(:published_date, :naive_datetime)
    field(:published, :boolean)

    timestamps()
  end

  def changeset(post, params) do
    post
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:slug, message: "slug: #{inspect(params.slug)} already exists for post")
  end
end
