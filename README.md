# CredoGitlab

Generate GitLab Code Quality report for Credo.

## Installation

This package available in Hex and can be installed by adding `credo_gitlab`
to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credo_gitlab, "~> 0.1.0", only: [:dev, :test], runtime: false}
  ]
end
```

## Scope

This package is used to generate a code quality report compatible
with [GitLab format](https://docs.gitlab.com/ee/ci/testing/code_quality.html).

## Configuration

To generate a report a plugin should be added to your `.credo.exs` file.
This is the basic configuration:

```elixir
%{
  configs: [
    name: "default",
    plugins: [
      {CredoGitlab, []}
    ]
  ]
}
```

With this configuration, a `gl-code-quality-report.json` will be created in the root of your project.
To move it to another position, a `:path` param could be added:

```elixir
%{
  configs: [
    name: "default",
    plugins: [
      {CredoGitlab, [path: "credo/gitlab-report.json"]}
    ]
  ]
}
```

This will create a `gitlab-report.json` file in the `credo` directory.

By default, this plugin uses [Jason](https://hex.pm/packages/jason) to JSON-encode
the issues, but you may use another lib, as long as it exports one of these functions:

- `encode_to_iodata!/1`
- `encode_to_iodata/1`
- `encode!/1`
- `encode/1`

E.g. you may use [Jsonrs](https://hex.pm/packages/jsonrs) like this:

```elixir
%{
  configs: [
    name: "default",
    plugins: [
      {CredoGitlab, [json_library: Jsonrs]}
    ]
  ]
}
```
