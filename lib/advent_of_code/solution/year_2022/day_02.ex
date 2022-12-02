defmodule AdventOfCode.Solution.Year2022.Day02 do
  @translation %{
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }
  @translation2 %{
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win,
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }
  @points %{rock: 1, paper: 2, scissors: 3}
  @scores %{win: 6, draw: 3, lose: 0}

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn [a, b] -> [@translation[a], @translation[b]] end)
    |> Enum.map(&play_rps(&1))
    |> Enum.sum()
  end

  def play_rps([a, b] = _inputs) when a == b do
    @points[b] + @scores[:draw]
  end

  def play_rps([_a, b] = inputs) do
    outcome =
      case inputs do
        [:rock, :paper] -> :win
        [:rock, :scissors] -> :lose
        [:paper, :scissors] -> :win
        [:paper, :rock] -> :lose
        [:scissors, :rock] -> :win
        [:scissors, :paper] -> :lose
      end

    @points[b] + @scores[outcome]
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(fn [a, b] -> [@translation2[a], @translation2[b]] end)
    |> Enum.map(&play_rps_rigged(&1))
    |> Enum.sum()
  end

  def play_rps_rigged([a, b] = _inputs) when b == :win do
    choose =
      case a do
        :rock -> :paper
        :paper -> :scissors
        :scissors -> :rock
      end

    @points[choose] + @scores[b]
  end

  def play_rps_rigged([a, b] = _inputs) when b == :draw do
    @points[a] + @scores[b]
  end

  def play_rps_rigged([a, b] = _inputs) when b == :lose do
    choose =
      case a do
        :rock -> :scissors
        :paper -> :rock
        :scissors -> :paper
      end

    @points[choose] + @scores[b]
  end

  def parse_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1))
  end
end
