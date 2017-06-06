defmodule Moip.Api.V2Test do
  use ExUnit.Case, async: true

  describe "get_base_uri" do
    test "with sandbox parameter should return sandbox url" do
      base = Moip.Api.V2.get_base_uri
      assert base == 'https://sandbox.moip.com.br/v2'
    end
  end
end
