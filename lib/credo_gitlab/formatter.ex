defmodule CredoGitlab.Formatter do
  @moduledoc """
  Formatter for GitLab Code Quality reports.
  """
  use Credo.Execution.Task

  alias Credo.Execution

  @spec call(exec :: Credo.Execution.t()) :: Credo.Execution.t()
  def call(%Credo.Execution{} = exec) do
    exec
    |> Execution.get_command_name()
    |> maybe_run(exec)
  end

  @spec maybe_run(command :: String.t(), exec :: Credo.Execution.t()) :: Credo.Execution.t()
  defp maybe_run(command, exec)

  defp maybe_run("suggest", exec) do
    path = Execution.get_plugin_param(exec, CredoGitlab, :path) || "report-gitlab.json"

    exec
    |> Execution.get_issues()
    |> Enum.map(&format_issue/1)
    |> Jason.encode_to_iodata!()
    |> then(&File.write!(path, &1))

    exec
  end

  defp maybe_run(_command, exec), do: exec

  @spec format_issue(issue :: map()) :: map()
  defp format_issue(
         %{
           category: category,
           check: check,
           column: column,
           column_end: column_end,
           filename: path,
           line_no: line,
           message: description,
           priority: priority,
           scope: scope,
           trigger: trigger
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
          },
          end: %{
            line: line,
            column: column_end
          }
        }
      }
    }
  end

  @spec fingerprint(entry :: map()) :: String.t()
  defp fingerprint(entry) do
    entry
    |> :erlang.term_to_binary()
    |> then(&:crypto.hash(:md5, &1))
    |> Base.encode16(case: :lower)
  end

  @spec severity(integer()) :: String.t()
  defp severity(value)
  defp severity(p) when p >= 30, do: "blocker"
  defp severity(p) when p in 20..29, do: "critical"
  defp severity(p) when p in 10..19, do: "major"
  defp severity(p) when p >= 0, do: "minor"
  defp severity(_), do: "info"
end
