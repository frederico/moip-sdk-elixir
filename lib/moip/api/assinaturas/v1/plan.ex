defmodule Moip.Api.Assinaturas.V1.Plan do
  import Moip.Helpers

  @base_path "/plans"

  @moduledoc """
      Assinaturas V1.5 - Endpoint de planos
  """

  @doc """
    Lista os planos e retorna um objeto List de %Moip.Resource.Plan{}
  """
  def list do
    response = Moip.Http.get(url())
    case response do
      {:ok, res} ->
        response_data = res["plans"]
        |> map_list_to_atom
        |> Enum.map(fn (plan) -> as_json(plan) end)
        {:ok, response_data}
      {:error, err} -> {:error, err}
    end
  end

  @doc """
    Cria um plano e retorna: {:ok, %{"message" => "Plano criado com sucesso"}
    * :params - Map com os attributos obrigatórios de um plano
  """
  def create(params) do
    Moip.Http.post(url(), params)
  end

 @doc """
    Encontra um plano e retorna: {:ok, %Moip.Resource.Plan{}}
    * :plan_code - Código do plano que você definiu
  """
  def find(plan_code) do
    response = Moip.Http.get("#{url()}/#{plan_code}")
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
    Encontra um plano e marca com status ACTIVE
    * :plan_code - Recebe o Código do plano que você definiu
  """
  def activate(plan_code) do
    response = Moip.Http.put("#{url()}/#{plan_code}/activate", %{})
    response_message(response, "Plano ativado com sucesso.")
  end

  @doc """
    Encontra um plano e marca com status INACTIVE
    * :plan_code - Recebe o Código do plano que você definiu
  """
  def inactivate(plan_code) do
    response = Moip.Http.put("#{url()}/#{plan_code}/inactivate", %{})
    response_message(response, "Plano desativado com sucesso.")
  end

  @doc """
    Atualiza um plano e retorna: {:ok, %{"message" => "Plano atualizado com sucesso"}
    * :plan_code - Recebe o Código do plano que você definiu
    * :params - Recebe um Map com os attributos obrigatórios de um plano
  """
  def update(plan_code, params) do
    response = Moip.Http.put("#{url()}/#{plan_code}", params)
    response_message(response, "Plano atualizado com sucesso.")
  end

  defp url, do: '#{Moip.Api.Assinaturas.V1.get_base_uri()}#{@base_path}'

  defp as_json(json) do
    %Moip.Resource.Plan{} |> Map.merge(json)
  end

end
