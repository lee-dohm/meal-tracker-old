defmodule MealTracker.Mixfile do
  use Mix.Project

  @version File.read!("VERSION.md") |> String.strip

  def project do
    [
      app: :meal_tracker,
      version: @version,
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps,
      docs: docs,
      escript: escript,
      homepage_url: "https://github.com/lee-dohm/meal-tracker",
      source_url: "https://github.com/lee-dohm/meal-tracker"
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:timex, "~> 0.17.0"},
      {:coverex, "~> 1.4.1", only: :test},
      {:espec, "~> 0.7.0", only: :test},
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  # Parameters for generating documentation
  defp docs do
    [
      extras: ["README.md", "LICENSE.md"]
    ]
  end

  # Parameters for building a shell executable
  def escript do
    [
      main_module: MealTracker.Cli,
      name: "track",
      path: "bin/track"
    ]
  end
end
