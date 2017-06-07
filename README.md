# Moip SDK Elixir

O jeito mais simples e rápido de integrar o Moip e sua aplicação Elixir

Segue a documentação em https://hexdocs.pm/moip/api-reference.html

## Instalação

  * Adicione `moip` na sua lista de dependências em `mix.exs`:

    ```elixir
    def deps do
      [{:moip, "~> 0.1.0"}]
    end
    ```

  * Instale com o comando `mix deps.get`

  * Carregue a biblioteca `moip` antes da sua aplicação:

    ```elixir
    def application do
      [applications: [:moip]]
    end
    ```

  * Adiocione a sua chave moip em `config/prod.exs` ou `config/dev.exs`

 ```elixir

 use Mix.Config

 config :moip,
   basic_auth_token: '<seu token>',
   basic_auth_secret: '<sua secret auth>'
```

## Moip v1 Assinaturas


## Planos


### Criar um plano


#### Response
``` {:ok, %{"message" => "Plano criado com sucesso"}} ```


#### Exemplo:

```elixir
  plan =  %{code: "plan code", name: "plan name", amount: 1990, status: "ACTIVE", payment_method: "CREDIT_CARD" }
  case Moip.Api.Assinaturas.V1.Plan.create(plan) do
     {:ok, response} ->
       response
     {:error, errors} ->
       errors
   end
```


### Listar Planos


#### Response
``` {:ok, [%Moip.Resource.Plan{}]} ```


#### Exemplo:

```elixir
  case Moip.Api.Assinaturas.V1.Plan.list() do
     {:ok, response} ->
       response
     {:error, errors} ->
       errors
   end
```