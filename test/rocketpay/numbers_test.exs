defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when there is a file with a given name, return sum of numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there isn't a file with a given name, return sum of numbers" do
      response = Numbers.sum_from_file("any")

      expected_response = {:error, %{message: "Invalid file"}}

      assert response == expected_response
    end
  end
end
