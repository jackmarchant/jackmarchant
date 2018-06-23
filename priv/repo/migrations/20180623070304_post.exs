defmodule JackMarchant.Repo.Migrations.Post do
  use Ecto.Migration

  def change do
    create table(:post) do
      add(:title, :string, null: false)
      add(:content, :text, null: false)
      add(:blurb, :string, null: false)
      add(:slug, :string, null: false)
      add(:published_date, :naive_datetime)
      add(:published, :boolean)

      timestamps()
    end

    create(unique_index(:post, [:slug], name: :post_slug_index))
  end
end
