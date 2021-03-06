defmodule CounterRank.Worker do
  @moduledoc """
  A worker representing rank state
  with all the counters and their values.
  """
  use GenServer

  @behaviour CounterRank.API

  @empty_state %{counters: %{}, default_counter: nil}

  # Client API

  def start_link(default) when is_list(default),
    do: GenServer.start_link(__MODULE__, default, name: __MODULE__)

  @impl true
  def incr(counter), do: GenServer.call(__MODULE__, {:incr, counter})

  @impl true
  def rank, do: GenServer.call(__MODULE__, :rank)

  @impl true
  def leaders, do: GenServer.call(__MODULE__, :leaders)

  def reset, do: :sys.replace_state(pid(), &initial_state(&1.default_counter))
  def state, do: :sys.get_state(pid())
  defp pid, do: Process.whereis(__MODULE__)

  # Server Callbacks

  @impl true
  def init([counter]), do: {:ok, initial_state(counter)}

  @impl true
  def handle_call(
        {:incr, counter},
        _from,
        %{counters: counters, default_counter: default_counter} = state
      ) do
    counters = Map.update(counters, counter, default_counter, &(&1 + 1))

    {:reply, Map.get(counters, counter), %{state | counters: counters}}
  end

  @impl true
  def handle_call(:rank, _from, state) do
    rank =
      state
      |> ranking()
      |> sort_by_counter()

    {:reply, rank, state}
  end

  @impl true
  def handle_call(:leaders, _from, state) do
    {_counter, leaders} =
      state
      |> ranking()
      |> max_by_counter()

    {:reply, leaders, state}
  end

  defp initial_state(default_counter),
    do: %{@empty_state | default_counter: default_counter}

  defp ranking(%{counters: counters}) do
    Enum.group_by(
      counters,
      fn {_key, val} -> val end,
      fn {key, _val} -> key end
    )
  end

  defp sort_by_counter(rank), do: Enum.sort_by(rank, fn {counter, _list} -> counter end, &>=/2)

  defp max_by_counter(rank),
    do: Enum.max_by(rank, fn {counter, _leaders} -> counter end, &>=/2, fn -> {nil, []} end)
end
