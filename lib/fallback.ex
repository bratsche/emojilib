defmodule Emojilib.Fallback do
  defmacro __before_compile__(_env) do
    quote do
      defp swap_with_emoji(word), do: word

      def lookup(_), do: {:error, :not_found}
    end
  end
end
