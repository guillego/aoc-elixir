defmodule AdventOfCode.Solution.Year2022.Day06 do
  def part1(input) do
    chunk_size = 4

    first_unique =
      input
      |> parse_input()
      |> Enum.chunk_every(chunk_size, 1, :discard)
      |> Enum.find_index(fn x -> length(Enum.uniq(x)) == length(x) end)

    first_unique + chunk_size
  end

  def part2(input) do
    chunk_size = 14

    first_unique =
      input
      |> parse_input()
      |> Enum.chunk_every(chunk_size, 1, :discard)
      |> Enum.find_index(fn x -> length(Enum.uniq(x)) == length(x) end)

    first_unique + chunk_size
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> hd()
    |> String.split("", trim: true)
  end
end
