defmodule Moip.V2.TestUtils do
  use ExUnit.CaseTemplate

  def basic_auth do
    %Moip.Auth.BasicAuth{token: Moip.Config.basic_auth_token() , secret: Moip.Config.basic_auth_secret() }
  end

  def valid_random_funding_instruments do
    %{
      method: "CREDIT_CARD",
      creditCard: credit_card()
    }
  end

  def credit_card do
    valid_credit_card_number = "4073020000000002"
    expiration_month =  String.pad_leading(Integer.to_string(DateTime.utc_now.month), 2, "0")
    expiration_year = Integer.to_string(round((DateTime.utc_now.year + 3) / 100))

    %{
      number: valid_credit_card_number,
      expirationYear: expiration_year,
      expirationMonth: expiration_month,
      holder: %{
        fullname: Faker.Name.name,
        birthdate: "1988-12-30",
        phone: phone(),
        taxDocument: tax_document(),
        billingAddress: random_address()
      }
    }
  end

  def phone do
    %{
      countryCode: "55",
      areaCode: "11",
      number: "66778899"
    }
  end

  def tax_document do
    %{
      type: "CPF",
      number: "#{Brcpfcnpj.cpf_generate}"
    }
  end

  def random_address do
    %{
      street: Faker.Address.street_address,
      streetNumber: "#{Faker.Address.building_number}",
      city: "Goiânia",
      state: "GO",
      country: "BRA",
      zipCode: "74565090",
      district: "district"
    }
  end

  def random_customer do
    %{
      ownId: "cc-#{SecureRandom.uuid}",
      fullname: Faker.Name.name,
      email: Faker.Internet.email,
      birthDate: "1988-12-30",
      taxDocument: tax_document(),
      phone: phone(),
      shippingAddress: random_address()
    }
  end

  def random_customer_with_funding_instrument do
    Map.merge(random_customer(), %{fundingInstrument: valid_random_funding_instruments()})
  end

   def valid_random_subscription_with_existing_customer(plan_code, amount, customer_code) do
    subscription_code = "sc-#{SecureRandom.uuid}"
    #TODO - when sandbox is fixed allow to random create as CREDIT_CARD or BOLETO
    payment_method = "CREDIT_CARD"

    plan = %{code: plan_code }
    customer_attrs = %{ code: customer_code }

    %{
        code: subscription_code, amount: amount, payment_method: payment_method,
        plan: plan, customer: customer_attrs
    }
  end
end
