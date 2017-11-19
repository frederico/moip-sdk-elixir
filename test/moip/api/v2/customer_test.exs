defmodule Moip.Api.V2.CustomerTest do
  import Moip.V2.TestUtils
  use ExUnit.Case, async: true

  setup do
    Moip.configure!(basic_auth)
    :ok
  end

  describe "Moip.Api.V2.Customer.list" do
    test "should have :ok response" do
      customers = Moip.Api.V2.Customer.list
      send self(), customers
      assert_received {:ok, _}
    end
  end

  describe "Moip.Api.V2.Customer.create" do
    test "with invalid attributes should have :error response" do
      customer_response = Moip.Api.V2.Customer.create(%{})
      send self(), customer_response
      assert_received {:error, _}
    end

    test "with valid attributes should return response OK" do
      customer_response = Moip.Api.V2.Customer.create(random_customer())
      send self(), customer_response
      assert_received {:ok, _}
    end

    test "with valid attributes with funding instrument should return response OK" do
      customer_response = Moip.Api.V2.Customer.create(random_customer_with_funding_instrument())
      send self(), customer_response
      assert_received {:ok, _}
    end
  end


  describe "Moip.Api.V2.Customer.find" do
    test "with existent customer should return the customer" do
      customer = random_customer()
      {:ok, created_customer} = Moip.Api.V2.Customer.create(customer)
      customer_found = Moip.Api.V2.Customer.find(created_customer["id"])
      send self(), customer_found
      assert_received {:ok, _}
    end

    test "with inexistent customer should return :error" do
      customer_code = "test-code-#{SecureRandom.uuid}"
      customer_response = Moip.Api.V2.Customer.find(customer_code)
      send self(), customer_response
      assert_received {:error, _}
    end
  end

  describe "Moip.Api.V2.Customer.add_creditcard" do
    test "with existent customer should update customer" do
      customer = random_customer()
      {:ok, created_customer} = Moip.Api.V2.Customer.create(customer)
      added_creditcard = Moip.Api.V2.Customer.add_creditcard(created_customer["id"], valid_random_funding_instruments())
      send self(), added_creditcard
      assert_received {:ok, _}
    end

    test "with inexistent customer should return :error" do
      customer_id = "test-code-#{SecureRandom.uuid}"
      added_creditcard = Moip.Api.V2.Customer.add_creditcard(customer_id, valid_random_funding_instruments())
      send self(), added_creditcard
      assert_received {:error, _}
    end
  end

  describe "Moip.Api.V2.Customer.delete_creditcard" do
    test "with existent customer should update customer" do
      customer = random_customer_with_funding_instrument()
      {:ok, created_customer} = Moip.Api.V2.Customer.create(customer)
      creditcard_id = created_customer["fundingInstrument"]["creditCard"]["id"]
      added_creditcard = Moip.Api.V2.Customer.remove_creditcard(creditcard_id)
      send self(), added_creditcard
      assert_received {:ok, _}
    end
  end
end
