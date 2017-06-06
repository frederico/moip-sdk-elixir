defmodule Moip.Client do
  import Moip.Auth.BasicAuth
  import Moip.Auth.OAuth
  import Poison.Encode


  def header_authorization do
    auth = Moip.auth
    header = case auth do
      %Moip.Auth.OAuth{oauth_token: token } -> header_oauth_token(token)
      %Moip.Auth.BasicAuth{token: token, secret: secret } -> header_basic_auth(token, secret)
    end
  end

  def header_options do
    header_content_type = %{"Content-Type" => "application/json"}
    Map.merge(header_content_type, header_authorization())
  end

  def header_options(opts) do
    Map.merge(header_authorization(), opts)
  end


  defp header_basic_auth(token, secret) do
    basic_auth = "#{token}:#{secret}"
    encodedString = Base.encode64(basic_auth)
    %{
      "Content-Type" => "application/json",
      "Authorization" => "Basic #{encodedString}"
    }
  end

  defp header_oauth_token(oauth_token) do
    %{
      "Content-Type" => "application/json",
      "Authorization" => "OAuth #{oauth_token}"
    }
  end
end
