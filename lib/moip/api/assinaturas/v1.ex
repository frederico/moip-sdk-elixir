defmodule Moip.Api.Assinaturas.V1 do
  @production 'https://api.moip.com.br/assinaturas/v1'
  @sandbox 'https://sandbox.moip.com.br/assinaturas/v1'

  def get_base_uri do
    case Mix.env do
      :prod -> @production
      :dev -> @sandbox
      :test -> @sandbox
      _ -> @sandbox
    end
  end
end
