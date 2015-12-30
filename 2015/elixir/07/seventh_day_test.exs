ExUnit.start

Code.eval_file("seventh_day.exs")

defmodule SeventhDayTest do
  use ExUnit.Case, async: true

  test "simple operations" do
    circuit = [
      "123 -> x",
      "456 -> y",
      "x AND y -> d",
      "x OR y -> e",
      "x LSHIFT 2 -> f",
      "y RSHIFT 2 -> g",
      "NOT x -> h",
      "NOT y -> i",
    ]

    expected_wire_signals = %{
      "d" => 72,
      "e" => 507,
      "f" => 492,
      "g" => 114,
      "h" => 65412,
      "i" => 65079,
      "x" => 123,
      "y" => 456
    }

    actual = SeventhDay.run_circuit(circuit)
    assert expected_wire_signals == actual
  end

  test "challenge A" do
    Code.eval_file("input.exs")
    circuit = Input.input
    SeventhDay.run_circuit(circuit)
    |> get_in ["a"]

  end
end