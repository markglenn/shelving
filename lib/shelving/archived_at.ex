defmodule Shelving.ArchivedAt do
  @type t :: NaiveDateTime.t() | nil

  @spec type :: :naive_datetime
  def type, do: :naive_datetime

  defmacro __using__(_opts) do
    quote do
      require Ecto.Query
      alias Shelving.ArchivedAt

      def unarchived(queryable \\ __MODULE__) do
        queryable
        |> Ecto.Query.where([q], is_nil(q.archived_at))
      end

      def archived(queryable \\ __MODULE__) do
        queryable
        |> Ecto.Query.where([q], not is_nil(q.archived_at))
      end

      def archive_changeset(record) do
        changeset(record, %{archived_at: NaiveDateTime.utc_now()})
      end
    end
  end
end
