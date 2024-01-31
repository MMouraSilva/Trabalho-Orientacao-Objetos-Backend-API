--CREATE DATABASE APPESTOQUE

CREATE TABLE USUARIO (
	idUsuario INT IDENTITY(1, 1) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	senha VARCHAR(100) NOT NULL,
	createdAt DATETIME DEFAULT(GETDATE()),
	updatedAt DATETIME
)
GO
CREATE TRIGGER TRG_USUARIO_updatedAt ON USUARIO FOR UPDATE AS
BEGIN
  UPDATE USUARIO
	SET updatedAt = GETDATE()
	FROM USUARIO INNER JOIN deleted d
	ON USUARIO.idUsuario=d.idUsuario
END
GO

CREATE TABLE FORNECEDOR (
	idFornecedor INT IDENTITY(1, 1) PRIMARY KEY,
	nomeFornecedor VARCHAR(50) NOT NULL,
	cnpj VARCHAR(14) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	telefone VARCHAR(11),
	email VARCHAR(50),
	createdAt DATETIME DEFAULT(GETDATE()),
	updatedAt DATETIME
)
GO
CREATE TRIGGER TRG_FORNECEDOR_updatedAt ON FORNECEDOR FOR UPDATE AS
BEGIN
  UPDATE FORNECEDOR
	SET updatedAt = GETDATE()
	FROM FORNECEDOR INNER JOIN deleted d
	ON FORNECEDOR.idFornecedor=d.idFornecedor
END
GO


CREATE TABLE DEPOSITO (
	idDeposito INT IDENTITY(1, 1) PRIMARY KEY,
	nomeDeposito VARCHAR(50) NOT NULL,
	createdAt DATETIME DEFAULT(GETDATE()),
	updatedAt DATETIME
)
GO
CREATE TRIGGER TRG_DEPOSITO_updatedAt ON DEPOSITO FOR UPDATE AS
BEGIN
  UPDATE DEPOSITO
	SET updatedAt = GETDATE()
	FROM DEPOSITO INNER JOIN deleted d
	ON DEPOSITO.idDeposito=d.idDeposito
END
GO

CREATE TABLE PRODUTO (
	codProduto INT IDENTITY(1, 1) PRIMARY KEY,
	nomeProduto VARCHAR(50) NOT NULL,
	skuProduto VARCHAR(20),
	idFornecedor INT FOREIGN KEY REFERENCES FORNECEDOR(idFornecedor),
	createdAt DATETIME DEFAULT(GETDATE()),
	updatedAt DATETIME
)
GO
CREATE TRIGGER TRG_PRODUTO_updatedAt ON PRODUTO FOR UPDATE AS
BEGIN
  UPDATE PRODUTO
	SET updatedAt = GETDATE()
	FROM PRODUTO INNER JOIN deleted d
	ON PRODUTO.codProduto=d.codProduto
END
GO

CREATE TABLE ESTOQUE (
	idSaldo INT IDENTITY(1, 1) PRIMARY KEY,
	codProduto INT FOREIGN KEY REFERENCES PRODUTO(codProduto) NOT NULL,
	quantidade INT NOT NULL,
	precoCusto FLOAT,
	freteCompra FLOAT,
	idi FLOAT,
	despesasOperacionais FLOAT,
	icmsSt FLOAT,
	icms FLOAT,
	fcpSt FLOAT,
	precoMinVenda FLOAT,
	lucroReal FLOAT,
	lucroPorcent FLOAT,
	precoVenda FLOAT,
	idDeposito INT FOREIGN KEY REFERENCES DEPOSITO(idDeposito) NOT NULL,
	createdAt DATETIME DEFAULT(GETDATE()),
	updatedAt DATETIME
)
GO
CREATE TRIGGER TRG_ESTOQUE_updatedAt ON ESTOQUE FOR UPDATE AS
BEGIN
  UPDATE ESTOQUE
	SET updatedAt = GETDATE()
	FROM ESTOQUE INNER JOIN deleted d
	ON ESTOQUE.idSaldo=d.idSaldo
END
GO