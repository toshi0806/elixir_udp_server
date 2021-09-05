defmodule UDPServer.Task do
  use Task

  def start_link(arg) do
    Task.start_link(__MODULE__, :udp_server_run, [arg])
  end

  def udp_server_run(arg) do
#    UDPServer.open(arg)
    UDPSocketServer.open(arg)
  end
end

