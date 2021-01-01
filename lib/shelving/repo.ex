defmodule Shelving.Repo do
  use Ecto.Repo,
    otp_app: :shelving,
    adapter: Ecto.Adapters.Postgres

  @spec archive(struct) :: {:ok, struct} | {:error, Ecto.Changeset.t()}
  def archive(%struct{} = record) do
    record
    |> struct.archive_changeset()
    |> update()
  end
end
