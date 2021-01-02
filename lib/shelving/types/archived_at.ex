defmodule Shelving.Types.ArchivedAt do
  defmacro __using__(_opts) do
    quote do
      import Shelving.Types.ArchivedAt
      require Ecto.Query

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

  defmacro archivable_timestamp() do
    quote do
      field :archived_at, :naive_datetime
    end
  end
end
