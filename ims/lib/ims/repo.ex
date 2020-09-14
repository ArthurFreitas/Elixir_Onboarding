defmodule Ims.Repo do
  use Ecto.Repo,
    otp_app: :ims,
    adapter: Mongo.Ecto
end
