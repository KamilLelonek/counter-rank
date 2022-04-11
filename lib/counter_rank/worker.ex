defmodule CounterRank.Worker do
  use GenServer

  @empty_state %{counters: %{}, default_counter: nil}

  # Client API

  def start_link(default) when is_list(default),
    do: GenServer.start_link(__MODULE__, default, name: __MODULE__)

  # Server Callbacks

  @impl true
  def init([counter]), do: {:ok, initial_state(counter)}

  defp initial_state(default_counter),
    do: %{@empty_state | default_counter: default_counter}
end
