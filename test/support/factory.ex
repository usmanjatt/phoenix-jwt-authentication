defmodule MyApi.Factory do

  #defmodule Priv do
    use ExMachina.Ecto, repo: MyApi.Repo
    use MyApi.UserFactory
  #end

  def insert(table, params \\ [], opts \\ [prefix: "dasmen"]) do
    insert(table, params, opts)
  end

  # def build(table, params \\ []) do
  #   build(table, params)
  # end

  # def admin_with_access(property_ids, admin_options \\ []) do
  #   Priv.admin_with_access(property_ids, admin_options)
  # end

end
