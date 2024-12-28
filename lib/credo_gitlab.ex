defmodule CredoGitlab do
  @moduledoc """
  Documentation for `CredoGitlab`.
  """
  import Credo.Plugin

  alias CredoGitlab.Tasks.ReportCodequality

  @doc """
  Initializes the plugin.
  """
  @spec init(exec :: Credo.Execution.t()) :: Credo.Execution.t()
  def init(exec) do
    append_task(exec, :run_command, ReportCodequality)
  end
end
