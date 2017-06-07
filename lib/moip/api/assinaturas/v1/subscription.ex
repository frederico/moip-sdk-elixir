defmodule Moip.Api.Assinaturas.V1.Subscription do
  import Moip.Helpers

  @base_path "/subscriptions"

  @moduledoc """
      Assinaturas V1.5 - Endpoint de assinaturas
  """

  @doc """
    Lista as assinatura e retorna um objeto List de %Moip.Resource.Subscription{}
  """
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

  @doc """
    Cria uma assinatura e retorna: {:ok, %{"message" => "Assinatura criada com sucesso"}
    * :params - Map com os attributos obrigatórios de uma assinatura
    * new_vault: true para criar um novo cliente e false para utilizar um existente
  """
  def create(params, new_customer \\ false) do
    create_url = "#{url()}?new_customer=#{new_customer}"
    Moip.Http.post(create_url, params)
  end

  @doc """
    Encontra uma assinatura e retorna: {:ok, %Moip.Resource.Subscription{}}
    * :plan_code - Código da assinatura que você definiu
  """
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
  @doc """
    Atualiza um plano e retorna: {:ok, %{"message" => "Assinatura atualizada com sucesso"}
    * :subscription_code - Código da assinatura que você definiu
    * :params - Recebe um Map com os attributos obrigatórios de uma assinatura
  """
  def update(subscription_code, params) do
    response = Moip.Http.put("#{url()}/#{subscription_code}", params)
    response_message(response, "Assinatura atualizada com sucesso")
  end
  @doc """
    Encontra uma assinatura e marca com status SUSPENDED
    * :subscription_code - Código do assinante que você definiu
  """
  def suspend(subscription_code) do
    response = Moip.Http.put("#{url()}/#{subscription_code}/suspend", %{})
    response_message(response, "Assinatura suspensa com sucesso")
  end

  @doc """
    Encontra uma assinatura e marca com status ACTIVE
    * :subscription_code - Código do assinante que você definiu
  """
  def activate(subscription_code) do
    response = Moip.Http.put("#{url()}/#{subscription_code}/activate",%{})
    response_message(response, "Assinatura reativada com sucesso")
  end

  @doc """
    Encontra uma assinatura e marca com status CANCELED
    * :subscription_code - Código do assinante que você definiu
  """
  def cancel(subscription_code) do
    response = Moip.Http.put("#{url()}/#{subscription_code}/cancel",%{})
    response_message(response, "Assinatura cancelada com sucesso")
  end

  defp url, do: '#{Moip.Api.Assinaturas.V1.get_base_uri()}#{@base_path}'

  defp as_json(json) do
    %Moip.Resource.Subscription{} |> Map.merge(json)
  end

end
