defmodule Moip.Resource.Customer do
  defstruct [
    :amount, :billing_cycles, :code, :creation_date, :description, :id,
    :interval, :max_qty, :name, :payment_method, :setup_fee, :status, :trial
  ]
end
