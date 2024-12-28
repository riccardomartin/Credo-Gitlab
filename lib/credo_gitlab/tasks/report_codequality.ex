defmodule CredoGitlab.Tasks.ReportCodequality do
  @moduledoc """
  Formatter for GitLab Code Quality reports.
  """
  use Credo.Execution.Task

  alias Credo.Execution
  alias Credo.Issue
  alias CredoGitlab.JsonEncoder

  @impl Credo.Execution.Task
  def call(exec, _opts) do
    exec
    |> Execution.get_command_name()
    |> maybe_run(exec)
  end

  @spec maybe_run(command_name :: String.t(), exec :: Execution.t()) :: Execution.t()
  defp maybe_run(command_name, exec)

  defp maybe_run("suggest", %Execution{} = exec) do
    exec
    |> Execution.get_issues()
    |> Enum.map(&format_issue/1)
    |> JsonEncoder.encode(exec)
    |> write_file(exec)

    exec
  end

  defp maybe_run(_command_name, %Execution{} = exec), do: exec

  @spec format_issue(issue :: map()) :: map()
  defp format_issue(
         %Issue{
           check: check,
           column: column,
           filename: path,
           line_no: line,
           message: description,
           priority: priority
         } = entry
       ) do
    %{
      description: description,
      check_name: check,
      fingerprint: fingerprint(entry),
      severity: severity(priority),
      location: %{
        path: path,
        positions: %{
          begin: %{
            line: line,
            column: column
          }
        }
      }
    }
  end

  @spec fingerprint(entry :: map()) :: String.t()
  defp fingerprint(entry) when is_map(entry) do
    entry
    |> :erlang.term_to_binary()
    |> then(&:crypto.hash(:md5, &1))
    |> Base.encode16(case: :lower)
  end

  @spec severity(value :: integer()) :: String.t()
  defp severity(value)
  defp severity(value) when value >= 30, do: "blocker"
  defp severity(value) when value in 20..29, do: "critical"
  defp severity(value) when value in 10..19, do: "major"
  defp severity(value) when value >= 0, do: "minor"
  defp severity(_), do: "info"

  @spec write_file(data :: iodata() | String.t(), exec :: Execution.t()) :: :ok | no_return()
  defp write_file(data, exec) do
    exec
    |> Execution.get_plugin_param(CredoGitlab, :path)
    |> fix_path()
    |> File.write!(data)
  end

  @spec fix_path(path :: String.t() | any()) :: String.t()
  defp fix_path(path)
  defp fix_path(path) when is_binary(path) and path != "", do: path
  defp fix_path(_path), do: "gl-code-quality-report.json"
end
