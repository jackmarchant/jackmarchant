defmodule JackMarchant.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :title,
    :content,
    :slug,
    :blurb,
    :published_date,
    :published,
  ]

  @optional_fields [
    :views,
    :reading_time
  ]

  schema "post" do
    field(:title, :string, null: false)
    field(:content, :string, null: false)
    field(:slug, :string, null: false)
    field(:blurb, :string, null: false)
    field(:published_date, :naive_datetime)
    field(:published, :boolean)
    field(:views, :integer)
    field(:reading_time, :integer)

    timestamps()
  end

  def changeset(post, params) do
    post
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:slug) 
  end
end
