-- Departamento
INSERT INTO Departamento (codDepart, nome) VALUES (1, 'Vendas');

-- Cargo
INSERT INTO Cargo (codCargo, nome) VALUES (1, 'Gerente');
INSERT INTO Cargo (codCargo, nome) VALUES (2, 'Supervisor');
INSERT INTO Cargo (codCargo, nome) VALUES (3, 'Vendedor');

-- Funcionario
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (1, '11111111111', 'João', 1900.00, now(), 1, 1);
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (2, '22222222222', 'Adriana', 2500.00, now(), 2, 1);
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (3, '33333333333', 'Marcelo', 3000.00, now(), 3, 1);
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (4, '44444444444', 'Pedro', 4500.00, now(), 3, 1);
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (5, '55555555555', 'Adriano', 3799.98, now(), 3, 1);
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (6, '66666666666', 'Matheus', 2523.98, now(), 3, 1);
INSERT INTO Funcionario (codFunc, cpf, nome, salario, admissao, codCargo, codDepart) VALUES (7, '77777777777', 'Maria', 2220.09, now(), 1, 1);