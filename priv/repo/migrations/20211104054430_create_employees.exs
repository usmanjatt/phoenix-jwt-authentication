defmodule MyApi.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :age, :integer
      add :department, :string
      add :file_path, :string

      timestamps()
    end

  end
end
