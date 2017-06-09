defmodule Moip.Api.Assinaturas.V1.PlanTest do
  import Moip.TestUtils
  use ExUnit.Case, async: false
  setup do
    Moip.configure!(basic_auth)
    :ok
  end
  describe "Moip.Api.Assinaturas.V1.Plan.list" do
    test "should have :ok response" do
      plans = Moip.Api.Assinaturas.V1.Plan.list
      send self(), plans
      assert_received {:ok, _}
    end
  end

  describe "Moip.Api.Assinaturas.V1.Plan.create" do
    test "with invalid attributes should have :error response" do
      plan_response = Moip.Api.Assinaturas.V1.Plan.create(%{})
      send self(), plan_response
      assert_received {:error, _}
    end
    test "with valid attributes should return response OK" do
      plan_response = Moip.Api.Assinaturas.V1.Plan.create(valid_random_plan)
      send self(), plan_response
      assert_received {:ok, %{"message" => "Plano criado com sucesso"}}
    end
  end

  describe "Moip.Api.Assinaturas.V1.Plan.find" do
    test "with existent plan should return the plan" do
      plan = valid_random_plan
      plan_code = plan[:code]
      Moip.Api.Assinaturas.V1.Plan.create(plan)
      plan_response = Moip.Api.Assinaturas.V1.Plan.find(plan_code)
      send self(), plan_response
      assert_received {:ok, _}
    end
    test "with inexistent plan should return :error" do
      plan_code = "test-code-#{SecureRandom.uuid}"
      plan_response = Moip.Api.Assinaturas.V1.Plan.find(plan_code)
      send self(), plan_response
      assert_received {:error, _}
    end
  end

  describe "Moip.Api.Assinaturas.V1.Plan.activate" do
    test "with existent plan should activate the plan" do
      plan = valid_inactive_random_plan
      plan_code = plan[:code]
      Moip.Api.Assinaturas.V1.Plan.create(plan)
      plan_response = Moip.Api.Assinaturas.V1.Plan.activate(plan_code)
      send self(), plan_response
      assert_received {:ok, _}
    end
    test "with inexistent plan should return :error" do
      plan_code = "test-code-#{SecureRandom.uuid}"
      plan_response = Moip.Api.Assinaturas.V1.Plan.activate(plan_code)
      send self(), plan_response
      assert_received {:error, _}
    end
  end
  describe "Moip.Api.Assinaturas.V1.Plan.inactivate" do
    test "with existent plan should inactivate the plan" do
      plan = valid_random_plan
      plan_code = plan[:code]
      Moip.Api.Assinaturas.V1.Plan.create(plan)
      plan_response = Moip.Api.Assinaturas.V1.Plan.inactivate(plan_code)
      send self(), plan_response
      assert_received {:ok, _}
    end
    test "with inexistent plan should return :error" do
      plan_code = "pc-#{SecureRandom.uuid}"
      plan_response = Moip.Api.Assinaturas.V1.Plan.inactivate(plan_code)
      send self(), plan_response
      assert_received {:error, _}
    end
  end

  describe "Moip.Api.Assinaturas.V1.Plan.update" do

    test "with existent plan should update plan" do
      plan = valid_random_plan
      plan_code = plan[:code]
      Moip.Api.Assinaturas.V1.Plan.create(plan)
      update_params = %{name: "name-changed-#{plan_code}", amount: 10001}
      plan_response = Moip.Api.Assinaturas.V1.Plan.update(plan_code, update_params)
      send self(), plan_response
      assert_received {:ok, _}
    end
    test "with inexistent plan should return :error" do
      plan_code = "pc-#{SecureRandom.uuid}"
      plan_response = Moip.Api.Assinaturas.V1.Plan.update(plan_code, %{})
      send self(), plan_response
      assert_received {:error, _}
    end
  end
end
