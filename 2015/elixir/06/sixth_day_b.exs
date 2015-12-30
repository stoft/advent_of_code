defmodule SixthDayB do

  def process_file(filename) do
    input = File.read! filename
    instructions = String.split input, "\n"
    process_instructions generate_light_list, instructions
  end

  def process_instructions(lights, instructions) do
    Enum.reduce(instructions, lights, fn i, lights ->
      process_instruction lights, i
    end)
  end

  def process_instruction(lights, instruction) do
    instruction = parse_instruction instruction
    do_instruction lights, instruction
  end

  def parse_instruction("turn off " <> rest) do
    [from, _, to] = String.split(rest)
    parse_instruction {from, to, -1}
  end

  def parse_instruction("turn on " <> rest) do
    [from, _, to] = String.split(rest)
    parse_instruction {from, to, 1}
  end

  def parse_instruction("toggle " <> rest) do
    [from, _, to] = String.split(rest)
    parse_instruction {from, to, 2}
  end

  def parse_instruction({from, to, op}) do
    from = parse_xy from
    to = parse_xy to
    {from, to, op}
  end

  def parse_xy(coords) do
    [x,y] = String.split(coords, ",")
    {String.to_integer(x), String.to_integer(y)}
  end

  def count_brightness(lights) do
    lights
    |> Enum.reduce([], fn {key,val}, list -> [val] ++ list end)
    |> Enum.sum
  end

  defp do_instruction(lights, {from, to, op} = instruction) do
    list = generate_light_list {from, to}
    Enum.reduce(list, lights, fn {k,v}, acc ->
      Dict.update acc, k, -1, &(&1 + op)
    end)
  end

  def generate_light_list() do
    generate_light_list({{0,0},{999,999}})
  end

  def generate_light_list({{x1,y1}, {x2,y2}}) do
    list = for i <- x1..x2, j <- y1..y2, do: {i, j, 0}
    convert_to_map list
  end

  defp convert_to_map(list) do
    Enum.reduce(list, %{}, fn {x, y, state}, acc -> 
      Map.put acc, {x, y}, state
    end) 
  end

end