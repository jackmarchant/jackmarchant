defmodule JackMarchant.Repo.Migrations.Subscriber do
  use Ecto.Migration

  def change do
    create table(:subscriber) do
      add(:email, :string, null: false)

      timestamps()
    end

    create(unique_index(:subscriber, [:email], name: :subscriber_email_index))
  end
end
