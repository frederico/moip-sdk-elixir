defmodule Moip.Api.V2.Order do
  @base_path "/orders"

  def create(params), do: Moip.Http.post(url(), params)

  def find(id), do: Moip.Http.get("#{url()}/#{id}")

  def list(), do: Moip.Http.get(url())

  def url, do: "#{Moip.Api.V2.get_base_uri()}#{@base_path}"
end
