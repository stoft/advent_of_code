ExUnit.start

Code.eval_file("sixth_day_b.exs")

defmodule SixthDayBTest do
  use ExUnit.Case, async: true

  test "simple instruction" do
    instruction = "turn on 0,0 through 2,2"
    lights = SixthDayB.generate_light_list({{0,0},{2,2}})
    expected = %{
      {0,0} => 1, {0,1} => 1, {0,2} => 1,
      {1,0} => 1, {1,1} => 1, {1,2} => 1,
      {2,0} => 1, {2,1} => 1, {2,2} => 1
    }
    SixthDayB.process_instruction( lights, instruction) == expected
  end

  test "simple instruction2" do
    instruction = "turn on 0,0 through 1,2"
    lights = SixthDayB.generate_light_list({{0,0},{2,2}})
    expected = %{
      {0,0} => 1, {0,1} => 1, {0,2} => 1,
      {1,0} => 1, {1,1} => 1, {1,2} => 1,
      {2,0} => 0, {2,1} => 0, {2,2} => 0
    }
    SixthDayB.process_instruction( lights, instruction) == expected
  end

  test "simple instruction toggle" do
    instruction = "toggle 0,0 through 1,2"
    lights = SixthDayB.generate_light_list({{0,0},{2,2}})
    expected = %{
      {0,0} => 1, {0,1} => 1, {0,2} => 1,
      {1,0} => 1, {1,1} => 1, {1,2} => 1,
      {2,0} => 0, {2,1} => 0, {2,2} => 0
    }
    SixthDayB.process_instruction( lights, instruction) == expected
  end

  test "beta test" do
    instructions = ["turn on 0,0 through 4,4",
          "toggle 0,0 through 4,0",
          "turn off 2,2 through 3,3"]

    expected = %{
      {0,0} => 3, {1,0} => 3, {2,0} => 3, {3,0} => 3, {4,0} => 3,
      {0,1} => 1, {1,1} => 1, {2,1} => 1, {3,1} => 1, {4,1} => 1,
      {0,2} => 1, {1,2} => 1, {2,2} => 0, {3,2} => 0, {4,2} => 1,
      {0,3} => 1, {1,3} => 1, {2,3} => 0, {3,3} => 0, {4,3} => 1,
      {0,4} => 1, {1,4} => 1, {2,4} => 1, {3,4} => 1, {4,4} => 1
    }

    lights = SixthDayB.generate_light_list({{0,0},{4,4}})

    result = SixthDayB.process_instructions(lights, instructions)
    assert expected == result
    assert 31 == SixthDayB.count_brightness result
  end

  test "turn on 0,0 through 0,0 increase brightness by 1" do
    instructions = ["turn on 0,0 through 0,0"]
    lights = SixthDayB.generate_light_list
    result = SixthDayB.process_instructions lights, instructions
    assert 1 == SixthDayB.count_brightness result
  end

  test "gen light list" do
    assert SixthDayB.generate_light_list() == SixthDayB.generate_light_list({{0,0}, {999,999}})
  end

  @tag timeout: 120000
  test "challenge B" do
    IO.inspect SixthDayB.process_file("input2.txt") |> SixthDayB.count_brightness
  end
end