defmodule MyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :password_hash, :string
    field :username, :string

      # Virtual fields:
      field :password, :string, virtual: true
      field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :password_confirmation])
    |> validate_required([:username, :password, :password_confirmation])
    |> validate_length(:password, min: 8)       # Check that password length is >= 8
    |> validate_confirmation(:password)         # Check that password === password_confirmation
    |> unique_constraint(:username)
    |> put_password_hash                        # Add put_password_hash to changeset pipeline

  end


  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end



end
