-- =======================
-- Banco de Dados EmpresaY
-- =======================

DROP DATABASE IF EXISTS EmpresaY;

CREATE DATABASE EmpresaY;
USE EmpresaY;

CREATE TABLE Cargo (
codCargo SMALLINT PRIMARY KEY,
nome VARCHAR(30)
);

CREATE TABLE Funcionario (
codFunc SMALLINT PRIMARY KEY,
cpf VARCHAR(11),
nome VARCHAR(40),
salario DECIMAL(6,2),
admissao DATE,
codCargo SMALLINT,
codDepart SMALLINT,
FOREIGN KEY(codCargo) REFERENCES Cargo (codCargo)
);

CREATE TABLE Departamento (
codDepart SMALLINT PRIMARY KEY,
nome VARCHAR(40)
);

ALTER TABLE Funcionario ADD FOREIGN KEY(codDepart) REFERENCES Departamento (codDepart);
