defmodule Bob do
  def hey(input) do
    cond do
      empty?(input) -> "Fine. Be that way!"
      uppercase?(input) and question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      uppercase?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp empty?(string), do: String.strip(string) == ""

  defp uppercase?(string), do: Regex.match?(~r/\p{L}/, string) and String.upcase(string) == string

  defp question?(string), do: String.ends_with?(string, "?")
end
