defmodule MyApi.UserControllerTest do

  use MyApiWeb.ConnCase
  # You can also import this in your MyApp.ConnCase if using Phoenix

  import MyApi.Factory

  @login_in_attrs %{
    password: "pwdpwdpwd",
    username: "user"
  }


  setup do
    user = insert(:users)

    {:ok, user: user}
  end

  test "POST /api/v1/sign_up", %{conn: conn, user: user} do
    #IO.inspect(user)

    new_profile = %{
      "username" => user.username,
      "password" => user.password,
      "password_confirmation" => user.password_confirmation
    }

    conn = post(conn, Routes.user_path(conn, :create), user: new_profile)
    assert json_response(conn, 422)["errors"]

  end

  test "POST /api/v1/sign_in", %{conn: conn, user: user} do

    login_profile = %{
      "username" => user.username,
      "password" => user.password
    }

    IO.inspect(login_profile)
    IO.inspect(@login_in_attrs)

    conn = post(conn, Routes.user_path(conn, :sign_in), user: @login_in_attrs)
    assert json_response(conn, 401)["error"]

  end

end




# defmodule AppCountWeb.Requests.API.V1.AdminProfileTest do
#   use AppCountWeb.ConnCase

#   @base_url "https://administration.example.com/api/v1/profiles"
#   setup do
#     admin = insert(:admin)
#     profile = insert(:profile, admin: admin)
#     admin_without_profile = insert(:admin)
#     alert = insert(:alert, admin: admin)
#     {:ok, admin: admin, profile: profile, admin_without_profile: admin_without_profile, alert: alert}
#   end

#   test "POST /api/v1/profiles", ~M[conn, admin_without_profile] do
#     new_profile = %{
#       "admin_id" => admin_without_profile.id,
#       "bio" => "My Bio",
#       "title" => "My Title"
#     }

#     params = %{"profile" => new_profile}

#     response =
#       conn
#       |> admin_api_request(admin_without_profile)
#       |> post(@base_url, params)
#       |> json_response(200)

#     assert response["id"]
#     assert response["bio"] == new_profile["bio"]
#     assert response["title"] == new_profile["title"]

#     assert response["admin"]["id"] == new_profile["admin_id"]
#     assert response["admin"]["name"] == admin_without_profile.name
#     assert response["admin"]["email"] == admin_without_profile.email
#   end

#   test "GET /api/v1/profiles/by-admin/:admin_id", ~M[conn, admin, profile] do
#     response =
#       conn
#       |> admin_api_request(admin)
#       |> get(@base_url <> "/by-admin/#{admin.id}")
#       |> json_response(200)

#     assert response

#     assert response["id"] == profile.id
#     assert response["bio"] == profile.bio
#     assert response["title"] == profile.title

#     assert response["admin"]["id"] == admin.id
#     assert response["admin"]["name"] == admin.name
#     assert response["admin"]["email"] == admin.email
#   end

#   test "PATCH /api/v1/profiles/:id", ~M[conn, admin, profile] do
#     update_profile = %{
#       "bio" => "My new Bio",
#       "title" => "My new Title"
#     }

#     params = %{"profile" => update_profile}

#     response =
#       conn
#       |> admin_api_request(admin)
#       |> patch(@base_url <> "/#{profile.id}", params)
#       |> json_response(200)

#     assert response

#     assert response["id"] == profile.id
#     assert response["bio"] == update_profile["bio"]
#     assert response["title"] == update_profile["title"]

#     assert response["admin"]["id"] == admin.id
#     assert response["admin"]["name"] == admin.name
#     assert response["admin"]["email"] == admin.email
#   end

#   test "GET /api/v1/profiles/get-alerts/:admin_id", ~M[conn, admin, alert] do
#     response =
#       conn
#       |> admin_api_request(admin)
#       |> get(@base_url <> "/get-alerts/#{admin.id}")
#       |> json_response(200)
#       |> hd()

#     assert response

#     assert response["id"] == alert.id
#     assert response["note"] == alert.note
#     assert response["sender"] == alert.sender
#   end
# end
