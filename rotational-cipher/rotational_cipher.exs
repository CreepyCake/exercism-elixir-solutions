defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(fn char ->
      cond do
        Enum.member?(?z..?a, char) -> rem(char - ?a + shift, 26) + ?a
        Enum.member?(?Z..?A, char) -> rem(char - ?A + shift, 26) + ?A
        true -> char
      end
    end)
    |> List.to_string
  end
end
