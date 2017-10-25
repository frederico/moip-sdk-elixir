defmodule Moip.Api.V2.PaymentTest do
  import Moip.V2.TestUtils
  use ExUnit.Case, async: true

  setup do
    Moip.configure!(basic_auth)
    :ok
  end

  describe "Moip.Api.V2.Payment.create" do
    test "with invalid attributes should have :error response" do
      payment_response = Moip.Api.V2.Payment.create("test-#{SecureRandom.uuid}", %{})
      send self(), payment_response
      assert_received {:error, _}
    end

    test "with valid attributes should return response OK" do
      order = random_order()
      {:ok, created_order} = Moip.Api.V2.Order.create(order)

      payment_response = Moip.Api.V2.Payment.create(created_order["id"], random_payment())
      send self(), payment_response
      assert_received {:ok, _}
    end
  end

  describe "Moip.Api.V2.Payment.find" do
    test "with existent payment should return the payment" do
      order = random_order()
      {:ok, created_order} = Moip.Api.V2.Order.create(order)

      {:ok, created_payment} = Moip.Api.V2.Payment.create(created_order["id"], random_payment())

      payment_found = Moip.Api.V2.Payment.find(created_payment["id"])
      send self(), payment_found
      assert_received {:ok, _}
    end

    test "with inexistent payment should return :error" do
      payment_code = "test-code-#{SecureRandom.uuid}"
      payment_response = Moip.Api.V2.Payment.find(payment_code)
      send self(), payment_response
      assert_received {:error, _}
    end
  end

  describe "Moip.Api.V2.Payment.list" do
    test "should have :ok response" do
      order = random_order()
      {:ok, created_order} = Moip.Api.V2.Order.create(order)

      payments = Moip.Api.V2.Payment.list(created_order["id"])
      send self(), payments
      assert_received {:ok, _}
    end
  end
end
