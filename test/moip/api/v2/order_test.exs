defmodule Moip.Api.V2.OrderTest do
  import Moip.V2.TestUtils
  use ExUnit.Case, async: true

  setup do
    Moip.configure!(basic_auth)
    :ok
  end

  describe "Moip.Api.V2.Order.list" do
    test "should have :ok response" do
      orders = Moip.Api.V2.Order.list
      send self(), orders
      assert_received {:ok, _}
    end
  end

  describe "Moip.Api.V2.Order.create" do
    test "with invalid attributes should have :error response" do
      order_response = Moip.Api.V2.Order.create(%{})
      send self(), order_response
      assert_received {:error, _}
    end

    test "with valid attributes should return response OK" do
      order_response = Moip.Api.V2.Order.create(random_order())
      send self(), order_response
      assert_received {:ok, _}
    end
  end


  describe "Moip.Api.V2.Order.find" do
    test "with existent order should return the order" do
      order = random_order()
      {:ok, created_order} = Moip.Api.V2.Order.create(order)
      order_found = Moip.Api.V2.Order.find(created_order["id"])
      send self(), order_found
      assert_received {:ok, _}
    end

    test "with inexistent order should return :error" do
      order_code = "test-code-#{SecureRandom.uuid}"
      order_response = Moip.Api.V2.Order.find(order_code)
      send self(), order_response
      assert_received {:error, _}
    end
  end
end
