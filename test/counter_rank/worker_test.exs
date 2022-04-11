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

  describe "incr/1" do
    @counter :counter

    test "should increment a nonexisting counter" do
      assert 1 = Worker.incr(@counter)
    end

    test "should update an existing counter" do
      Worker.incr(@counter)

      assert 2 = Worker.incr(@counter)
    end
  end
end
