# counter_rank

## Description

  * The ranking of counters is kept in memory.

  * Every time a counter is incremented, the ranking has to be updated too.

  * Different counters may have the same value, hence, they will share the
    same ranking.

  * The leaders are the counters at first place.

The exercise consists to implement the `CounterRank.API` behaviour in the best
possible way, keeping in mind the expected worst case complexity.

## Usage

For the usage see the following files:

* [`api.ex`](lib/counter_rank/api.ex)
* [worker_test.exs`](test/counter_rank/worker_test.exs)


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `counter_rank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:counter_rank, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/counter_rank>.
