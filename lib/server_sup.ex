defmodule ServerSup do
  use Supervisor
  @moduledoc """
    Supervisor for the web server
  """

  def start_link do
    {:ok, sup} = Supervisor.start_link(__MODULE__, [], name: :supervisor)   
  end

  def init(_) do
    processes = []
    {:ok, {{:one_for_one, 10, 10}, processes}}
  end
end
