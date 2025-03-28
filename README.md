# Criando Banco de Dados para Ecommerce 

Replicado um banco de dados no MySQL Workbench baseando-se na instruções da professora, persistidos dados e testado com algumas consultas SQL com:

[x] SELECT Statement

[x] Filtros com WHERE Statement 

[x] Expressões para gerar atributos derivados 

[x] Ordenações dos dados com ORDER BY

[x] Filtrar grupos com HAVING Statement

Essas queries estão no arquivo Queries_Desafio.sql

 Com o BD funcionando foi feito um refinamento no Script e refletidas as alterações no Modelo  EER refinado.

## Refinando BD para Ecommerce

### Clientes PJ e PF

Para separar os cliente em PJ e PF, a primeira ideia foi generalizar em uma tabela Cliente que seria especializada em PF (natural_person) e PJ (company).

Porém, durante o processo, notei atributos em comum entre os clientes PJ, os Fornecedores e os Vendedores Parceiro. Para que esses dois últimos não fossem classificados como ‘Clientes’, a tabela cliente foi substituída por ‘Account’ e adicionado o atributo Account_type, classificando a conta em 'Natural_person','Company','Supplier','Partner_vendor' ou 'Others’.

### Pagamento

A tabela Payments usa o id da conta (idAccount_payments) e o idPayment como chave primaria composta, dessa forma uma conta pode ter mais de uma modalidade de pagamento.

### Entrega

Dentro da tabela Orders, foram criados os campos Tracking_code e orderStatus para o código de rastreio e o status do pedido, respectivamente.

