defmodule UDPSocketServer do
  require Logger

  def open(port), do: open(port, 4)

  def open(port, version) do
    {:ok, socket} = Socket.UDP.open(port, [as: :binary, version: version, mode: :passive, reuse: true])

    looper(socket)
  end

  def looper(socket) do
    {:ok, data} = Socket.Datagram.recv(socket, 0)
    _pid = spawn(UDPSocketServer, :serve, [socket, data])

    looper(socket)
  end

  def serve(socket, {data, client}) do
    :ok = Socket.Datagram.send(socket, "received: #{data}", client)
  end
end
