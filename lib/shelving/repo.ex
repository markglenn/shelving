defmodule Shelving.Repo do
  use Ecto.Repo,
    otp_app: :shelving,
    adapter: Ecto.Adapters.Postgres
end
