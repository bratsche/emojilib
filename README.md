# Emojilib

A very simple library for handling Emoji shortcodes in strings.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `emojilib` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:emojilib, "~> 0.1.0"}
  ]
end
```

## Usage

A simple example:

```elixir
Emojilib.replace(":house: on :fire:!")
"🏠 on 🔥!"
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/emojilib>.

