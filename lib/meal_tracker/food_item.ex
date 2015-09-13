defmodule MealTracker.FoodItem do
  @moduledoc """
  Represents a food item.

  ## Text Formats

  This module mainly exists to translate food items between the structure representation and textual
  representations. In the patterns below "Food name" represents the name of the food, "nx"
  represents the number (n) of items of that food, and "n unit" represents the number (n) of unit of
  the food such as "355 milliliter Pepsi".

  * `Food name` (equivalent to `1x Food name`)
  * `nx Food name`
  * `n unit Food name`
  """
  require Logger

  alias MealTracker.FoodItem

  @item_quantity_pattern ~r/^(?<quantity>\d+(\.\d+)?)x (?<name>.+)$/
  @unit_quantity_pattern ~r/^(?<quantity>\d+(\.\d+)?) (?<unit>\w+) (?<name>.+)$/

  @type t :: %FoodItem{name: String.t, quantity: pos_integer, unit: atom}
  defstruct name: nil, quantity: 1, unit: :item

  defimpl String.Chars, for: FoodItem do
    def to_string(item), do: FoodItem.to_string(item)
  end

  @doc """
  Parses the text representation of a food item into a `FoodItem` struct.

  ## Examples

      iex> FoodItem.parse("Big Mac")
      %MealTracker.FoodItem{name: "Big Mac", quantity: 1, unit: :item}

      iex> FoodItem.parse("5x Oreo Cookie")
      %MealTracker.FoodItem{name: "Oreo Cookie", quantity: 5, unit: :item}

      iex> FoodItem.parse("355 milliliter Pepsi")
      %MealTracker.FoodItem{name: "Pepsi", quantity: 355, unit: :milliliter}

  """
  @spec parse(String.t) :: t
  def parse(text) do
    cond do
      captures = Regex.named_captures(@item_quantity_pattern, text) -> parse_item_quantity(captures)
      captures = Regex.named_captures(@unit_quantity_pattern, text) -> parse_unit_quantity(captures)
      true -> %FoodItem{name: text}
    end
  end

  @doc """
  Converts the item to its text representation.
  """
  @spec to_string(t) :: String.t
  def to_string(item) do
    Logger.debug "Format FoodItem as text: #{inspect(item)}"
    format(item)
  end

  defp format(%FoodItem{unit: :item, quantity: quantity, name: name}), do: "#{quantity}x #{name}"
  defp format(item), do: "#{item.quantity} #{item.unit} #{item.name}"

  defp parse_item_quantity(captures) do
    %FoodItem{name: captures["name"], quantity: parse_number(captures["quantity"])}
  end

  defp parse_unit_quantity(captures) do
    %FoodItem{
      name: captures["name"],
      quantity: parse_number(captures["quantity"]),
      unit: String.to_atom(captures["unit"])
    }
  end

  defp parse_number(text), do: parse_integer(Integer.parse(text), text)

  defp parse_integer({quantity, ""}, _), do: quantity
  defp parse_integer(_, text), do: parse_float(Float.parse(text), text)

  defp parse_float({quantity, ""}, _), do: quantity
end
