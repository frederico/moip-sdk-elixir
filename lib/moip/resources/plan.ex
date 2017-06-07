defmodule Moip.Resource.Plan do
  defstruct [
    :amount, :billing_cycles, :code, :creation_date, :description, :id,
    :interval, :max_qty, :name, :payment_method, :setup_fee, :status, :trial
  ]
   @moduledoc """
      Representação de plano
    """

    @doc """
    * :amount - Valor do plano em centavos de Real
    * :billing_cycles - Quantidade de ciclos (faturas) que a assinatura terá até expirar (se não informar, não haverá expiração)
    * :code - Identificador do plano na sua aplicação.
    * :description - Descrição do plano na sua aplicação.
    * :id - Identificador do plano moip
    * :interval - Estrutura de intervalo do plano, contendo UNIT e LENGTH.
    *    |- unit - A unidade de medida do intervalo de cobrança, o default é MONTH. Opções: DAY, MONTH, YEAR.
    *    |- length - A duração do intervalo de cobrança, default é 1.
    * :max_qty - Quantidade máxima de assinaturas do plano (não há limite se não informar)
    * :name - Nome do plano na sua aplicação.
    * :payment_method - Formas de pagamentos aceitas no plano. BOLETO, CREDIT_CARD ou ALL. Caso o atributo não seja informado, a forma de pagamento default é CREDIT_CARD.
    * :setup_fee - Taxa de contratação a ser cobrada na assinatura em centavos de Real
    * :status - Status do plano. Pode ser ACTIVE ou INACTIVE. O padrão é ACTIVE
    * :trial - Estrutura de trial, contendo DAYS, ENABLED e HOLD_SETUP_FEE.
    *    |- days - Número de dias de trial do plano.
    *    |- enabled - Determina se o trial está ou não habilitado. Opções: TRUE ou FALSE, default é FALSE.
    *    |- hold_setup_fee - Determina se o setup_fee será cobrado antes ou após o período de trial. Opções: TRUE (após) ou FALSE (antes). Default é TRUE.
    """
end
