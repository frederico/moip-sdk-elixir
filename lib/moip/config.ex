defmodule Moip.Config do

  def basic_auth_token, do: from_env(:moip, :basic_auth_token)
  def basic_auth_secret, do: from_env(:moip, :basic_auth_secret)

  def from_env(otp_app, key, default \\ nil)
  def from_env(otp_app, key, default) do
    otp_app
    |> Application.get_env(key, default)
    |> read_from_system(default)
  end

  defp read_from_system({:system, env}, default), do: System.get_env(env) || default
  defp read_from_system(value, _default), do: value
end
