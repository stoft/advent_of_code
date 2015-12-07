defmodule FirstDayOfChristmas do

  def get_end_floor(str) do
    str |> String.to_char_list |> do_get_end_floor 0
  end

  def get_first_basement_character(str) do
    str |> String.to_char_list |> do_get_first_basement_character(0, 0)

  end

  defp do_get_end_floor([], curr_floor), do: curr_floor
  defp do_get_end_floor([?(|rest], curr_floor), do: do_get_end_floor rest, curr_floor+1
  defp do_get_end_floor([?)|rest], curr_floor), do: do_get_end_floor rest, curr_floor-1

  defp do_get_first_basement_character(_list, -1, char_count), do: char_count
  defp do_get_first_basement_character([], curr_floor, _char_count), do: curr_floor

  defp do_get_first_basement_character([?(|rest], curr_floor, char_count), do: do_get_first_basement_character rest, curr_floor+1, char_count+1

  defp do_get_first_basement_character([?)|rest], curr_floor, char_count), do: do_get_first_basement_character rest, curr_floor-1, char_count+1


end
