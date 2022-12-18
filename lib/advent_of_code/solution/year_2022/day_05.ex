defmodule AdventOfCode.Solution.Year2022.Day05 do
  def part1(input) do
    input
    |> parse_input()
    |> move_crates()
    |> get_top_crates()
  end

  def move_crate(_iter, {from, to, piles} = _acc) do
    [crate | remain] = piles[from]

    new_piles =
      piles
      |> Map.put(from, remain)
      |> Map.put(to, [crate | piles[to]])

    {from, to, new_piles}
  end

  def get_top_crates(piles) do
    IO.puts("Generating top crates")

    Map.keys(piles)
    |> Enum.sort()
    |> Enum.map(fn k -> piles[k] end)
    |> Enum.map(&hd/1)
    |> Enum.join("")
  end

  def process_new_instruction(
        %{"n_crates" => n_crates, "from" => from, "to" => to} = _instruction,
        piles
      ) do
    crates = Enum.take(piles[from], n_crates)
    remain = Enum.drop(piles[from], n_crates)

    piles
    |> Map.put(from, remain)
    |> Map.put(to, crates ++ piles[to])
  end

  def process_instruction(
        %{"n_crates" => n_crates, "from" => from, "to" => to} = _instruction,
        piles
      ) do
    {_from, _to, new_piles} = Enum.reduce(1..n_crates, {from, to, piles}, &move_crate/2)
    new_piles
  end

  def move_crates({crate_piles, instructions} = _input) do
    Enum.reduce(instructions, crate_piles, &process_instruction/2)
  end

  def move_crates_2({crate_piles, instructions} = _input) do
    IO.puts("Processing instructions")
    a = Enum.reduce(instructions, crate_piles, &process_new_instruction/2)
    IO.puts("Done")
    dbg()
    a
  end

  def part2(input) do
    input
    |> parse_input()
    |> move_crates_2()
    |> get_top_crates()
  end

  defp create_empty_piles(pile_ids) do
    number_of_piles = pile_ids |> Enum.at(-1) |> String.to_integer()
    Enum.reduce(1..number_of_piles, %{}, fn x, acc -> Map.put(acc, x, []) end)
  end

  defp add_crate_to_piles(crate, {current_pile, piles}) do
    crate_name = Regex.named_captures(~r/\[(?<letter>\w)\]/, crate)

    piles =
      case crate_name do
        nil -> piles
        %{"letter" => letter} -> Map.put(piles, current_pile, [letter | piles[current_pile]])
      end

    {current_pile + 1, piles}
  end

  defp populate_piles(row, piles) do
    {_, piles} = Enum.reduce(row, {1, piles}, &add_crate_to_piles/2)
    piles
  end

  defp parse_instruction(instruction_line) do
    Regex.named_captures(
      ~r/move (?<n_crates>\d*) from (?<from>\d*) to (?<to>\d*)/,
      instruction_line
    )
    |> Enum.map(fn {k, v} -> {k, String.to_integer(v)} end)
    |> Enum.into(%{})
  end

  defp parse_input(input) do
    [crates, instructions] = String.split(input, "\n\n", trim: true)

    parsed_instructions =
      instructions
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_instruction/1)

    [pile_ids | crate_list] =
      crates
      |> String.split("\n", trim: true)
      |> Enum.map(&String.replace(&1, "    ", " - "))
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.reverse()

    piles = create_empty_piles(pile_ids)
    crate_piles = Enum.reduce(crate_list, piles, &populate_piles/2)

    {crate_piles, parsed_instructions}
  end
end
