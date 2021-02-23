defmodule Apipay.NumbersTest do
  use ExUnit.Case

  alias Apipay.Numbers

  describe "sum_from_file/1" do
    test "when there's a file with the given name, return the sum of numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there's not a file with the given name, return an error" do
      response = Numbers.sum_from_file("wrong-file")

      expected_response = {:error, %{message: "Invalid file!"}}

      assert response == expected_response
    end
  end
end
