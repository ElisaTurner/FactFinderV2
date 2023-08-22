defmodule FactFinder.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fact_finder,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:tempfile, "~> 0.1.0"}
    ]
  end
end
