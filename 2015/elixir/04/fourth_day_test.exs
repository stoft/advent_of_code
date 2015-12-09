ExUnit.start

Code.load_file("fourth_day.exs")

defmodule FourthDayTest do
  use ExUnit.Case, async: true

  test "abcdef609043" do
    result = FourthDay.convert("abcdef609043")
    assert String.starts_with?(result, "000001dbbfa")
  end

  test "pqrstuv1048970" do
    result = FourthDay.convert("pqrstuv1048970")
    assert String.starts_with?(result, "000006136ef")
  end

  test "abcdef" do
    int = FourthDay.mine("abcdef")
    assert int == 609043
  end

  test "pqrstuv" do
    int = FourthDay.mine("pqrstuv", "00000")
    assert int == 1048970
  end

  test "challenge A" do
    int = FourthDay.mine("yzbqklnj")
    IO.puts("Challenge A: #{int}")
  end

  @tag timeout: 120000
  test "challenge B" do
    int = FourthDay.mine("yzbqklnj", "000000")
    IO.puts("Challenge B: #{int}")
  end

end