defmodule FourthDay do

  def mine(key) do
    mine(key, "00000")
  end

  def mine(key, pattern) do
    Stream.unfold(0, fn n ->
      {n, n+1}
    end)
    
    |> Stream.drop_while(fn n -> 
      hash = convert("#{key}#{n}")
      not String.starts_with?(hash, pattern)
    end)

    |> Enum.take(1) |> hd
  end

  def convert(input) do
    :crypto.hash(:md5, input)
    |> Base.encode16(case: :lower)
  end

  # Initial implementation:

  # def mine(key) do
  #   mine(key, 0, nil)
  # end

  # def mine(_key, int, "00000" <> rest = hash) do
  #   {int - 1, hash}
  # end

  # def mine(key, int, hash) do
  #   hash = convert("#{key}#{int}")
  #   mine(key, int + 1, hash)
  # end

end