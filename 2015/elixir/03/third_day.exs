defmodule ThirdDay do

  def navigate(instruction) do
    list = String.to_char_list instruction
    locations = parse(list, {0,0}, [])
    Enum.uniq(locations) |> Enum.count
  end

  def parse([], curr_loc, history) do
    curr_loc ++ history
  end

  def parse([head|rest], curr_loc, history) do
    new_history = curr_loc ++ history
    new_curr_loc = do_op(head, curr_loc)
    parse(rest, new_curr_loc, new_history)
  end

  def do_op(?^, {x, y}), do: {x, y+1}
  def do_op(?>, {x, y}), do: {x+1, y}
  def do_op(?<, {x, y}), do: {x-1, y}
  def do_op(?v, {x, y}), do: {x, y-1}

end
