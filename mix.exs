defmodule CredoGitlab.MixProject do
  use Mix.Project

  def project do
    [
      app: :credo_gitlab,
      description: "Credo plugin for exporting GitLab Code Quality reports",
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, ">= 0.0.0"},
      {:jason, "~> 1.2"}
    ]
  end
end
