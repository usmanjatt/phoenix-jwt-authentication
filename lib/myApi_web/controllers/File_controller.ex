defmodule MyApiWeb.FileController do
  use MyApiWeb, :controller

  action_fallback MyApiWeb.FallbackController

  def index(conn, %{"upload" => upload}) do

    IO.inspect(upload.filename)

    #json(conn, filename)
    render(conn, "upload.json", upload: upload)
  end


end
