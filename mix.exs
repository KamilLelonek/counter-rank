defmodule CounterRank.MixProject do
  use Mix.Project

  def project do
    [
      app: :counter_rank,
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CounterRank.Application, []}
    ]
  end

  defp deps do
    []
  end
end
