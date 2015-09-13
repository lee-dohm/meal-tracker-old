defmodule FoodItemSpec do
  use ESpec

  alias MealTracker.FoodItem

  let :one_big_mac, do: %FoodItem{name: "Big Mac"}

  describe "constructing" do
    context "a simple item" do
      let :item, do: one_big_mac

      it do: expect(item.name).to eq "Big Mac"
      it do: expect(item.quantity).to eq 1
      it do: expect(item.unit).to eq :item
    end
  end

  describe "formatting" do
    context "a simple item" do
      let :item, do: one_big_mac

      it do: expect(to_string(item)).to eq "1x Big Mac"
    end

    context "an item with a quantity" do
      let :item, do: %FoodItem{one_big_mac | quantity: 5}

      it do: expect(to_string(item)).to eq "5x Big Mac"
    end

    context "an item with quantity and units" do
      let :item, do: %FoodItem{name: "Pepsi", quantity: 355, unit: :milliliter}

      it do: expect(to_string(item)).to eq "355 milliliter Pepsi"
    end
  end
end
