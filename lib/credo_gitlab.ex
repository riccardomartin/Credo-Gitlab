defmodule CredoGitlab do
  @moduledoc """
  Documentation for `CredoGitlab`.
  """
  import Credo.Plugin

  alias CredoGitlab.Tasks.ReportCodequality

  # @config_file File.read!(".credo.exs")

  @doc """
  Initializes the plugin.
  """
  @spec init(exec :: Credo.Execution.t()) :: Credo.Execution.t()
  def init(exec) do
    append_task(exec, :run_command, ReportCodequality)

    # exec
    # |> register_default_config(@config_file)
    # |> register_command("report.codequality", ReportCodequality)

    # |> register_cli_switch(:file_name, :string, :f)
  end
end
