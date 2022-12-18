defmodule AdventOfCode.Solution.Year2022.Day07 do
  def part1(input) do
    input
    |> parse_input()
    |> calculate_dir_sizes()
    |> Enum.map(fn {_name, size} -> size end)
    |> Enum.filter(fn x -> x < 100_000 end)
    |> Enum.sum()
  end

  def part2(input) do
    total_size = 70_000_000
    min_space = 30_000_000

    dir_sizes =
      input
      |> parse_input()
      |> calculate_dir_sizes()
      |> Enum.into(%{})

    space_to_free = min_space - (total_size - Map.get(dir_sizes, "/"))

    dir_sizes
    |> Enum.map(fn {_n, s} -> s end)
    |> Enum.filter(fn s -> s > space_to_free end)
    |> Enum.min()
  end

  defp parse_input(input) do
    input
    |> String.split("$ ", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end

  defp calculate_dir_sizes(parsed_input) do
    parsed_input
    |> Enum.reduce(%{current_dir: ""}, &process_command/2)
    |> Map.drop([:current_dir])
    |> Enum.map(fn {k, v} -> {k, get_size_of_files(v)} end)
    |> aggregate_sizes()
  end

  defp aggregate_sizes(dir_sizes) do
    data = %{flat: dir_sizes, totals: []}
    %{flat: _flat, totals: totals} = Enum.reduce(data[:flat], data, &aggregate_sizes/2)
    totals
  end

  defp aggregate_sizes({name, _size} = _dir_size, %{flat: flat_data, totals: total_data} = data) do
    total_size =
      flat_data
      |> Enum.filter(fn {n, _s} -> String.starts_with?(n, name) end)
      |> Enum.map(fn {_n, s} -> s end)
      |> Enum.sum()

    Map.put(data, :totals, [{name, total_size} | total_data])
  end

  defp process_command(["cd " <> next_dir | []] = _command, %{current_dir: current_dir} = tree) do
    new_current_dir =
      cond do
        next_dir == "/" -> "/"
        current_dir == "/" -> next_dir
        true -> current_dir <> "/" <> next_dir
      end

    Map.replace(tree, :current_dir, Path.expand(new_current_dir, "/"))
  end

  defp process_command(["ls" | args] = _instruction, %{current_dir: _current_dir} = tree) do
    Enum.reduce(args, tree, &parse_ls_output/2)
  end

  defp parse_ls_output("dir " <> sub_dir = _output, %{current_dir: "/"} = tree) do
    Map.put_new(tree, "/" <> sub_dir, [])
  end

  defp parse_ls_output("dir " <> sub_dir = _output, %{current_dir: current_dir} = tree) do
    full_sub_dir = current_dir <> "/" <> sub_dir
    Map.put_new(tree, full_sub_dir, [])
  end

  defp parse_ls_output(output, %{current_dir: current_dir} = tree) do
    file_info = Regex.named_captures(~r/(?<size>\d*)\s(?<name>[\w\.]*)/, output)
    current_files = Map.get(tree, current_dir, [])

    Map.put(tree, current_dir, [
      {file_info["name"], String.to_integer(file_info["size"])} | current_files
    ])
  end

  defp get_size_of_files(files) do
    files
    |> Enum.map(fn {_name, size} -> size end)
    |> Enum.sum()
  end
end
