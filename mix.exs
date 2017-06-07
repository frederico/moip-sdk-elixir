defmodule Moip.Mixfile do
  use Mix.Project

  def project do
    [app: :moip,
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :faker]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.0"},
      {:secure_random, "~> 0.5"},
      {:brcpfcnpj, "~> 0.1.0"},
      {:faker, "~> 0.8", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    A few sentences (a paragraph) describing the project.
    """
  end

  defp package do
    [
        name: :moip,
        licenses: ["Apache 2.0"],
        description: "Moip Elixir SDK",
        files: ["lib", "config", "mix.exs", "README*", "LICENSE*"],
        maintainers: ["Frederico Macedo <frederico@negociosimples.com.br>"],
        links: %{"GitHub" => "https://github.com/frederico/moip-sdk-elixir", "Docs" => "https://hexdocs.pm/moip/api-reference.html"}
    ]
  end
end
