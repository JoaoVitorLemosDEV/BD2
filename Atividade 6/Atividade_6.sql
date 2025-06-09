-- João Vitor Lemos Oliveira

-- 1. Criar os usuários secretaria e teste utilizando os comandos de controle de acesso no MySQL/MariaDB, com permissão de acesso a partir da máquina local (localhost) e com senha.

CREATE USER secretaria@localhost
IDENTIFIED BY '123';

CREATE USER teste@localhost
IDENTIFIED BY '456';

-- 2. Utilizar a base de dados EmpresaY com as seguintes tabelas:

-- Elaborar os comandos SQL de Controle de Acesso necessários para que o usuário secretaria:

-- a) Tenha permissão de consultar o CPF e o NOME (e nenhum outro campo) de todos os Funcionários com cargo de Gerente. Criar a visão vFuncionarioGerente para resolver este problema. É possível resolver sem criar essa visão?

CREATE VIEW vFuncionarioGerente AS
SELECT f.cpf, f.nome
FROM Funcionario f
JOIN Cargo c ON f.codCargo = c.codCargo
WHERE c.nome = 'Gerente';

GRANT SELECT ON vFuncionarioGerente TO secretaria;

-- Sim, mas depende do SGBD utilizado.

-- b) Tenha permissão para executar as operações de consulta e atualização nas tabelas FUNCIONARIO, DEPARTAMENTO e CARGO.

GRANT SELECT, UPDATE ON Funcionario TO secretaria;
GRANT SELECT, UPDATE ON Departamento TO secretaria;
GRANT SELECT, UPDATE ON Cargo TO secretaria;

-- c) NÃO tenha permissão para executar as operações de consulta e atualização nas tabelas FUNCIONARIO, DEPARTAMENTO e CARGO, concedidas na questão anterior.

REVOKE SELECT, UPDATE ON Funcionario FROM secretaria;
REVOKE SELECT, UPDATE ON Departamento FROM secretaria;
REVOKE SELECT, UPDATE ON Cargo FROM secretaria;

-- d) Tenha permissão de alteração APENAS a coluna SALARIO da tabela FUNCIONARIO.

GRANT UPDATE (salario) ON Funcionario TO secretaria;

-- e) Tenha permissão de administrador para acessar/manipular todos os bancos de dados.

GRANT ALL PRIVILEGES ON *.* TO secretaria@localhost WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- f) Remova todos os privilégios da tabela FUNCIONARIO.

REVOKE ALL ON Funcionario FROM secretaria;

-- g) Remova todos os privilégios de todos os bancos de dados.

REVOKE ALL PRIVILEGES, GRANT OPTION FROM secretaria@localhost;
FLUSH PRIVILEGES;

-- 3. Qual a diferença dos comandos a seguir?

-- Comando 1:					Comando 2:
-- REVOKE ALL PRIVILEGES			REVOKE ALL PRIVILEGES
-- ON Funcionário				ON *.*
-- FROM secretaria@localhost;			FROM secretaria@localhost

-- O Comando 1 revoga privilégios apenas para o banco de dados ou tabela Funcionario. Já o Comando 2 revoga privilégios globalmente.

-- 4. Considere os usuários criados na Questão 1, as tabelas da Questão 2 e a sequência de comandos de concessão e revogação de privilégios a seguir. Inicialmente, os usuários não possuem NENHUM privilégio em NENHUMA tabela.

-- # Comando
-- 1 REVOKE ALL ON Funcionario FROM teste@localhost;
-- 2 REVOKE ALL ON Departamento FROM teste@localhost;
-- 3 GRANT SELECT, INSERT, DELETE ON Cargo TO secretaria@localhost,
--   teste@localhost;
-- 4 REVOKE ALL ON Funcionario FROM teste@localhost;
--   REVOKE ALL ON Funcionario FROM root;
-- 5 REVOKE ALL ON Cargo FROM teste@localhost;
--   REVOKE ALL ON Cargo FROM root;
-- 6 GRANT SELECT (nome, admissao), DELETE ON Funcionario TO
--   teste@localhost;
-- 7 GRANT ALL ON Funcionario TO secretaria@localhost;
-- 8 GRANT USAGE ON Cargo TO secretaria@localhost;
-- 9 GRANT ALL ON *.* TO secretaria@localhost, teste@localhost;
-- 10 REVOKE ALL PRIVILEGES ON *.* FROM teste@localhost;

-- Responda as seguintes perguntas:

-- a) Inicialmente, qual o privilégio do usuário root na máquina local (localhost) e qual o privilégio do usuário root com acesso a qualquer host?

-- O root@localhost (inicialmente) possui todos os privilégios em todos os bancos de dados e tabelas, com exceção da tabela Funcionario. Já o root@'%' (inicialmente) possui todos os privilégios em todos os bancos de dados e tabelas.

-- b) Quais são as permissões disponíveis aos usuários secretaria e teste na máquina local antes e depois da execução de TODOS comandos SQL pelo administrador do banco de dados.

-- secretaria tem acesso total a todas as tabelas e bancos de dados, enquanto teste não tem nenhum privilégio.

-- 5. Mostrar todos os usuários do Banco de Dados.

SELECT user FROM mysql.user;

-- 6. Excluir os usuários secretaria e teste criados na Questão 1.

DROP USER secretaria@localhost;
DROP USER teste@localhost;
FLUSH PRIVILEGES;





