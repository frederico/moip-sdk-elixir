defmodule Moip.Api.V2.Customer do
  @base_path "/customers"
  def list(options), do: Moip.Http.get(url())

  def create(params, options), do: Moip.Http.post(url(), params)

  def url, do: '#{Moip.Api.V2.get_base_uri()}#{@base_path}'

end
