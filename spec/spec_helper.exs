ESpec.start

# Require all files in the `spec/support` directory
support_dir = Path.join(__DIR__, "support")
File.ls!(support_dir)
  |> Enum.each fn(file) -> Code.require_file(file, support_dir) end

ESpec.configure fn(config) ->

  config.before fn ->
    Logger.remove_backend(:console)
  end

  config.finally fn(__) ->
    Logger.add_backend(:console)
  end
end
