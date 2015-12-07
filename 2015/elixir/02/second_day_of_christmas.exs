defmodule SecondDayOfChristmas do

  def read_file(filename) do
    File.read!(filename)
  end

  def measure_many(input, type) do
    l = String.split(input, ~r/(\s)/, trim: true)
    res = for e <- l, do: measure(e, type)
    Enum.sum(res)
  end

  def measure(str, :ribbon) do
    str |> sanitize |> do_measure_ribbon
  end

  def measure(str, :paper) do
    str |> sanitize |> do_measure_paper
  end

  def do_measure_paper([l, w, h]) do
    list = [(l*w), (w*h), (h*l)]

    Enum.min(list) + Enum.reduce(list, 0, fn arg, acc ->
      (arg*2) + acc
    end)
  end

  def do_measure_ribbon(input) do
    remove_largest = fn(list) -> list |> Enum.sort |> Enum.reverse |> tl end
    length = remove_largest.(input) |> Enum.reduce(0, &(&1 + &1 + &2))
    bow = Enum.reduce(input, 1, &(&1 * &2))
    length + bow
  end

  def sanitize(str) do
    l = String.split(str, "x")
    for e <- l, do: String.to_integer(e)
  end
end
