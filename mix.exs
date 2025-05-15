defmodule Emojilib.MixProject do
  use Mix.Project

  @version "0.2.0"
  @description "Utility library for converting shortcodes to Emoji"

  def project do
    [
      app: :emojilib,
      version: @version,
      description: @description,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/bratsche/emojilib"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.5.10"},
      {:jason, "~> 1.3"}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/bratsche/emojilib"
      }
    ]
  end
end
