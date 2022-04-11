defmodule CounterRank.Application do
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args), do: Supervisor.start_link(children(), opts())

  defp children do
    [
      {
        CounterRank.Worker,
        [defaul_counter_value()]
      }
    ]
  end

  defp defaul_counter_value do
    case Application.fetch_env(:counter_rank, :defaul_counter_value) do
      {:ok, defaul_counter_value} ->
        defaul_counter_value

      :error ->
        Logger.warn("No value for `defaul_counter_value` found in config!")
        nil
    end
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: CounterRank.Supervisor
    ]
  end
end
