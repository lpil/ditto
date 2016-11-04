defmodule Ditto.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  defp deps do
    [{:mix_test_watch, ">= 0.0.0", only: [:dev]},
     {:dialyxir, "~> 0.4", only: [:dev]}]
  end
end
