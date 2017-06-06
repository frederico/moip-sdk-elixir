defmodule Moip.Helpers do

  def map_list_to_atom map_list do
    Enum.map(map_list, fn(i) -> map_to_atom(i) end)
  end

  def map_to_atom map do
    Map.new(map, fn {k, v} -> {String.to_atom(k), v} end)
  end

  def response_message(response, message) do
    case response do
      {:ok, res} -> {:ok, %{message: message}}
      {:error, err} -> {:error, err}
    end
  end
end
