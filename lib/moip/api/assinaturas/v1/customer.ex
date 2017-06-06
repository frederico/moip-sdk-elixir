defmodule Moip.Api.Assinaturas.V1.Customer do
  import Moip.Helpers

  @base_path "/customers"

  def list do
    response = Moip.Http.get(url())
    case response do
      {:ok, res} ->
        response_data = res["customers"]
        |> map_list_to_atom
        |> Enum.map(fn (plan) -> as_json(plan) end)
        {:ok, response_data}
      {:error, err} -> {:error, err}
    end
  end

  def create(params, new_vault \\ false) do
    create_url = "#{url()}?new_vault=#{new_vault}"
    Moip.Http.post(create_url, params)
  end

  def find(customer_code) do
    response = Moip.Http.get("#{url()}/#{customer_code}")
    case response do
      {:ok, res} ->
        response_data = res
        |> map_to_atom
        |> as_json
        {:ok, response_data}
      {:error, err} -> {:error, err}
    end
  end

  def update(customer_code, params) do
    response = Moip.Http.put("#{url()}/#{customer_code}", params)
    response_message(response, "Assinante atualizado com sucesso")
  end

  def update_billing_info(customer_code, params) do
    response = Moip.Http.put("#{url()}/#{customer_code}/billing_infos", params)
    response_message(response, "Cartão do assinante atualizado com sucesso.")
  end


  def url, do: '#{Moip.Api.Assinaturas.V1.get_base_uri()}#{@base_path}'

  def as_json(json) do
    %Moip.Resource.Customer{} |> Map.merge(json)
  end

end
