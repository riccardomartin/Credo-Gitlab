defmodule CredoGitlab.JsonEncoder do
  @moduledoc """
  JSON encoder for GitLab Code Quality reports.
  """

  alias Credo.Execution

  @doc """
  Encodes the issues to JSON.
  """
  @spec encode(issues :: list(map()), exec :: Execution.t()) ::
          String.t() | iodata() | no_return()
  def encode(issues, %Execution{} = exec) do
    exec
    |> Execution.get_plugin_param(CredoGitlab, :json_library)
    |> Kernel.||(Jason)
    |> do_encode(issues)
  end

  @spec do_encode(module :: module(), issues :: list(map())) ::
          String.t() | iodata() | no_return()
  defp do_encode(module, issues) do
    module = Code.ensure_compiled!(module)

    cond do
      function_exported?(module, :encode_to_iodata!, 1) ->
        module.encode_to_iodata!(issues)

      function_exported?(module, :encode_to_iodata, 1) ->
        issues
        |> module.encode_to_iodata()
        |> case do
          {:ok, encoded} -> encoded
          {:error, error} -> raise "Error encoding issues: #{inspect(error)}"
        end

      function_exported?(module, :encode!, 1) ->
        module.encode!(issues)

      function_exported?(module, :encode, 1) ->
        issues
        |> module.encode()
        |> case do
          {:ok, encoded} -> encoded
          {:error, error} -> raise "Error encoding issues: #{inspect(error)}"
        end
    end
  end
end
