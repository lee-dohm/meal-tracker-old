defmodule MealTracker.FoodItem do
  require Logger

  alias MealTracker.FoodItem

  defstruct name: nil, quantity: 1, unit: :item

  defimpl String.Chars, for: FoodItem do
    def to_string(item), do: FoodItem.to_string(item)
  end

  def to_string(%FoodItem{unit: :item, quantity: quantity, name: name}) do
    "#{quantity}x #{name}"
  end

  def to_string(item) do
    "#{item.quantity} #{item.unit} #{item.name}"
  end
end
