defmodule SyncDispatch.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :sync_dispatch,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/keathley/sync_dispatch",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SyncDispatch.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
    ]
  end

  defp description do
    """
    SyncDispatch provides a system for Design by Contract in Elixir.
    """
  end

  def package do
    [
      name: "sync_dispatch",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/keathley/sync_dispatch"}
    ]
  end

  def docs do
    [
      main: "SyncDispatch",
      source_ref: "v#{@version}",
      source_url: "https://github.com/keathley/sync_dispatch"
    ]
  end
end
