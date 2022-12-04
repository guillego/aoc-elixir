defmodule AdventOfCode.Solution.Year2022.Day04 do
  def part1(input) do
    input
    |> parse_input
    |> Enum.map(&compare_sets(&1))
    |> Enum.sum()
  end

  def compare_sets([{begin1, end1}, {begin2, end2}] = _sets) do
    cond do
      begin1 <= begin2 and end1 >= end2 ->
        1

      begin2 <= begin1 and end2 >= end1 ->
        1

      true ->
        0
    end
  end

  def overlap_sets([{begin1, end1}, {begin2, end2}] = _sets) do
    cond do
      begin1 <= begin2 and end1 >= begin2 ->
        1

      begin2 <= begin1 and end2 >= begin1 ->
        1


      true ->
        0
    end
  end

  def part2(input) do
    input
    |> parse_input
    |> Enum.map(&overlap_sets(&1))
    |> Enum.sum()
  end

  defp split_range(range_str) do
    range_str
    |> Enum.map(&String.split(&1, "-", trim: true))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)

  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.map(&split_range/1)
  end
end
