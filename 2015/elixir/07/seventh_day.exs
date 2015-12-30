defmodule SeventhDay  do
  require Bitwise

  @number_pattern ~r/\d+/
  @op_pattern ~r/AND|OR|NOT|LSHIFT|RSHIFT/
  @byte_size 65535


  def run_circuit(circuit) do
    lines = for line <- circuit, do: parse_circuit_line line
    Enum.reduce(lines, %{}, fn(line, wires) ->
      IO.puts "reducing line: #{line}"
      do_run_line line, wires
    end)
    |> flip_negatives
  end

  def flip_negatives(map) do
    Enum.reduce map, %{}, fn({k,v}, acc) ->
      if v < 0 do
        put_in acc, [k], v + @byte_size + 1
      else
        put_in acc, [k], v
      end
    end
  end

  def parse_circuit_line(line) do
    list = String.split line

    Enum.map(list, fn l ->
      cond do
        String.match?(l, @number_pattern) ->
          String.to_integer l
        String.match?(l, @op_pattern) ->
          String.to_atom l
        true -> l
      end
    end)
  end

  def do_run_line([x, "->", wire], wires) do
    put_in wires, [wire], extract_value(wires, x)
  end

  def do_run_line([op, x, "->", wire ], wires) do
    val = extract_value wires, x
    put_in wires, [wire], do_op(op, val)
  end

  def do_run_line([x, op, y, "->", wire], wires) do
    vax = extract_value wires, x
    vay = extract_value wires, y
    put_in wires, [wire], do_op(op, vax, vay)
  end

  def do_op(:NOT, x) do
    Bitwise.bnot x
  end

  def do_op(:AND, x, y) do
    Bitwise.band x, y
  end

  def do_op(:OR, x, y) do
    Bitwise.bor x, y
  end

  def do_op(:LSHIFT, x, y) do
    Bitwise.bsl x, y
  end

  def do_op(:RSHIFT, x, y) do
    Bitwise.bsr x, y
  end

  def extract_value(_wires, x) when is_integer(x), do: x
  def extract_value(wires, x), do: get_in wires, [x]

end
