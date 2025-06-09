-- João Vitor Lemos Oliveira

-- 1. Utilizar, pelo menos, dois níveis de isolamento e comparar o resultado em uma transação bancária para cada um dos problemas a seguir. O resultado de um nível de isolamento deve apresentar problema e no outro nível não.
-- a) Mostrar o problema de leitura suja.

-- READ UNCOMMITTED
-----------------------------------------------------------------------------
-- Transação 1
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

UPDATE Conta SET saldoConta = saldoConta - 100 WHERE nroConta = 10;

-----------------------------------------------------------------------------
-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

SELECT saldoConta FROM Conta WHERE nroConta = 10;

-----------------------------------------------------------------------------
-- Transação 1
ROLLBACK;

-----------------------------------------------------------------------------


-- READ COMMITTED
-----------------------------------------------------------------------------
-- Transação 1
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

UPDATE Conta SET saldoConta = saldoConta - 100 WHERE nroConta = 10;

-----------------------------------------------------------------------------
-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

SELECT saldoConta FROM Conta WHERE nroConta = 10;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- b) Mostrar o problema de leitura não repetível.

-- READ COMMITTED
-----------------------------------------------------------------------------
-- Transação 1
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

SELECT saldoConta FROM Conta WHERE nroConta = 20;

-----------------------------------------------------------------------------
-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

UPDATE Conta SET saldoConta = 900.0 WHERE nroConta = 20;
COMMIT;

-----------------------------------------------------------------------------
-- Transação 1
SELECT saldoConta FROM Conta WHERE nroConta = 20;  
COMMIT;

-----------------------------------------------------------------------------


-- REPEATABLE READ
-----------------------------------------------------------------------------
-- Transação 1
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

SELECT saldoConta FROM Conta WHERE nroConta = 20; 

-----------------------------------------------------------------------------
-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

UPDATE Conta SET saldoConta = 900.0 WHERE nroConta = 20;
COMMIT;

-----------------------------------------------------------------------------
-- Transação 1
SELECT saldoConta FROM Conta WHERE nroConta = 20;
COMMIT;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- c) Mostrar o problema de registro fantasma.

-- REPEATABLE READ
-----------------------------------------------------------------------------
-- Transação 1
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

SELECT COUNT(*) FROM Cliente WHERE cidade = 'Curitiba'; 

----------------------------------------------------------------------------- 
-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

INSERT INTO Cliente VALUES (13, 'Curitiba', '99999999999', 'Cliente Fantasma');
COMMIT;

----------------------------------------------------------------------------- 
-- Transação 1
SELECT COUNT(*) FROM Cliente WHERE cidade = 'Curitiba';  
-- Resultado: 4 clientes 😱 (novo registro apareceu!)
COMMIT;

----------------------------------------------------------------------------- 


-- SERIALIZABLE
----------------------------------------------------------------------------- 
-- Transação 1
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

SELECT COUNT(*) FROM Cliente WHERE cidade = 'Curitiba';  

----------------------------------------------------------------------------- 
-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

-- TENTA inserir cliente novo em Curitiba...
INSERT INTO Cliente VALUES (13, 'Curitiba', '99999999999', 'Cliente Fantasma');