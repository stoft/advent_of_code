ExUnit.start

Code.load_file("./third_day.exs")


defmodule ThirdDayTest do
  use ExUnit.Case, async: true

  test "> = 2 houses" do
    assert SecondDay.navigate(">") == 2
  end

  test "^>v< = 4 houses" do
    assert SecondDay.navigate("^>v<") == 2
  end

  test "^v^v^v^v^v = 2 houses" do
    assert SecondDay.navigate("^v^v^v^v^v") == 2
  end 

end
