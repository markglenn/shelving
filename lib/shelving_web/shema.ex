defmodule Shelving.Schema do
  use Absinthe.Schema

  query do
    field :hello, :string, resolve: fn _, _, _ -> {:ok, "Hello World!"} end
  end
end
