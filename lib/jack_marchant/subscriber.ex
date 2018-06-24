defmodule JackMarchant.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :email
  ]

  @email_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  schema "subscriber" do
    field(:email, :string, null: false)

    timestamps()
  end

  def changeset(subscriber, params) do
    subscriber
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email, message: "already exists")
  end
end
