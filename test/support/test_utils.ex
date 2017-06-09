defmodule Moip.TestUtils do
  use ExUnit.CaseTemplate

  def basic_auth do
    %Moip.Auth.BasicAuth{token: Moip.Config.basic_auth_token() , secret: Moip.Config.basic_auth_secret() }
  end

  def valid_random_billing_info do
    holder_name = "Nome Completo"
    valid_credit_card_number = "4073020000000002"
    expiration_month =  String.pad_leading(Integer.to_string(DateTime.utc_now.month),2,"0")
    expiration_year = Integer.to_string(round((DateTime.utc_now.year + 3) / 100))

    credit_card = %{
        holder_name: holder_name, number: valid_credit_card_number,
        expiration_year: expiration_year,
        expiration_month: expiration_month
    }
    %{credit_card: credit_card}
  end

  def random_address do
    street = Faker.Address.street_address
    number = "#{Faker.Address.building_number}"
    city = "Goiânia"
    state = "GO"
    country = "BRA"
    zipcode = "74565090"
    district = "district"

    %{ street: street, number: number,
        city: city, state: state, country: country,
        zipcode: zipcode, district: district
    }
  end

  def random_customer do
    customer_code = "cc-#{SecureRandom.uuid}"
    email = Faker.Internet.email
    full_name = Faker.Name.name
    cpf = "#{Brcpfcnpj.cpf_generate}"
    phone_area_code = Integer.to_string(Enum.random(11..99))
    phone_number = "22222222"
    birth_day = "15"
    birth_month = "03"
    birth_year = "1984"

    %{code: customer_code, fullname: full_name,
        email: email, cpf: cpf, phone_area_code: phone_area_code,
        phone_number: phone_number, birthdate_day: birth_day,
        birthdate_month: birth_month, birthdate_year: birth_year,
        address: random_address(),

    }
  end

  def random_customer_with_billing_info do
      customer_code = "cuc-#{SecureRandom.uuid}"
      email = Faker.Internet.email
      full_name = Faker.Name.name
      cpf = "22222222222" # Brcpfcnpj.cpf_generate
      phone_area_code = Integer.to_string(Enum.random(11..99))
      phone_number = "934343434"
      birth_day = "15"
      district = "district"
      birth_month = "03"
      birth_year = "1984"
      %{code: customer_code, fullname: full_name,
          email: email, cpf: cpf, phone_area_code: phone_area_code,
          phone_number: phone_number, birthdate_day: birth_day,
          birthdate_month: birth_month, birthdate_year: birth_year,
          address: random_address(),
          billing_info: valid_random_billing_info()
      }
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

  def valid_random_subscription_with_non_existing_customer(plan_code, amount) do
    subscription_code = "sc-#{SecureRandom.uuid}"
    #TODO - when sandbox is fixed allow to random create as CREDIT_CARD or BOLETO
    payment_method = "CREDIT_CARD"

    plan = %{code: plan_code }
    customer_attrs = random_customer_with_billing_info

    %{
        code: subscription_code, amount: amount,  plan: plan,
        payment_method: payment_method,
        customer: customer_attrs
    }
  end

  def valid_random_plan do
    plan_code = "pc-#{SecureRandom.uuid}"
    name = "name-#{SecureRandom.uuid}"
    amount = Integer.to_string(10000)
    status = "ACTIVE"
    payment_method = "CREDIT_CARD"

    %{code: plan_code, name: name, amount: amount, status: status, payment_method: payment_method }
  end
  def valid_inactive_random_plan do
      plan_code = "pc-#{SecureRandom.uuid}"
      name = "name-#{SecureRandom.uuid}"
      amount = Integer.to_string(10000)
      status = "INACTIVE"
      payment_method = "CREDIT_CARD"

      %{code: plan_code, name: name, amount: amount, status: status, payment_method: payment_method }
    end
end
