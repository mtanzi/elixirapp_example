defmodule Server do
  @behaviour :application

  def start(_type, _args) do
    port = 8080
    dispatch = :cowboy_router.compile([
      { :_, [
              {"/", :cowboy_static, {:priv_file, :elixirapp_example, "index.html"}},
              {"/ws", WebsocketHandler, []}
      ] }
    ])

    { :ok, _ } = :cowboy.start_http(:http, 100, [{:port, port}], [{ :env, [{:dispatch, dispatch}]}])
    IO.puts "Started listening on port " <> to_string(port) <> "..."

    ServerSup.start_link
  end

  def stop(_state) do
    :ok
  end

  defp start_app(app) do
    _status = :application.start app
  end

  defp stop_app(app) do
    _status = :application.stop app
  end
end
