defmodule Moip.Api.Assinaturas.V1.Customer do
  import Moip.Helpers

  @base_path "/customers"

  @moduledoc """
      Assinaturas v1.5 - Endpoint de assinantes
  """

  @doc """
    Lista os clientes e retorna um objeto List de %Moip.Resource.Customer{}
  """
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

  @doc """
    Cria um cliente e retorna: {:ok, %{"message" => "Cliente criado com sucesso"}
    * :params - Recebe um Map com os attributos obrigatórios de um assinante
    * :new_vault - true para enviar objeto credit_card e false para não enviar
  """
  def create(params, new_vault \\ false) do
    create_url = "#{url()}?new_vault=#{new_vault}"
    Moip.Http.post(create_url, params)
  end

  @doc """
    Encontra um cliente e retorna: {:ok, %Moip.Resource.Customer{}}
  """
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
  @doc """
    Atualiza um cliente e retorna: {:ok, %{"message" => "Assinante atualizado com sucesso"}
  """
  def update(customer_code, params) do
    response = Moip.Http.put("#{url()}/#{customer_code}", params)
    response_message(response, "Assinante atualizado com sucesso")
  end

  @doc """
    Atualiza um cliente e retorna: {:ok, %{"message" => "Cartão do Assinante atualizado com sucesso"}
  """
  def update_billing_info(customer_code, params) do
    response = Moip.Http.put("#{url()}/#{customer_code}/billing_infos", params)
    response_message(response, "Cartão do assinante atualizado com sucesso")
  end


  defp url, do: '#{Moip.Api.Assinaturas.V1.get_base_uri()}#{@base_path}'

  defp as_json(json) do
    %Moip.Resource.Customer{} |> Map.merge(json)
  end

end
