defmodule Shelving.Guardian do
  use Guardian, otp_app: :shelving

  alias Shelving.Accounts
  alias Shelving.Accounts.Account

  def subject_for_token(%Account{slug: slug, archived_at: nil}, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    {:ok, slug}
  end

  def subject_for_token(_, _) do
    {:error, :invalid_account}
  end

  def resource_from_claims(%{"sub" => id} = _claims) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key.
    case Accounts.get_account(id) do
      nil -> {:error, :not_authenticated}
      resouce -> {:ok, resouce}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :not_authenticated}
  end
end
