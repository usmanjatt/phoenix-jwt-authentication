defmodule MyApi.Users.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :age, :integer
    field :department, :string
    field :file_path, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :age, :department, :file_path])
    |> validate_required([:name, :age, :department])
  end
end
