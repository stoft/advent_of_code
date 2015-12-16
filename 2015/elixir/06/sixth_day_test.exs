ExUnit.start

Code.eval_file("sixth_day.exs")

defmodule SixthDayTest do
  use ExUnit.Case, async: true

  test "simple instruction" do
    instruction = "turn on 0,0 through 2,2"
    lights = SixthDay.generate_light_list({{0,0},{2,2}})
    expected = %{
      {0,0} => :on, {0,1} => :on, {0,2} => :on,
      {1,0} => :on, {1,1} => :on, {1,2} => :on,
      {2,0} => :on, {2,1} => :on, {2,2} => :on
    }
    SixthDay.process_instruction( lights, instruction) == expected
  end

  test "simple instruction2" do
    instruction = "turn on 0,0 through 1,2"
    lights = SixthDay.generate_light_list({{0,0},{2,2}})
    expected = %{
      {0,0} => :on, {0,1} => :on, {0,2} => :on,
      {1,0} => :on, {1,1} => :on, {1,2} => :on,
      {2,0} => :off, {2,1} => :off, {2,2} => :off
    }
    SixthDay.process_instruction( lights, instruction) == expected
  end

  test "simple instruction toggle" do
    instruction = "toggle 0,0 through 1,2"
    lights = SixthDay.generate_light_list({{0,0},{2,2}})
    expected = %{
      {0,0} => :on, {0,1} => :on, {0,2} => :on,
      {1,0} => :on, {1,1} => :on, {1,2} => :on,
      {2,0} => :off, {2,1} => :off, {2,2} => :off
    }
    SixthDay.process_instruction( lights, instruction) == expected
  end

  test "beta test" do
    instructions = ["turn on 0,0 through 4,4",
          "toggle 0,0 through 4,0",
          "turn off 2,2 through 3,3"]

    expected = %{
      {0,0} => :off, {1,0} => :off, {2,0} => :off, {3,0} => :off, {4,0} => :off,
      {0,1} => :on, {1,1} => :on, {2,1} => :on, {3,1} => :on, {4,1} => :on,
      {0,2} => :on, {1,2} => :on, {2,2} => :off, {3,2} => :off, {4,2} => :on,
      {0,3} => :on, {1,3} => :on, {2,3} => :off, {3,3} => :off, {4,3} => :on,
      {0,4} => :on, {1,4} => :on, {2,4} => :on, {3,4} => :on, {4,4} => :on
    }

    lights = SixthDay.generate_light_list({{0,0},{4,4}})

    result = SixthDay.process_instructions(lights, instructions)
    assert expected == result
  end

  test "gen light list" do
    assert SixthDay.generate_light_list() == SixthDay.generate_light_list({{0,0}, {999,999}})
  end

  @tag timeout: 120000
  test "challenge A" do
    IO.inspect SixthDay.process_file("input.txt") |> SixthDay.count_on
    # assert 1_000_000 == SixthDay.count_on(lights)
  end

  @tag timeout: 120000
  test "challenge B" do
    IO.inspect SixthDay.process_file("input.txt") |> SixthDay.count_on
  end
end