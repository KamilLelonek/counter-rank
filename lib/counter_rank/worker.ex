defmodule CounterRank.Worker do
  use GenServer

  @behaviour CounterRank.API

  @empty_state %{counters: %{}, default_counter: nil}

  # Client API

  def start_link(default) when is_list(default),
    do: GenServer.start_link(__MODULE__, default, name: __MODULE__)

  @impl true
  def incr(counter), do: GenServer.call(__MODULE__, {:incr, counter})

  # Server Callbacks

  @impl true
  def init([counter]), do: {:ok, initial_state(counter)}

  @impl true
  def handle_call({:incr, counter}, _from, state) do
    {:reply, state, state}
  end

  defp initial_state(default_counter),
    do: %{@empty_state | default_counter: default_counter}
end
