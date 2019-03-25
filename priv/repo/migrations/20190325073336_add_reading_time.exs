defmodule JackMarchant.Repo.Migrations.AddReadingTime do
  use Ecto.Migration

  def change do
    alter table(:post) do
      add(:reading_time, :integer)
    end
  end
end
