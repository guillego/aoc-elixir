defmodule AdventOfCode.Solution.Year2022.Day03 do
  defp get_alphabet_range(int_list) do
    int_list
    |> Enum.to_list()
    |> List.to_string()
    |> String.split("", trim: true)
  end

  def get_priority_list do
    lowercase = get_alphabet_range(?a..?z)
    uppercase = get_alphabet_range(?A..?Z)

    letters = lowercase ++ uppercase

    priority_list =
      letters
      |> Enum.zip(1..52)
      |> Map.new()

    priority_list
  end

  def part1(input) do
    priorities = get_priority_list()

    input
    |> parse_input
    |> Enum.map(&split_list_in_half/1)
    |> Enum.map(&find_common_types/1)
    |> Enum.map(fn [x] -> priorities[x] end)
    |> Enum.sum()
  end

  def part2(input) do
    priorities = get_priority_list()

    input
    |> parse_input
    |> Enum.chunk_every(3)
    |> Enum.map(&find_common_types/1)
    |> Enum.map(fn [x] -> priorities[x] end)
    |> Enum.sum()
  end

  defp find_common_types([first, second] = rucksacks) do
    first
    |> Enum.filter(fn x -> x in second end)
    |> Enum.uniq()
  end

  defp find_common_types([first, second, third] = rucksacks) do
    first
    |> Enum.filter(fn x -> x in second and x in third end)
    |> Enum.uniq()
  end

  defp split_list_in_half(items) do
    size = Enum.count(items)
    half = div(size, 2)

    items
    |> Enum.chunk_every(half, half, :discard)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end
end
