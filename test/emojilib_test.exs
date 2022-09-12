defmodule EmojilibTest do
  use ExUnit.Case
  doctest Emojilib

  test "simple short code replacement" do
    assert Emojilib.replace(":house: on :fire:!") == "🏠 on 🔥!"
  end
end
