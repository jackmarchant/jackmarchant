defmodule JackMarchant.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(JackMarchant.Repo, []),
      supervisor(JackMarchantWeb.Endpoint, []),
      JackMarchant.PostReader
    ]

    opts = [strategy: :one_for_one, name: JackMarchant.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    JackMarchantWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
