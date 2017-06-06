defmodule Moip.Api.Assinaturas.V1Test do
  use ExUnit.Case, async: true

  describe "get_base_uri" do
    test "with sandbox parameter should return sandbox url" do
      base = Moip.Api.Assinaturas.V1.get_base_uri
      assert base == 'https://sandbox.moip.com.br/assinaturas/v1'
    end
  end
end
