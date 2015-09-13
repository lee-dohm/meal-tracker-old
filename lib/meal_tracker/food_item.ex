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

  @type t :: %FoodItem{name: String.t, quantity: pos_integer, unit: atom}
  defstruct name: nil, quantity: 1, unit: :item

  defimpl String.Chars, for: FoodItem do
    def to_string(item), do: FoodItem.to_string(item)
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
end
