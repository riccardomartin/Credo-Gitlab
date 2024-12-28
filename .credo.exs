%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["config/", "lib/"],
        excluded: ["_build/", "deps/"]
      },
      strict: true,
      parse_timeout: 5_000,
      color: true,
    }
  ]
}
