defmodule FoodItemSpec do
  use ESpec
  import Fixtures

  alias MealTracker.FoodItem

  describe "constructing" do
    context "a simple item" do
      let :item, do: fixture(:item)

      it do: expect(item.name).to eq "Big Mac"
      it do: expect(item.quantity).to eq 1
      it do: expect(item.unit).to eq :item
    end
  end

  describe "formatting" do
    context "a simple item" do
      let :item, do: fixture(:item)

      it do: expect(to_string(item)).to eq "1x Big Mac"
    end

    context "an item with a quantity" do
      let :item, do: fixture(:item, quantity: 5)

      it do: expect(to_string(item)).to eq "5x Big Mac"
    end

    context "an item with quantity and units" do
      let :item, do: fixture(:item, name: "Pepsi", quantity: 355, unit: :milliliter)

      it do: expect(to_string(item)).to eq "355 milliliter Pepsi"
    end
  end

  describe "parsing" do
    it "raises an exception when asked to parse something that isn't text" do
      expect(fn -> FoodItem.parse(5) end).to raise_exception(MealTracker.ParseError)
    end

    it "isn't confused by excess whitesapce" do
      expect(FoodItem.parse("     Big Mac     ")).to eq fixture(:item)
    end

    it "isn't confused by numbers in the middle" do
      expect(FoodItem.parse("Heinz 57 Sauce")).to eq fixture(:item, name: "Heinz 57 Sauce")
    end

    context "a simple item" do
      it do: expect(FoodItem.parse("Big Mac")).to eq fixture(:item)
    end

    context "an item with a simple quantity" do
      it do: expect(FoodItem.parse("5x Big Mac")).to eq fixture(:item, quantity: 5)
    end

    context "an item with a non-integer quantity" do
      it do: expect(FoodItem.parse("5.5x Big Mac")).to eq fixture(:item, quantity: 5.5)
    end

    context "an item with an invalid quantity" do
      it do: expect(FoodItem.parse("5.5xyz Big Mac")).to eq fixture(:item, name: "5.5xyz Big Mac")
    end

    context "an item with quantity and units" do
      it do
        item = %FoodItem{name: "Pepsi", quantity: 355, unit: :milliliter}

        expect(FoodItem.parse("355 milliliter Pepsi")).to eq item
      end
    end

    context "an item with non-integer quantity and units" do
      it do
        item = %FoodItem{name: "Pepsi", quantity: 355.5, unit: :milliliter}

        expect(FoodItem.parse("355.5 milliliter Pepsi")).to eq item
      end
    end

    context "an item with an invalid quantity and units" do
      it do
        item = %FoodItem{name: "355.5xyz milliliter Pepsi"}

        expect(FoodItem.parse("355.5xyz milliliter Pepsi")).to eq item
      end
    end
  end
end
