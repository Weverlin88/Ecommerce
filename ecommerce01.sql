create schema if not exists ecommerce;
use ecommerce;
-- Tabela Cliente
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Vendedor
CREATE TABLE vendedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Fornecedor
CREATE TABLE fornecedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Produto
CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    categoria VARCHAR(100),
    fornecedor_id INT,
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id)
);

-- Tabela Estoque
CREATE TABLE estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);

-- Tabela Pedido
CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'processando', 'enviado', 'entregue', 'cancelado') DEFAULT 'pendente',
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Tabela ItemPedido
CREATE TABLE item_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);

-- Tabela Entrega
CREATE TABLE entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    endereco_entrega VARCHAR(255),
    data_entrega TIMESTAMP,
    status ENUM('pendente', 'em_transito', 'entregue') DEFAULT 'pendente',
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

-- Tabela Pagamento
CREATE TABLE pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    metodo ENUM('credito','débito', 'boleto', 'pix'),
    status ENUM('pendente', 'aprovado', 'recusado') DEFAULT 'pendente',
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

-- iserindo dados cliente
insert into cliente (nome,email,senha,endereco,telefone)
values('João Silva','joaoS@123.com',123,'rua A,35,BH/MG','21 123456789'),
('Jose Assis','joseA@123.com','456','rua B,40,Betim/MG','31 987654321');


-- Inserindo dados de exemplo na tabela Vendedor
INSERT INTO vendedor (nome, email, senha)
VALUES ('Maria Santos', 'maria@example.com', 'vendedor123'),
('Gustavo Henrique','gu@13.com','vendedor456');

-- Inserindo dados de exemplo na tabela Fornecedor
INSERT INTO fornecedor (nome, email, endereco, telefone)
VALUES ('Fornecedor ABC', 'fornecedor@example.com', 'Rua B, 456', '(11) 9876-5432'),
('Gabriel Lima','Glima@123.com','rua A,50,BH/MG','31 9874-4561');

-- Inserindo dados de exemplo na tabela Produto
INSERT INTO produto (nome, descricao, preco, estoque, categoria, fornecedor_id)
VALUES ('Camiseta Branca', 'Camiseta branca de algodão', 29.99, 100, 'Roupas', 1);

-- Inserindo dados de exemplo na tabela Pedido
INSERT INTO pedido (cliente_id, status)
VALUES (1, 'pendente');

-- Inserindo dados de exemplo na tabela ItemPedido
INSERT INTO item_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES (1, 1, 2, 29.99);

-- Inserindo dados de exemplo na tabela Entrega
INSERT INTO entrega (pedido_id, endereco_entrega, status)
VALUES (1, 'Rua A, 123', 'pendente');

-- Inserindo dados de exemplo na tabela Pagamento
INSERT INTO pagamento (pedido_id, valor, metodo, status)
VALUES (1, 59.98, 'credito', 'pendente');


