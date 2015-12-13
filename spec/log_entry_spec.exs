defmodule LogEntrySpec do
  use ESpec
  import Fixtures

  alias MealTracker.FoodItem
  alias MealTracker.LogEntry

  describe "constructing" do
    context "an empty entry" do
      let :entry, do: LogEntry.new

      it do: expect(Timex.Date.compare(entry.date, Timex.Date.now(), :days)).to eq 0
      it do: expect(entry.items).to eq []
    end
  end

  describe "adding items" do
    let :item, do: fixture(:item)

    context "to an empty entry" do
      let :entry, do: LogEntry.new

      it "has one item" do
        entry = LogEntry.add_item(entry, item)

        expect(length(entry.items)).to eq 1
        expect(List.first(entry.items)).to eq %FoodItem{name: "Big Mac"}
      end
    end

    context "to an entry with items already" do
      let :entry do
        entry = LogEntry.new
        LogEntry.add_item(entry, item)
      end

      it "has two items" do
        entry = LogEntry.add_item(entry, item)

        expect(length(entry.items)).to eq 2
        expect(List.first(entry.items)).to eq %FoodItem{name: "Big Mac"}
        expect(List.last(entry.items)).to eq %FoodItem{name: "Big Mac"}
      end
    end
  end
end
