defmodule Moip.Auth.BasicAuthTest do
  use ExUnit.Case, async: true

  describe "defstruct" do
    test "giving token and secret should return them" do
      auth = %Moip.Auth.BasicAuth{token: 'token', secret: 'secret'}
      assert auth.token == 'token'
      assert auth.secret == 'secret'
    end
  end
end
