defmodule Moip.ClientTest do
  import Moip.Auth.BasicAuth
  import Moip.Auth.OAuth
  use ExUnit.Case, async: true

  describe "header_authorization" do
    test "giving basic auth client should return Basic Auth headers" do
      auth = %Moip.Auth.BasicAuth{token: 'token', secret: 'secret'}
      Moip.configure!(auth)

      headers = Moip.Client.header_authorization()
      encodedString = Base.encode64("#{auth.token}:#{auth.secret}")
      headerCheck = %{
        "Content-Type" => "application/json",
        "Authorization" => "Basic #{encodedString}"
      }
      assert headers == headerCheck
    end
    test "giving OAuth client should return OAuth headers" do
      auth = %Moip.Auth.OAuth{oauth_token: 'oauth'}
      Moip.configure!(auth)

      headers = Moip.Client.header_authorization()
      headerCheck = %{
        "Content-Type" => "application/json",
        "Authorization" => "OAuth #{auth.oauth_token}"
      }
      assert headers == headerCheck
    end
  end

  describe "header_options" do
    test "giving header options with Authorization key to client it should include and replace Authorization key" do
      auth = %Moip.Auth.BasicAuth{token: 'token', secret: 'secret'}
      Moip.configure!(auth)

      auth_options = %{
        "Content-Type" => "application/json",
        "Authorization" => "uo"
      }

      opts = Moip.Client.header_options(auth_options)
      assert opts == auth_options
    end
    test "giving header options to client without Authorization key it should have specific Auth header option" do
      auth = %Moip.Auth.BasicAuth{token: 'token', secret: 'secret'}
      Moip.configure!(auth)

      auth_options = %{"yo" => "yo"}

      response = Map.merge(auth_options, %{
          "Content-Type" => "application/json",
          "Authorization" => "Basic #{Base.encode64("#{auth.token}:#{auth.secret}")}"
        })

      opts = Moip.Client.header_options(auth_options )
      assert opts == response
    end

    test "without Authorization options to client it should return auth headers by auth type - Basic Auth" do
      auth = %Moip.Auth.BasicAuth{token: "token", secret: "secret"}
      Moip.configure!(auth)

      response = %{
        "Content-Type" => "application/json",
        "Authorization" => "Basic #{Base.encode64("#{auth.token}:#{auth.secret}")}"
      }
      opts = Moip.Client.header_options()
      assert opts == response
    end
    test "without Authorization options to client it should return auth headers by auth type - OAuth" do
      auth = %Moip.Auth.OAuth{oauth_token: 'oauth'}
      Moip.configure!(auth)

      response = %{
        "Content-Type" => "application/json",
        "Authorization" => "OAuth #{auth.oauth_token}"
      }
      opts = Moip.Client.header_options()
      assert opts == response
    end
  end
end
