defmodule CredoGitlab.MixProject do
  use Mix.Project

  @source_url "https://gitlab.com/oss5572952/credo-gitlab"

  def project do
    [
      app: :credo_gitlab,
      description: description(),
      version: "1.0.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: @source_url
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:credo, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.2", optional: true}
    ]
  end

  defp description do
    "Credo plugin for exporting GitLab Code Quality reports"
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitLab" => @source_url,
        "Credo" => "https://hex.pm/packages/credo"
      }
    ]
  end
end
