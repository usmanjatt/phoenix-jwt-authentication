defmodule MyApiWeb.UserControllerTest do
  use MyApiWeb.ConnCase

  alias MyApi.Accounts
  alias MyApi.Accounts.User

  @create_attrs %{
    password_confirmation: "some_password",
    password: "some_password",
    username: "some_username"
  }

  @login_in_attrs_right %{
    password: "some_password",
    username: "some_username"
  }

  @login_in_attrs_wrong %{
    password: "somepassword",
    username: "someusername"
  }

  @login_in_attrs_nil %{password: nil, username: nil}

  # @update_attrs %{
  #   password_hash: "some updated password_hash",
  #   username: "some updated username"
  # }

  @invalid_attrs %{password_hash: nil, username: nil}



  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when create user data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert json_response(conn, 200)["jwt"]

      # conn = get(conn, Routes.user_path(conn, :show, id))

      # assert %{
      #          "id" => id,
      #          "password_hash" => "some password_hash",
      #          "username" => "some username"
      #        } = json_response(conn, 200)
      # describe "update user" do
      #   setup [:create_user]["data"]
    end

    test "renders errors when create user data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "sign_in user" do

    test "renders signin data is right", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_in), user: @login_in_attrs_right)
      assert json_response(conn, 201)["jwt"]
     end

     test "renders signin data is wrong", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_in), user: @login_in_attrs_wrong)
      assert json_response(conn, 401)["error"]
     end

    test "renders when signin data is nil", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_in), user: @login_in_attrs_nil)
      assert json_response(conn, 401)["errors"] != %{}
    end

  end

  # describe "update user" do
  #   setup [:create_user]

  #   test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
  #     conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.user_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "password_hash" => "some updated password_hash",
  #              "username" => "some updated username"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, user: user} do
  #     conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete(conn, Routes.user_path(conn, :delete, user))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.user_path(conn, :show, user))
  #     end
  #   end
  # end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
