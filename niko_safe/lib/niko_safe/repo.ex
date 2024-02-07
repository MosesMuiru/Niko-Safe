defmodule NikoSafe.Repo do
  use Ecto.Repo,
    otp_app: :niko_safe,
    adapter: Ecto.Adapters.Postgres
end
