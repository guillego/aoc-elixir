defmodule AdventOfCode.Solution.Year2022.Day06Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Solution.Year2022.Day06

  setup do
    [
      input: """
      mjqjpqmgbljsphdztnvjfqwrcgsmlb
      """,

      input2: """
      bvwbjplbgvbhsrlpgdmjqwftvncz
      """
    ]
  end

  test "part1a", %{input: input} do
    result = part1(input)

    assert result == 7
  end

  test "part1b", %{input2: input} do
    result = part1(input)

    assert result == 5
  end

  test "part2a", %{input: input} do
    result = part2(input)

    assert result == 19
  end

  test "part2b", %{input2: input} do
    result = part2(input)

    assert result == 23
  end
end
