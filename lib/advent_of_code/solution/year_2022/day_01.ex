defmodule AdventOfCode.Solution.Year2022.Day01 do
  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn x -> Enum.sum(x) end)
    |> Enum.max()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(fn x -> Enum.sum(x) end)
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(3)
    |> Enum.sum()
  end

  def parse_input(args) do
    args
    |> String.split("\n")
    |> Enum.chunk_by(fn x -> x == "" end)
    |> Enum.filter(fn [a | b] -> a != "" end)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
  end
end
