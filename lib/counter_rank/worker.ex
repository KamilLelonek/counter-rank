defmodule CounterRank.Worker do
  use GenServer

  # Client API

  def start_link(default) when is_list(default),
    do: GenServer.start_link(__MODULE__, default, name: __MODULE__)

  # Server Callbacks

  @impl true
  def init(counter), do: {:ok, counter}
end
