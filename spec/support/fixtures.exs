defmodule Fixtures do
  alias MealTracker.FoodItem

  def fixture(:item, options \\ []) do
    item = %FoodItem{name: "Big Mac"}
    if options[:name], do: item = %FoodItem{item | name: options[:name]}
    if options[:quantity], do: item = %FoodItem{item | quantity: options[:quantity]}
    if options[:unit], do: item = %FoodItem{item | unit: options[:unit]}
    item
  end
end
