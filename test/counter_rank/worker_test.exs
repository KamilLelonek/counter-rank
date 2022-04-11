defmodule CounterRank.WorkerTest do
  use ExUnit.Case

  alias CounterRank.Worker

  setup do
    Worker.reset()
  end

  describe "state" do
    test "should return an initial emtpy state" do
      default_counter = Application.get_env(:counter_rank, :defaul_counter_value)

      assert %{counters: %{}, default_counter: ^default_counter} = Worker.state()
    end
  end
end
