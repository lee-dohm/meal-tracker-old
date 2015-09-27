defmodule LogEntrySpec do
  use ESpec
  import Fixtures

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
      end
    end
  end
end
