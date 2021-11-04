defmodule MyApi.UsersTest do
  use MyApi.DataCase

  alias MyApi.Users

  describe "employees" do
    alias MyApi.Users.Employee

    @valid_attrs %{age: 42, department: "some department", file_path: "some file_path", name: "some name"}
    @update_attrs %{age: 43, department: "some updated department", file_path: "some updated file_path", name: "some updated name"}
    @invalid_attrs %{age: nil, department: nil, file_path: nil, name: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Users.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Users.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Users.create_employee(@valid_attrs)
      assert employee.age == 42
      assert employee.department == "some department"
      assert employee.file_path == "some file_path"
      assert employee.name == "some name"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Users.update_employee(employee, @update_attrs)
      assert employee.age == 43
      assert employee.department == "some updated department"
      assert employee.file_path == "some updated file_path"
      assert employee.name == "some updated name"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_employee(employee, @invalid_attrs)
      assert employee == Users.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Users.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Users.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Users.change_employee(employee)
    end
  end
end
