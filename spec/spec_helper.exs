Code.require_file "fixtures.exs", __DIR__

ESpec.start

ESpec.configure fn(config) ->

  config.before fn ->
    Logger.remove_backend(:console)
  end

  config.finally fn(__) ->
    Logger.add_backend(:console)
  end
end
