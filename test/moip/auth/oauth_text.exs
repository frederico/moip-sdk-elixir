defmodule Moip.Auth.OAuthTest do
  use ExUnit.Case, async: true

  describe "defstruct" do
    test "giving token and secret should return them" do
      auth = %Moip.Auth.OAuth{oauth_token: 'token'}
      assert auth.oauth_token == 'token'
    end
  end
end
