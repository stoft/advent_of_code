ExUnit.start

Code.load_file("fifth_day.exs")
Code.load_file("input.exs")

defmodule FifthDayTest do
  use ExUnit.Case, async: true

  @rules_a [:allowed_chars, :three_vowels, :double_letters]

  @rules_b [:repeats, :pairs]

  test "does (not) have forbidden chars A" do
    assert not FifthDay.valid?("haegwjzuvuyypxyu", :allowed_chars)
    assert FifthDay.valid?("jchzalrnumimnmhp", :allowed_chars)
  end

  test "does (not) have three vowels" do
    assert FifthDay.valid?("ugknbfddgicrmopn", :three_vowels)
    assert not FifthDay.valid?("dvszwmarrgswjxmb", :three_vowels)
  end

  test "does (not) have double letters" do
    assert FifthDay.valid?("dvszwmarrgswjxmb", :double_letters)
    assert not FifthDay.valid?("jchzalrnumimnmhp", :double_letters)
  end

  test "does (not) repeat" do
    assert FifthDay.valid?("abcdefeghi", :repeats)
    assert FifthDay.valid?("ieodomkazucvgmuy", :repeats)
    assert not FifthDay.valid?("abcdefghi", :repeats)
  end

  test "does (not) have pairs" do
    assert FifthDay.valid?("aabcdefgaa", :pairs)
    assert not FifthDay.valid?("aaa", :pairs)
    assert not FifthDay.valid?("ieodomkazucvgmuy", :pairs)
  end

  test "naughty or nice" do
    assert not FifthDay.nice?("jchzalrnumimnmhp", @rules_a)
    assert not FifthDay.nice?("haegwjzuvuyypxyu", @rules_a)
    assert not FifthDay.nice?("dvszwmarrgswjxmb", @rules_a)

    assert FifthDay.nice?("qjhvhtzxzqqjkmpb", @rules_b)
    assert FifthDay.nice?("xxyxx", @rules_b)
    assert not FifthDay.nice?("uurcxstgmygtbstg", @rules_b)
    assert not FifthDay.nice?("ieodomkazucvgmuy", @rules_b)
  end

  test "challenge A" do
    IO.puts FifthDay.gonna_find_out(Input.get_input, @rules_a)
  end

  test "challenge B" do
    IO.puts FifthDay.gonna_find_out(Input.get_input, @rules_b)
  end
end