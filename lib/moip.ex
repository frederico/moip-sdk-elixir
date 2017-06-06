defmodule Moip do
  def configure!(auth) do
    :application.set_env(:moip, :auth, auth)
  end

  def auth do
    elem(:application.get_env(:moip, :auth),1)
  end
end
