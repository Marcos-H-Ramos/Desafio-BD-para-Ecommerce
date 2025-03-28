-- criação do banco de dados para o cenário de E-commerce 
-- drop database ecommerce;
create database  if not exists ecommerce_refinado;
use ecommerce_refinado;

-- criar tabela Contas
CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`accounts` (
  `idAccount` INT NOT NULL auto_increment primary key,
  Account_type enum('Natural_person','Company','Supplier','Partner_vendor','Others') not null,
  `Tel.` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
   Address varchar(255)
   )
ENGINE = InnoDB;
alter table accounts auto_increment=1;

select * from accounts;

-- Criar especialização de client pessoa fisica
create table if not exists natural_person(
        idAccount INT NOT NULL primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        constraint unique_cpf_natural_person unique (CPF),
        constraint unique_natural_person_idAccount unique (idAccount),
        constraint fk_natural_person_accounts foreign key (idAccount) references accounts(idAccount)
			on update cascade
);

select * from natural_person;

-- Criar especialização de client pessoa juridica
CREATE TABLE IF NOT EXISTS Company (
  `idAccount` INT NOT NULL unique,
   idCompany INT NOT NULL unique,
  `SocialName` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(14) unique NOT NULL,
  primary key (idAccount),
  CONSTRAINT `fk_Company_accounts`
    FOREIGN KEY (`idAccount`)
    REFERENCES accounts(idAccount)
    on update cascade
    );
select * from Company;

-- criar tabela produto
-- size = dimensão do produto ou tamanho P,M,G 
create table if not exists products(
		idProduct int auto_increment primary key,
        Pname varchar(25) not null,
        classification_kids bool default false,
        Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        Score  float default 0.0,
        size varchar(10)
);
alter table products auto_increment=1;


-- criar tabela pagamentos
create table if not exists payments(
	idAccount_payments int NOT NULL,
    idPayment int auto_increment NOT NULL,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    card_number VARCHAR(16) NOT NULL,
	owner_name VARCHAR(45) NOT NULL,
	expiration_date DATE NOT NULL,
    card_alias VARCHAR(45) NOT NULL, -- apelido para o metodo de pagamento 
    primary key(idPayment),
	CONSTRAINT check_payments_typePayment CHECK (typePayment = 'Boleto' OR'Cartão' OR 'Dois cartões'),
    CONSTRAINT fk_payments_account FOREIGN KEY (idAccount_payments)
    REFERENCES accounts(idAccount)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
alter table payments auto_increment=1;
desc payments;

-- criar tabela pedido
create table if not exists orders(
	idOrder int auto_increment primary key,
    idOrderAccount int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue FLOAT NULL DEFAULT 0,
    paymentCash boolean default false, 
    Address VARCHAR(45) NOT NULL,
    create_date DATE NOT NULL,
    Tracking_code VARCHAR(45) NULL,
    Payment_metothod int NOT NULL,
    constraint fk_ordes_Account foreign key (idOrderAccount) references accounts(idAccount)
			on update cascade,
	constraint fk_ordes_Payment foreign key (Payment_metothod) references payments(idPayment)
			on update cascade
);
alter table orders auto_increment=1;


-- criar tabela estoque
create table if not exists productStorage(
	idProdStorage int auto_increment  primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;

-- criar tabela fornecedor
create table if not exists supplier(
	idCompany_supplier int unique,
    idSupplier int AUTO_INCREMENT primary key,
    constraint fk_supplier_accounts foreign key (idCompany_supplier) references Company(idCompany)
			on update cascade
);
alter table supplier auto_increment=1;

-- criar tabela vendedor
create table if not exists seller(
	idCompany_supplier int unique,
    idSeller int AUTO_INCREMENT primary key,
    location varchar(255),
    Score  float default 0.0,
    constraint fk_seller_accounts foreign key (idCompany_supplier) references Company(idCompany)
			on update cascade
);

alter table seller auto_increment=1;


-- tabelas de relacionamentos M:N

create table if not exists productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references products(idProduct)
);

create table if not exists productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references products(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)
);

create table if not exists storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references products(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table if not exists productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references products(idProduct)
);

desc productSupplier;

show tables;