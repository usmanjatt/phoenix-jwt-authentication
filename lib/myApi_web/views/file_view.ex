defmodule MyApiWeb.FileView do
  use MyApiWeb, :view
  alias MyApiWeb.FileView

  def render("index.json", %{upload: upload}) do
    %{data: render_one(upload, FileView, "upload.json")}
  end

  def render("upload.json", %{upload: upload}) do
    %{
      type: upload.content_type,
      filname: upload.filename,
      path: upload.path
    }
  end

end
