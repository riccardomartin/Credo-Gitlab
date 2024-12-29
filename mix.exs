defmodule CredoGitlab.MixProject do
  use Mix.Project

  @source_url "https://gitlab.com/oss5572952/credo-gitlab"
  @mirror_url "https://github.com/riccardomartin/credo-gitlab"

  def project do
    [
      app: :credo_gitlab,
      description: description(),
      version: "0.1.0",
      elixir: ">= 1.12.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "CredoGitlab",
      source_url: @source_url,
      docs: [
        main: "CredoGitlab",
        extras: ["README.md"],
        api_reference: false,
        authors: ["Riccardo Martin"],
        main: "readme"
      ]
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
      maintainers: ["Riccardo Martin"],
      links: %{
        "GitLab" => @source_url,
        "Github" => @mirror_url,
        "Credo" => "https://hex.pm/packages/credo"
      }
    ]
  end
end
