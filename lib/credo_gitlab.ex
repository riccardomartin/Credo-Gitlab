defmodule CredoGitlab do
  @moduledoc """
  Documentation for `CredoGitlab`.
  """
  import Credo.Plugin

  alias CredoGitlab.Commands.GitlabFormatter

  @doc """
  Initializes the plugin.
  """
  @spec init(exec :: Credo.Execution.t()) :: Credo.Execution.t()
  def init(exec) do
    exec
    |> register_command("report.codequality", GitlabFormatter)
    |> register_cli_switch(:file_name, :string, :f)
  end
end
