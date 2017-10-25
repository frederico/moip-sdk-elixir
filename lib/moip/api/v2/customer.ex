defmodule Moip.Api.V2.Customer do
  @base_path "/customers"

  def list(), do: Moip.Http.get(url())

  def find(customer_id), do: Moip.Http.get("#{url()}/#{customer_id}")

  def create(params), do: Moip.Http.post(url(), params)

  def add_creditcard(customer_id, params), do: Moip.Http.post("#{url()}/#{customer_id}/fundinginstruments", params)

  def remove_creditcard(creditcard_id), do: Moip.Http.delete("#{Moip.Api.V2.get_base_uri()}/fundinginstruments/#{creditcard_id}")

  def url, do: '#{Moip.Api.V2.get_base_uri()}#{@base_path}'
end
