Maru.Test.start()

ESpec.configure fn(config) ->
  config.before fn(_tags) ->
    :ok # = Ecto.Adapters.SQL.Sandbox.checkout(Auberge.Repo)
  end

  config.finally fn(_shared) ->
    :ok
    # Ecto.Adapters.SQL.Sandbox.checkin(Auberge.Repo, [])
  end
end
