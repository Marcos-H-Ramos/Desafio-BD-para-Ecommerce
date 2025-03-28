-- Recuperações simples com SELECT Statement
-- Filtros com WHERE Statement
-- Defina ordenações dos dados com ORDER BY

-- Recuperar os endereços dos pedidos ordenados por criação do pedido
SELECT cpf, address, idOrder FROM clients, orders 
	WHERE idOrderClient = idClient
	ORDER BY idOrder
	;

-- A quantidade de pedidos feito por plataforma
SELECT count(*) as N, orderDescription FROM orders 
GROUP BY orderDescription;

-- Crie expressões para gerar atributos derivados
-- Condições de filtros aos grupos – HAVING Statement

-- Qual as categorias com média de avaliação menor que 3 ?
SELECT category, avg(avaliação) as Média FROM product 
GROUP BY category
HAVING avg(avaliação)<=3
;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

-- Recupera o nome e categoria do produto por CPF do cliente
SELECT CPF, Pname, category
FROM productorder, product, clients, orders
WHERE idPOproduct = idProduct AND idPOorder = idOrder AND idClient = idOrderClient
;

-- Recupera a avaliação do produto por forncedor
SELECT SocialName, CNPJ, Pname, category, avaliação
FROM seller, product, productseller, orders, productorder
WHERE idPseller = idSeller AND idProduct = idPproduct = idPOproduct AND idOrder = idPOorder
;