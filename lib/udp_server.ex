defmodule UDPServer do
  require Logger

  def open(port), do: open(port, :inet)

  def open(port, family) do
    {:ok, socket} = :gen_udp.open(port, [:binary, family, active: false, reuseaddr: true])

    looper(socket)
  end

  def looper(socket) do
    {:ok, data} = :gen_udp.recv(socket, 0)
    _pid = spawn(UDPServer, :serve, [socket, data])

    looper(socket)
  end

  def serve(socket, {host, port, data}) do
    :ok = :gen_udp.send(socket, host, port, "received: #{data}")
  end
end
