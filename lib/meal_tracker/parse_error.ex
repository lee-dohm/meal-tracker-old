defmodule MealTracker.ParseError do
  @moduledoc """
  Raised when something goes wrong with parsing meal tracking logs.
  """

  defexception [:message]

  def exception(value) do
    message = "Do not know how to parse: #{inspect(value)}"
    %MealTracker.ParseError{message: message}
  end
end
