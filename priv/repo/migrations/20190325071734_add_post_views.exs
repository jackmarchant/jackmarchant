defmodule JackMarchant.Repo.Migrations.AddPostViews do
  use Ecto.Migration

  def change do
    alter table(:post) do
      add(:views, :integer, null: false, default: 0)
    end
  end
end
