defmodule Moip.Api.Assinaturas.V1.SubscriptionTest do
  import Moip.V1.TestUtils
  use ExUnit.Case, async: false

  setup do
    Moip.configure!(basic_auth)
    :ok
  end

  describe "Moip.Api.Assinaturas.V1.Subscription.list" do

    test "should have :ok response" do
      subscriptions = Moip.Api.Assinaturas.V1.Subscription.list
      send self(), subscriptions
      assert_received {:ok, _}
    end
  end


  describe "Moip.Api.Assinaturas.V1.Subscription.create" do

    test "with invalid attributes should have :error response" do
      subscription_response = Moip.Api.Assinaturas.V1.Subscription.create(%{})
      send self(), subscription_response
      assert_received {:error, _}
    end

    test "with valid attributes should return response OK" do
      customer = random_customer_with_billing_info
      customer_code = customer[:code]

      case Moip.Api.Assinaturas.V1.Customer.create(customer, true) do
        _ ->
          plan = valid_random_plan
          plan_code = plan[:code]
          amount = plan[:amount]
          case Moip.Api.Assinaturas.V1.Plan.create(plan) do
            _ ->
              subscription = valid_random_subscription_with_existing_customer(plan_code, amount, customer_code)
              case Moip.Api.Assinaturas.V1.Subscription.create(subscription) do
                subscription_response ->
                  send self(), subscription_response
                  assert_received({:ok, %{"message" => "Assinatura criada com sucesso"}})
              end
          end
      end
    end

    test "with valid attributes creating a new customer should return :ok response" do
      plan = valid_random_plan
      plan_code = plan[:code]
      amount = plan[:amount]

      case Moip.Api.Assinaturas.V1.Plan.create(plan) do
        _ ->
          subscription = valid_random_subscription_with_non_existing_customer(plan_code, amount)
          case Moip.Api.Assinaturas.V1.Subscription.create(subscription, true) do
            subscription_response ->
              send self(), subscription_response
              assert_received {:ok, %{"message" => "Assinatura criada com sucesso"}}
          end
      end
    end
  end


  describe "Moip.Api.Assinaturas.V1.Subscription.find" do

    test "with existent customer should return the customer" do
      plan = valid_random_plan
      plan_code = plan[:code]
      amount = plan[:amount]

      case Moip.Api.Assinaturas.V1.Plan.create(plan) do
        _ ->
          subscription = valid_random_subscription_with_non_existing_customer(plan_code, amount)
          case Moip.Api.Assinaturas.V1.Subscription.create(subscription, true) do
            _ ->
              subscription_found = Moip.Api.Assinaturas.V1.Subscription.find(subscription[:code])
              send self(), subscription_found
              assert_received {:ok, _}
          end
      end
    end

    test "with inexistent customer should return :error" do
      subscription_code = "test-code-#{SecureRandom.uuid}"
      subscription_response = Moip.Api.Assinaturas.V1.Subscription.find(subscription_code)
      send self(), subscription_response
      assert_received {:error, _}
    end
  end


  describe "Moip.Api.Assinaturas.V1.Subscription.update" do
    test "with existent customer should update subscription" do
      plan = valid_random_plan
      plan_code = plan[:code]
      amount = plan[:amount]

      case Moip.Api.Assinaturas.V1.Plan.create(plan) do
        _ ->
          subscription = valid_random_subscription_with_non_existing_customer(plan_code, amount)
          case Moip.Api.Assinaturas.V1.Subscription.create(subscription, true) do
            _ ->
              new_plan = valid_random_plan
              new_plan_code = new_plan[:code]
              new_amount = new_plan[:amount]
              case Moip.Api.Assinaturas.V1.Plan.create(new_plan) do
                _ ->
                  new_subscription_attributes = %{plan: %{code: new_plan_code}, amount: new_amount }
                  subscription_response = Moip.Api.Assinaturas.V1.Subscription.update(subscription[:code], new_subscription_attributes)
                  send self(), subscription_response
                  assert_received {:ok, %{message: "Assinatura atualizada com sucesso"}}
              end
          end
      end
    end

    test "with inexistent customer should return :error" do
      plan_code = "test-code-#{SecureRandom.uuid}"
      subscription_response = Moip.Api.Assinaturas.V1.Subscription.update(plan_code, %{})
      send self(), subscription_response
      assert_received {:error, _}
    end
  end
  describe "Moip.Api.Assinaturas.V1.Subscription.suspend" do
    test "test all status changes " do
      plan = valid_random_plan
      plan_code = plan[:code]
      amount = plan[:amount]

      case Moip.Api.Assinaturas.V1.Plan.create(plan) do
        _ ->
          subscription = valid_random_subscription_with_non_existing_customer(plan_code, amount)
          case Moip.Api.Assinaturas.V1.Subscription.create(subscription, true) do
            _ ->
              suspend_response = Moip.Api.Assinaturas.V1.Subscription.suspend(subscription[:code])
              send self(), suspend_response
          end
      end
    end
  end
  describe "Moip.Api.Assinaturas.V1.Subscription.cancel" do
    test "test all status changes " do
      plan = valid_random_plan
      plan_code = plan[:code]
      amount = plan[:amount]

      case Moip.Api.Assinaturas.V1.Plan.create(plan) do
        _ ->
          subscription = valid_random_subscription_with_non_existing_customer(plan_code, amount)
          case Moip.Api.Assinaturas.V1.Subscription.create(subscription, true) do
            _ ->
              cancelation_response = Moip.Api.Assinaturas.V1.Subscription.cancel(subscription[:code])
              send self(), cancelation_response
              assert_received {:ok, %{message: "Assinatura cancelada com sucesso"}}
          end
      end
    end
  end
  describe "Moip.Api.Assinaturas.V1.Subscription.activate" do
    test "test all status changes " do
      plan = valid_random_plan
      plan_code = plan[:code]
      amount = plan[:amount]

      case Moip.Api.Assinaturas.V1.Plan.create(plan) do
        _ ->
          subscription = valid_random_subscription_with_non_existing_customer(plan_code, amount)
          case Moip.Api.Assinaturas.V1.Subscription.create(subscription, true) do
            _ ->
              case Moip.Api.Assinaturas.V1.Subscription.suspend(subscription[:code]) do
                _ ->
                  activate_response = Moip.Api.Assinaturas.V1.Subscription.activate(subscription[:code])
                  send self(), activate_response
                  assert_received {:ok, %{message: "Assinatura reativada com sucesso"}}
              end
          end
      end
    end
  end
end
