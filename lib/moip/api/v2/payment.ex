defmodule Moip.Api.V2.Payment do
  @base_path "/payments"

  def create(order_id, params), do: Moip.Http.post("#{Moip.Api.V2.get_base_uri()}/orders/#{order_id}/payments", params)

  def find(id), do: Moip.Http.get("#{url()}/#{id}")

  def list(order_id), do: Moip.Http.get("#{Moip.Api.V2.get_base_uri()}/orders/#{order_id}/payments")

  def url, do: "#{Moip.Api.V2.get_base_uri()}#{@base_path}"
end
