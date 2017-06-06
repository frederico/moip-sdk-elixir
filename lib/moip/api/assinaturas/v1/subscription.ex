defmodule Moip.Api.Assinaturas.V1.Subscription do
  import Moip.Helpers

  @base_path "/subscriptions"

  def list do
    response = Moip.Http.get(url())
    case response do
      {:ok, res} ->
        response_data = res["subscriptions"]
        |> map_list_to_atom
        |> Enum.map(fn (plan) -> as_json(plan) end)
        {:ok, response_data}
      {:error, err} -> {:error, err}
    end
  end

  def create(params, new_customer \\ false) do
    create_url = "#{url()}?new_customer=#{new_customer}"
    Moip.Http.post(create_url, params)
  end

  def find(subscription_code) do
    response = Moip.Http.get("#{url()}/#{subscription_code}")
    case response do
      {:ok, res} ->
        response_data = res
        |> map_to_atom
        |> as_json
        {:ok, response_data}
      {:error, err} -> {:error, err}
    end
  end

  def update(subscription_code, params) do
    response = Moip.Http.put("#{url()}/#{subscription_code}", params)
    response_message(response, "Assinatura atualizada com sucesso")
  end

  def suspend(subscription_code) do
    response = Moip.Http.put("#{url()}/#{subscription_code}/suspend", %{})
    response_message(response, "Assinatura suspensa com sucesso")
  end

  def activate(subscription_code) do
    response = Moip.Http.put("#{url()}/#{subscription_code}/activate",%{})
    response_message(response, "Assinatura reativada com sucesso")
  end

  def cancel(subscription_code) do
    response = Moip.Http.put("#{url()}/#{subscription_code}/cancel",%{})
    response_message(response, "Assinatura cancelada com sucesso")
  end

  def url, do: '#{Moip.Api.Assinaturas.V1.get_base_uri()}#{@base_path}'

  def as_json(json) do
    %Moip.Resource.Subscription{} |> Map.merge(json)
  end

end
