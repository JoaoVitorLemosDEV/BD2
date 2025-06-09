CREATE DATABASE ControleBancario;

USE ControleBancario;

CREATE TABLE Cliente (
    codCliente INT PRIMARY KEY,
    cidade VARCHAR(60) NOT NULL,
    RG VARCHAR(11) NOT NULL,
    nome VARCHAR(60) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE Agencia (
    cidadeAgencia VARCHAR(60) NOT NULL,
    nroAgencia INT PRIMARY KEY
) ENGINE = InnoDB;

CREATE TABLE Funcionario (
    codFunc INT PRIMARY KEY,
    nomeFunc VARCHAR(60) NOT NULL,
    enderecoFunc VARCHAR(200) NOT NULL,
    salarioFunc DECIMAL(6,2) NOT NULL,
    nroAgencia INT NOT NULL,
    FOREIGN KEY(nroAgencia) REFERENCES Agencia (nroAgencia)
) ENGINE = InnoDB;

CREATE TABLE Conta (
    nroConta INT PRIMARY KEY,
    saldoConta DECIMAL(6,2) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE Transacao (
    nroTransacao INT PRIMARY KEY,
    data DATE NOT NULL,
    valor DECIMAL(6,2) NOT NULL,
    tipo ENUM('Transferência', 'Depósito', 'Saque') NOT NULL,
    nroContaOrigem INT,
    nroContaDestino INT,
    FOREIGN KEY(nroContaOrigem) REFERENCES Conta (nroConta),
    FOREIGN KEY(nroContaDestino) REFERENCES Conta (nroConta)
) ENGINE = InnoDB;

CREATE TABLE ACC (
    nroConta INT NOT NULL,
    nroAgencia INT NOT NULL,
    codCliente INT NOT NULL,
    PRIMARY KEY(nroConta,nroAgencia,codCliente)
) ENGINE = InnoDB;