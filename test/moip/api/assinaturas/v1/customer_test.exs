defmodule Moip.Api.Assinaturas.V1.CustomerTest do
  import Moip.TestUtils
  use ExUnit.Case, async: true

  setup do
    Moip.configure!(basic_auth)
    :ok
  end

  describe "Moip.Api.Assinaturas.V1.Customer.list" do
    test "should have :ok response" do
      customers = Moip.Api.Assinaturas.V1.Customer.list
      send self(), customers
      assert_received {:ok, _}
    end
  end


  describe "Moip.Api.Assinaturas.V1.Customer.create" do
    test "with invalid attributes should have :error response" do
      customer_response = Moip.Api.Assinaturas.V1.Customer.create(%{})
      send self(), customer_response
      assert_received {:error, _}
    end

    test "with valid attributes should return response OK" do
      customer_response = Moip.Api.Assinaturas.V1.Customer.create(random_customer)
      send self(), customer_response
      assert_received {:ok, %{"message" => "Cliente criado com sucesso"}}
    end

    test "with valid attributes but without billing info should return error response" do
      customer_response = Moip.Api.Assinaturas.V1.Customer.create(random_customer, true)
      send self(), customer_response
      assert_received {:error, _}
    end
    test "with valid attributes with billing info should retunr response OK" do
      customer_response = Moip.Api.Assinaturas.V1.Customer.create(random_customer_with_billing_info, true)
      send self(), customer_response
      assert_received {:ok, %{"message" => "Cliente criado com sucesso"}}
    end
  end


  describe "Moip.Api.Assinaturas.V1.Customer.find" do
    test "with existent customer should return the customer" do
      customer = random_customer
      Moip.Api.Assinaturas.V1.Customer.create(customer)
      customer_found = Moip.Api.Assinaturas.V1.Customer.find(customer[:code])
      send self(), customer_found
      assert_received {:ok, _}
    end

    test "with inexistent customer should return :error" do
      customer_code = "test-code-#{SecureRandom.uuid}"
      customer_response = Moip.Api.Assinaturas.V1.Customer.find(customer_code)
      send self(), customer_response
      assert_received {:error, _}
    end
  end


  describe "Moip.Api.Assinaturas.V1.Customer.update" do
    test "with existent customer should update customer" do
      customer = random_customer
      Moip.Api.Assinaturas.V1.Customer.create(customer)
      new_customer_attributes = (Map.drop(random_customer, [:code]) |> Map.merge(%{code: customer[:code]}))
      customer_update_response = Moip.Api.Assinaturas.V1.Customer.update(customer[:code], new_customer_attributes)
      send self(), customer_update_response
      assert_received {:ok, _}
    end
    test "with inexistent customer should return :error" do
      plan_code = "test-code-#{SecureRandom.uuid}"
      customer_update_response = Moip.Api.Assinaturas.V1.Customer.update(plan_code, %{})
      send self(), customer_update_response
      assert_received {:error, _}
    end
  end

    describe "Moip.Api.Assinaturas.V1.Customer.update_billing_info" do
      test "with existent customer should update customer" do
        customer = random_customer
        Moip.Api.Assinaturas.V1.Customer.create(customer)
        customer_update_response = Moip.Api.Assinaturas.V1.Customer.update_billing_info(customer[:code], valid_random_billing_info)
        send self(), customer_update_response
        assert_received {:ok, _}
      end
      test "with inexistent customer should return :error" do
        plan_code = "test-code-#{SecureRandom.uuid}"
        customer_update_response = Moip.Api.Assinaturas.V1.Customer.update_billing_info(plan_code, %{})
        send self(), customer_update_response
        assert_received {:error, _}
      end
    end
end
