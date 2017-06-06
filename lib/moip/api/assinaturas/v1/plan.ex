defmodule Moip.Api.Assinaturas.V1.Plan do
  import Moip.Helpers

  @base_path "/plans"

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

  def create(params) do
    Moip.Http.post(url(), params)
  end

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

  def activate(plan_code) do
    response = Moip.Http.put("#{url()}/#{plan_code}/activate", %{})
    response_message(response, "Plano ativado com sucesso.")
  end

  def inactivate(plan_code) do
    response = Moip.Http.put("#{url()}/#{plan_code}/inactivate", %{})
    response_message(response, "Plano desativado com sucesso.")
  end

  def update(plan_code, params) do
    response = Moip.Http.put("#{url()}/#{plan_code}", params)
    response_message(response, "Plano atualizado com sucesso.")
  end

  def url, do: '#{Moip.Api.Assinaturas.V1.get_base_uri()}#{@base_path}'

  def as_json(json) do
    %Moip.Resource.Plan{} |> Map.merge(json)
  end

end
