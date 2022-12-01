defmodule AdventOfCode.Solution.Year2021.Day03 do
  def part1(input) do
    parsed_input = parse_input(input)

    gamma = compute_gamma(parsed_input)
    epsilon = compute_epsilon(parsed_input)

    gamma * epsilon
  end

  def part2(input) do
    parsed_input = parse_input(input)

    o2 = get_life_support_rating(parsed_input, 0, :o2)
    co2 = get_life_support_rating(parsed_input, 0, :co2)

    co2 * o2
  end

  defp bit_list_to_int(bit_list) do
    bit_precision = Enum.count(bit_list)
    <<int_val::size(bit_precision)>> = Enum.into(bit_list, <<>>, fn bit -> <<bit::1>> end)
    int_val
  end

  defp compute_gamma(input) do
    size = Enum.count(input)

    input
    |> Enum.reduce(&count_bits/2)
    |> Enum.map(fn x -> get_common_bit(x, size, &greater/2) end)
    |> bit_list_to_int()
  end

  defp compute_epsilon(input) do
    size = Enum.count(input)

    input
    |> Enum.reduce(&count_bits/2)
    |> Enum.map(fn x -> get_common_bit(x, size, &less_than/2) end)
    |> bit_list_to_int()
  end

  defp greater(a, b) do
    a > b
  end

  defp greater_equals(a, b) do
    a >= b
  end

  defp less_than(a, b) do
    a < b
  end

  def get_common_bit(total_ones, size, comparator) do
    if comparator.(total_ones, size / 2) do
      1
    else
      0
    end
  end

  defp get_life_support_rating([elem] = _inputs, _position, _ls_key) do
    bit_list_to_int(elem)
  end

  defp get_life_support_rating(inputs, position, ls_key) do
    size = Enum.count(inputs)
    bit_count = Enum.reduce(inputs, &count_bits/2)

    comp_func =
      case ls_key do
        :o2 -> &greater_equals/2
        :co2 -> &less_than/2
      end

    common_bit = get_common_bit(Enum.at(bit_count, position), size, comp_func)
    remaining_inputs = Enum.filter(inputs, &(Enum.at(&1, position) == common_bit))
    get_life_support_rating(remaining_inputs, position + 1, ls_key)
  end

  defp count_bits(input, acc) do
    input
    |> Enum.zip(acc)
    |> Enum.map(fn {a, b} -> a + b end)
  end

  defp parse_input(args) do
    args
    |> String.split()
    |> Enum.map(&String.graphemes(&1))
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
  end
end
