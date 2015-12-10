defmodule FifthDay do

  @not_verboten ~r/^(?!.*(ab|cd|pq|xy)).*$/
  @three_vowels ~r/([aeiou].*?){3,}/
  @double_letters ~r/([a-z])\1/
  @repeats ~r/.*(\w)\w\1.*/
  @pairs ~r/(\w\w).*?\1/

  def gonna_find_out(string, rules) do
    making_a_list = String.split(string)

    checking_it_once = Enum.filter(making_a_list, &nice?(&1, rules))
      |> Enum.count
    
    checking_it_twice = Enum.filter(making_a_list, &not(nice?(&1, rules)))
      |> Enum.count
    
    "Who's naughty: #{checking_it_twice}, or nice: #{checking_it_once}"
  end
  
  def nice?(string, rules) do
    eval = for rule <- rules, do: {rule, valid?(string, rule)}
    
    passed = Enum.filter eval, fn {_name, result} ->
      result == true
    end
    
    Enum.count(rules) == Enum.count(passed)
  end

  def valid?(string, :allowed_chars) do
    String.match?(string, @not_verboten)
  end

  def valid?(string, :three_vowels) do
    String.match?(string, @three_vowels)
  end

  def valid?(string, :double_letters) do
    String.match?(string, @double_letters)
  end

  def valid?(string, :repeats) do
    String.match?(string, @repeats)
  end

  def valid?(string, :pairs) do
    String.match?(string, @pairs)
  end
end