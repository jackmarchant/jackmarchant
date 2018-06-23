defmodule JackMarchant.Post do
  use Ecto.Schema

  schema "post" do
    field(:title, :string, null: false)
    field(:content, :string, null: false)
    field(:slug, :string, null: false)
    field(:blurb, :string, null: false)
    field(:published_date, :naive_datetime)
    field(:published, :boolean)

    timestamps()
  end
end
