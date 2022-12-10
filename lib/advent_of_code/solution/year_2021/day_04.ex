defmodule AdventOfCode.Solution.Year2021.Day04 do
  def part1(input) do
    {numbers, board} = parse_input(input)
    board
  end

  def part2(_input) do
  end


  defp parse_input(input) do
    [numbers_str | boards_str] = String.split(input, "\n\n", trim: true)

    numbers = split_to_int(numbers_str, ",", trim: true)
    board = Enum.map(boards_str, &parse_board(&1))

    {numbers, board}
  end

  defp parse_board(board_str) do
    board_str
    |> String.split("\n", trim: true)
    |> Enum.map(&split_to_int(&1, " ", trim: true))
  end

  defp split_to_int(input, pattern, split_options) do
    input
    |> String.split(pattern, split_options)
    |> Enum.map(&String.to_integer(&1))
  end
end
