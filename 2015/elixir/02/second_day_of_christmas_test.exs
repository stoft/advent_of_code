ExUnit.start

Code.load_file("second_day_of_christmas.exs")

defmodule SecondDayOfChristmasTest do
use ExUnit.Case, async: true

  test "paper 2x3x4 = 52, + 6 = 58" do
    assert SecondDayOfChristmas.measure("2x3x4", :paper) == 58
  end

  test "paper 1x1x10 = 42, + 1 = 43" do
    assert SecondDayOfChristmas.measure("1x1x10", :paper) == 43
  end

  test "ribbon 2x3x4 => 2+2+3+3 = 10 + 2*3*4 = 24 => 34" do
    assert SecondDayOfChristmas.measure("2x3x4", :ribbon) == 34
  end

  test "ribbon 1x1x10 => (1+1+1+1 = 4) + (1*1*10 = 10) => 14" do
    assert SecondDayOfChristmas.measure("1x1x10", :ribbon) == 14
  end

  test "paper challenge" do
    input = SecondDayOfChristmas.read_file "input.txt"
    paper = SecondDayOfChristmas.measure_many(input, :paper)
    ribbon = SecondDayOfChristmas.measure_many(input, :ribbon)
    IO.puts "Challenge paper: #{paper}"
    IO.puts "Challenge ribbon: #{ribbon}"
  end

end
