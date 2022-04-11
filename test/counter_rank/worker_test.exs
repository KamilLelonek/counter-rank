defmodule CounterRank.WorkerTest do
  use ExUnit.Case

  alias CounterRank.Worker

  @counter :counter

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
    test "should increment a nonexisting counter" do
      assert 1 = Worker.incr(@counter)
    end

    test "should update an existing counter" do
      Worker.incr(@counter)

      assert 2 = Worker.incr(@counter)
    end
  end

  describe "rank/0" do
    @counter2 :counter2

    test "should return an initial rank" do
      assert [] == Worker.rank()
    end

    test "should return a rank of a single counter" do
      range = 4
      for _ <- 1..range, do: Worker.incr(@counter)

      assert [{^range, [@counter]}] = Worker.rank()
    end

    test "should return a rank of elements with the same counter" do
      Worker.incr(@counter)
      Worker.incr(@counter2)

      assert [{1, [@counter, @counter2]}] = Worker.rank()
    end

    test "should return a rank of elements with different counters" do
      Worker.incr(@counter)
      Worker.incr(@counter2)
      Worker.incr(@counter2)

      assert [{1, [@counter]}, {2, [@counter2]}] = Worker.rank()
    end
  end
end
