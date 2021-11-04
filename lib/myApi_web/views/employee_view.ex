defmodule MyApiWeb.EmployeeView do
  use MyApiWeb, :view
  alias MyApiWeb.EmployeeView

  def render("index.json", %{employees: employees}) do
    %{data: render_many(employees, EmployeeView, "employee.json")}
  end

  def render("show.json", %{employee: employee}) do
    %{data: render_one(employee, EmployeeView, "employee.json")}
  end

  def render("employee.json", %{employee: employee}) do
    %{id: employee.id,
      name: employee.name,
      age: employee.age,
      department: employee.department,
      file_path: employee.file_path}
  end

  def render("upload.json", %{"upload": upload}) do
    %{data: render_one(upload, EmployeeView, "file.json")}
  end

  def render("file.json", %{"upload": upload}) do
    %{
      type: upload.content_type,
      filname: upload.filename,
      path: upload.path
    }
  end



end
