defmodule Rubin.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    app_dir = Application.app_dir(:rubin)

    go_server_spec =
      Supervisor.child_spec(
        {MuonTrap.Daemon, ["#{app_dir}/priv/server", [], []]},
        id: :go_hello,
        restart: :transient
      )

    Logger.info("running server #{go_server_spec}")

    children = [
      go_server_spec
    ]

    opts = [strategy: :one_for_one, name: Rubin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
