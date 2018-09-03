defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @gifts %{
    1 => "a Partridge in a Pear Tree.",
    2 => "two Turtle Doves, ",
    3 => "three French Hens, ",
    4 => "four Calling Birds, ",
    5 => "five Gold Rings, ",
    6 => "six Geese-a-Laying, ",
    7 => "seven Swans-a-Swimming, ",
    8 => "eight Maids-a-Milking, ",
    9 => "nine Ladies Dancing, ",
    10 => "ten Lords-a-Leaping, ",
    11 => "eleven Pipers Piping, ",
    12 => "twelve Drummers Drumming, "
  }

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    prefix = "On the #{ordinal_number(number)} day of Christmas my true love gave to me, "
    (number..1)
    |> Enum.reduce(prefix, fn gift_number, acc ->
      acc <> add_and(gift_number, number) <> @gifts[gift_number]
    end)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    (starting_verse..ending_verse)
    |> Enum.reduce("", fn verse_number, acc ->
      acc <> verse(verse_number) <> add_newline(verse_number, ending_verse)
    end)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp add_and(1, 1), do: ""
  defp add_and(1, _), do: "and "
  defp add_and(_, _), do: ""

  defp add_newline(verse_number, ending_verse) when verse_number != ending_verse, do: "\n"
  defp add_newline(_, _), do: ""

  defp ordinal_number(1), do: "first"
  defp ordinal_number(2), do: "second"
  defp ordinal_number(3), do: "third"
  defp ordinal_number(4), do: "fourth"
  defp ordinal_number(5), do: "fifth"
  defp ordinal_number(6), do: "sixth"
  defp ordinal_number(7), do: "seventh"
  defp ordinal_number(8), do: "eighth"
  defp ordinal_number(9), do: "ninth"
  defp ordinal_number(10), do: "tenth"
  defp ordinal_number(11), do: "eleventh"
  defp ordinal_number(12), do: "twelfth"

end
