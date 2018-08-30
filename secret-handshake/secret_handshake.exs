defmodule SecretHandshake do
  @all_commands ["wink", "double blink", "close your eyes", "jump"]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    make_commands([], code, 0)
  end

  @spec make_commands(result :: list, code :: integer, step :: integer) :: list(String.t())
  defp make_commands(result, code, step) when code == 0 or step > 4, do: result

  defp make_commands(result, code, step) when step < 4 do
    case rem(code, 2) do
      0 -> make_commands(result, div(code, 2), step + 1)
      1 -> make_commands(result ++ [Enum.at(@all_commands, step)], div(code, 2), step + 1)
    end
  end

  defp make_commands(result, code, step) when step == 4 do
    if rem(code, 2) == 1, do: Enum.reverse(result), else: result
  end
end
