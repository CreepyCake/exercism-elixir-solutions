defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @doc """
    Two guard clauses that check if word begins with vowel group
    like "xr" or "yt" or has "qu" after first consonant
  """
  defmacro qu_case(first, second) do
    quote do
      unquote(first) == "q" and unquote(second) == "u"
    end
  end

  defmacro xy_case(first) do
    quote do
      unquote(first) == "x" or unquote(first) == "y"
    end
  end

  @vowels ~w(a e i o u)

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  defp do_translate(<<first::binary-size(1), _::binary>> = word) do
    case is_vowel?(first) do
      {true, _vowel} -> build_vowel_word(word)
      {false, _consonant} -> check_consonants(word, "")
    end
  end

  defp is_vowel?(letter), do: {Enum.member?(@vowels, letter), letter}

  defp check_consonants("", suffix), do: build_consonant_word("", suffix)

  @doc """
    PigLatin.translate("quack") == "ackquay"
    PigLatin.translate("square") == "aresquay"
  """
  defp check_consonants(<<first::binary-size(1), second::binary-size(1), rest::binary>>, suffix) when qu_case(first, second) do
    build_consonant_word(rest, suffix <> "qu")
  end


  @doc """
    PigLatin.translate("xylophon") == "ylophonxay"
    PigLatin.translate("xray") == "xrayay"
    PigLatin.translate("yellow") == "ellowyay"
    PigLatin.translate("yttrium") == "yttriumay"
  """
  defp check_consonants(<<first::binary-size(1), second::binary-size(1), rest::binary>> = word, suffix) when xy_case(first) do
    case is_vowel?(second) do
      {true, _vowel} -> build_consonant_word(second <> rest, first)
      {false, _consonant} -> build_vowel_word(word)
    end
  end

  defp check_consonants(<<first::binary-size(1), rest::binary>> = word, suffix) do
    case is_vowel?(first) do
      {true, _vowel} -> build_consonant_word(word, suffix)
      {false, letter} -> check_consonants(rest, suffix <> letter)
    end
  end

  defp build_vowel_word(word), do: word <> "ay"

  defp build_consonant_word(rest, suffix), do: rest <> suffix <> "ay"
end
