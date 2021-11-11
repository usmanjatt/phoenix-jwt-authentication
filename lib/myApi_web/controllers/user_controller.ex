defmodule MyApiWeb.UserController do
  use MyApiWeb, :controller

  alias MyApi.Accounts
  alias MyApi.Accounts.User
  alias MyApi.Guardian

  action_fallback MyApiWeb.FallbackController

  def index(conn, _params) do

    IO.inspect("index")
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user)  do

      conn |> render("jwt.json", jwt: token)

      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", Routes.user_path(conn, :show, user))
      # |> render("show.json", user: user)

    end
  end

  #old show action
  # def show(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   render(conn, "show.json", user: user)
  # end

  #new show action
  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
 end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounts.get_user!(id)

  #   with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
  #     render(conn, "show.json", user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)

  #   with {:ok, %User{}} <- Accounts.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end


  def sign_in(conn, %{"user" => user_params}) do
    case Accounts.token_sign_in(user_params) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

end
