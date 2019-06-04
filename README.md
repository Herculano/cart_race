# Cart Race

**Application that defines a result output for a cart race**

## Installation

Install Erlang and Elixir on [official Elixir lang site](https://elixir-lang.org/install.html)

Open project directory and put the log file in the public dir. 

Then run `mix do deps.get, compile`

After compiled, run it, typping the command: `iex -S mix`

To get the results, type in the iex(Elixir Interactive shell) 
 and make a call for this function: `CartRace.result`  

Automatically the results will be wrote on `public/race_output.csv` path/file. So on.

And start to fun! ;)

All the results is generated in the runtime of the application.

Don't need to add any dependency, database or something like that.

This application is a simple running task, that takes advantage of Elixir language benefits.

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cart_race` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cart_race, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cart_race](https://hexdocs.pm/cart_race).

