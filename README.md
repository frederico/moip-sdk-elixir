# Moip

O jeito mais simples e rápido de integrar o Moip e sua aplicação Elixir

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