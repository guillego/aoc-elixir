defmodule AdventOfCode.Solution.Year2021.Day02 do
  def part1(input) do

    {pos, depth} =
    parse_input(input)
    |> Enum.reduce({0, 0}, &process_instruction/2)

    pos*depth
  end


  def part2(input) do

    {_aim, pos, depth} =
    parse_input(input)
    |> Enum.reduce({0, 0, 0}, &process_instruction/2)

    pos*depth
  end

  def process_instruction({"down", value}, {pos, depth}) do
    {pos, depth + value}
  end

  def process_instruction({"up", value}, {pos, depth}) do
    {pos, depth - value}
  end

  def process_instruction({"forward", value}, {pos, depth}) do
    {pos + value, depth}
  end

  def process_instruction({"down", value}, {aim, pos, depth}) do
    {aim + value, pos, depth}
  end

  def process_instruction({"up", value}, {aim, pos, depth}) do
    {aim - value, pos, depth}
  end

  def process_instruction({"forward", value}, {aim, pos, depth}) do
    {aim, pos + value, depth + aim*value}
  end


  defp parse_input(args) do
    args
    |> String.split()
    |> Enum.chunk_every(2, 2)
    |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
  end
end
