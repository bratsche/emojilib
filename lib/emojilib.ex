defmodule Emojilib do
  HTTPoison.start()

  @before_compile Emojilib.Fallback

  def replace(string) do
    string
    |> String.split(~r/([:])(?:(?=(\\?))\2.)*?\1/, include_captures: true)
    |> Enum.map(&(swap_with_emoji/1))
    |> Enum.join("")
  end

  words =
    "https://raw.githubusercontent.com/muan/emojilib/main/dist/emoji-en-US.json"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Enum.reduce(%{}, fn {k,v}, acc ->
      Enum.reduce(v, acc, fn x, acc2 ->
        Map.put(acc2, x, k)
      end)
    end)
    |> Enum.map(fn {word, emoji} ->
      def lookup(unquote(word)), do: {:ok, unquote(emoji)}

      defp swap_with_emoji(":" <> unquote(word) <> ":"), do: unquote(emoji)

      word
    end)

  Module.put_attribute(__MODULE__, :words, words)

  def list() do
    @words
  end
end
