defmodule MealTracker.LogEntry do
  alias MealTracker.LogEntry

  defstruct date: Timex.Date.now(), items: []

  def new do
    %LogEntry{}
  end

  def add_item(entry, item) do
    %LogEntry{entry | items: [item | entry.items]}
  end
end
