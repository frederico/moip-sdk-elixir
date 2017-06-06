defmodule Moip.Api.V2 do
  @production 'https://api.moip.com.br/v2'
  @sandbox 'https://sandbox.moip.com.br/v2'

  def get_base_uri do
    case Mix.env do
      :prod -> @production
      :dev -> @sandbox
      :test -> @sandbox
      _ -> @sandbox
    end
  end
end
