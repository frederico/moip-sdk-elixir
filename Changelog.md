# Changelog

History of the changes.
## v0.3.0
- Melhoria nos casos de teste
- Inlusão do arquivo de Changelog

## v0.2.0
- Adicionanda a documentação em todos os métodos

## v0.1.0

Versão inicial do SDK contendo:

- Versão 1.5 de Assinaturas com os seguintes endpoints:
  - /customers
    GET  /customers                             - Moip.Api.Assinaturas.V1.Customer.list                - Lista de assinantes
    POST /customers                             - Moip.Api.Assinaturas.V1.Customer.create              - Criação de assinantes
    GET  /customer/:customer_code               - Moip.Api.Assinaturas.V1.Customer.find                - Encontrar um assinante
    PUT  /customer/:customer_code               - Moip.Api.Assinaturas.V1.Customer.update              - Atualizar um assinante
    PUT  /customer/:customer_code/billing_infos - Moip.Api.Assinaturas.V1.Customer.update_billing_info - Atualizar os dados de pagamento do assiante
      
  - /plans
    GET  /plans                      - Moip.Api.Assinaturas.V1.Plan.list       - Lista de planos
    POST /plans                      - Moip.Api.Assinaturas.V1.Plan.create     - Criação de planos
    GET  /plan/:plan_code            - Moip.Api.Assinaturas.V1.Plan.find       - Encontrar um plano
    PUT  /plan/:plan_code            - Moip.Api.Assinaturas.V1.Plan.update     - Atualizar um plano
    PUT  /plan/:plan_code/activate   - Moip.Api.Assinaturas.V1.Plan.activate   - Atualizar status de um plano para "ACTIVE"
    PUT  /plan/:plan_code/inactivate - Moip.Api.Assinaturas.V1.Plan.inactivate - Atualizar status de um plano para "INACTIVATE"

  - /subscriptions
    GET  /subscriptions                            - Moip.Api.Assinaturas.V1.Subscription.list     - Lista de assinaturas
    POST /subscriptions                            - Moip.Api.Assinaturas.V1.Subscription.create   - Criação de assinaturas
    GET  /subscription/:subscription_code          - Moip.Api.Assinaturas.V1.Subscription.find     - Encontrar um assinatura
    PUT  /subscription/:subscription_code          - Moip.Api.Assinaturas.V1.Subscription.update   - Atualizar um assinatura
    PUT  /subscription/:subscription_code/suspend  - Moip.Api.Assinaturas.V1.Subscription.suspend  - Atualizar status de um assinatura para "SUSPENDED"
    PUT  /subscription/:subscription_code/activate - Moip.Api.Assinaturas.V1.Subscription.activate - Atualizar status de um assinatura para "ACTIVE"
    PUT  /subscription/:subscription_code/cancel   - Moip.Api.Assinaturas.V1.Subscription.cancel   - Atualizar status de um assinatura para "CANCELED"
 
- Todos os testes de todos os endpoints
