defmodule Shelving.AuthAccessPipeline do
  use Guardian.Plug.Pipeline,
    module: Shelving.Guardian,
    otp_app: :shelving,
    error_handler: Shelving.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
