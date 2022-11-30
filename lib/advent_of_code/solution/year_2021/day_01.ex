defmodule AdventOfCode.Solution.Year2021.Day01 do
  alias Enum

  def part1(args) do
    args
    |> parse_input()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> (b > a) end)
  end

  def part2(args) do

    args
    |> parse_input()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> (b > a) end)
  end

  def parse_input(args) do
    args
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
