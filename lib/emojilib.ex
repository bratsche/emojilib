defmodule Emojilib do
  HTTPoison.start()

  @before_compile Emojilib.Fallback

  @doc """
  Replace all short names in a string with the appropriate Emoji characters.

  ## Examples

      iex> Emojilib.replace(":rocket: straight to the :crescent_moon:!")
      "🚀 straight to the 🌙!"

  """
  def replace(string) do
    string
    |> String.split(~r/([:])(?:(?=(\\?))\2.)*?\1/, include_captures: true)
    |> Enum.map(&(swap_with_emoji/1))
    |> Enum.join("")
  end

  words =
    "https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji.json"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Enum.map(fn %{"unified" => unified, "short_names" => short_names} = _entry ->
      emoji =
        unified
        |> String.split("-")
        |> Enum.map(fn x ->
          {i, ""} = Integer.parse(x, 16)
          i
        end)
        |> to_string()

      {emoji, short_names}
    end)
    |> Enum.map(fn {emoji, short_names} ->
      Enum.map(short_names, fn short_name ->
        @doc """
        Looks up an Emoji given a short name.

        ## Examples

            iex> Emojilib.lookup("wave")
            {:ok, "👋"}

            iex> Emojilib.lookup("wtf")
            {:error, :not_found}

        """
        def lookup(short_name)
        def lookup(unquote(short_name)), do: {:ok, unquote(emoji)}

        defp swap_with_emoji(":" <> unquote(short_name) <> ":"), do: unquote(emoji)

        short_name
      end)
    end)
    |> List.flatten()

  Module.put_attribute(__MODULE__, :words, words)

  def list() do
    @words
  end
end
