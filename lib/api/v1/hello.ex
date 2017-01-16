defmodule Auberge.API.V1.Hello do
  @moduledoc false
  use Maru.Router

  namespace :hello do
    get do
      json(conn, %{:hello => "World"})
    end

    params do
      requires :name, type: String
    end
    get ":name" do
      json(conn, %{:hello => params[:name]})
    end
  end
end
