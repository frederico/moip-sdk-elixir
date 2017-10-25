defmodule Moip.Http do

  def start do
    HTTPoison.start
  end

  defp success(status, body) do
    if String.trim(body) == "" do
      {:ok, "{}"}
    else
      {:ok, Poison.decode!(body)}
    end
  end

  defp error(status, body) do
    cond do
      status == 404 ->
      errors = %{message: "Recurso não encontrado"}
      {:error, %{status_code: status, errors: errors} }
      status != 404 ->
      case body do
        "" -> {:error, %{status_code: status, errors: %{}} }
         _ ->
           response = Poison.decode!(body)
           {:error, %{status_code: status, errors: response["errors"]} }
      end
    end
  end
  def get(url) do
    header_options = Moip.Client.header_options
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 50000]
    case HTTPoison.get(url, Map.to_list(header_options), options) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 200 and status < 300 -> success(status, body)
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when (status >= 400 and status < 500) -> error(status, body)
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, %{:code => 500, :message => reason} }
    end
  end

  def post(url, params) do
    header_options = Moip.Client.header_options
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 50000]
    case HTTPoison.post(url, Poison.encode!(params) , Map.to_list(header_options) , options) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 200 and status < 300 -> success(status,body)
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when (status >= 400 and status < 500) -> error(status, body)
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, %{:code => 500, :message => reason} }
    end
  end
  def put(url, params) do
    header_options = Moip.Client.header_options
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 50000]
    case HTTPoison.put(url, Poison.encode!(params) , Map.to_list(header_options) , options) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 200 and status < 300 -> success(status,body)
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when (status >= 400 and status < 500) -> error(status, body)
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, %{:code => 500, :message => reason} }
    end
  end
end
