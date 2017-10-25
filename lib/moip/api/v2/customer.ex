defmodule Moip.Api.V2.Customer do
  @base_path "/customers"

  def create(params), do: Moip.Http.post(url(), params)

  def find(id), do: Moip.Http.get("#{url()}/#{id}")

  def list(), do: Moip.Http.get(url())

  def add_creditcard(id, params), do: Moip.Http.post("#{url()}/#{id}/fundinginstruments", params)

  def remove_creditcard(creditcard_id), do: Moip.Http.delete("#{Moip.Api.V2.get_base_uri()}/fundinginstruments/#{creditcard_id}")

  def url, do: '#{Moip.Api.V2.get_base_uri()}#{@base_path}'
end
