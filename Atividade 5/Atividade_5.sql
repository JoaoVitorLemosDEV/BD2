-- João Vitor Lemos Oliveira

-- 1. Crie um gatilho que, sempre que um funcionário for excluído, realize automaticamente a exclusão dos seus dependentes.

DELIMITER //

CREATE TRIGGER before_delete_funcionario
BEFORE DELETE ON funcionario
FOR EACH ROW
BEGIN
    DELETE FROM dependente
    WHERE matricula = OLD.matricula;
END//

DELIMITER ;

-- 2. Crie um gatilho que, ao excluir um projeto, remova automaticamente todos os registros relacionados a ele, como as horas trabalhadas e as alocações de funcionários.

DELIMITER //

CREATE TRIGGER before_delete_projeto
BEFORE DELETE ON projeto
FOR EACH ROW
BEGIN

    DELETE FROM horastrabalhadas
    WHERE codProjeto = OLD.codProjeto;


    DELETE FROM funcionarioprojeto
    WHERE codProjeto = OLD.codProjeto;
END//

DELIMITER ;

-- 3. Crie um gatilho que impeça a inserção de novos dependentes, conforme as regras a seguir:
-- − Para dependentes do sexo masculino (M): idade não pode ser superior a 18 anos.
-- − Para dependentes do sexo feminino (F): idade não pode ser superior a 21 anos.
-- Ao tentar inserir registros que não atendam a essas regras, o sistema deverá emitir uma mensagem de erro explicativa ao usuário.

DELIMITER //

CREATE TRIGGER before_insert_dependente
BEFORE INSERT ON dependente
FOR EACH ROW
BEGIN
    DECLARE idade INT;

    SET idade = TIMESTAMPDIFF(YEAR, NEW.dataNascimento, CURDATE());

    IF NEW.sexo = 'M' AND idade > 18 THEN
        SIGNAL SQLSTATE '80000'
        SET MESSAGE_TEXT = 'Erro: Dependentes do sexo masculino não podem ter mais de 18 anos.';
    
    ELSEIF NEW.sexo = 'F' AND idade > 21 THEN
        SIGNAL SQLSTATE '80000'
        SET MESSAGE_TEXT = 'Erro: Dependentes do sexo feminino não podem ter mais de 21 anos.';
    END IF;
END//

DELIMITER ;

-- 4. Crie um gatilho que impeça que um funcionário seja designado como seu próprio supervisor. Esse controle deve ser feito tanto em operações de inserção quanto de atualização do campo matricula Supervisor. Se a matrícula do funcionário for igual à de seu supervisor, uma mensagem de erro deve ser retornada.

DELIMITER //

CREATE TRIGGER before_insert_funcionario
BEFORE INSERT ON funcionario
FOR EACH ROW
BEGIN
    IF NEW.matriculaSupervisor IS NOT NULL AND NEW.matriculaSupervisor = NEW.matricula THEN
        SIGNAL SQLSTATE '80000'
        SET MESSAGE_TEXT = 'Erro: Um funcionário não pode ser seu próprio supervisor.';
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_update_funcionario
BEFORE UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF NEW.matriculaSupervisor IS NOT NULL AND NEW.matriculaSupervisor = NEW.matricula THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Um funcionário não pode ser seu próprio supervisor.';
    END IF;
END//

DELIMITER ;

-- 5. Crie um gatilho que impeça a criação ou atualização de projetos com mais de 2.000 horas previstas (horasPrevistas). Caso a restrição seja violada, o sistema deverá emitir uma mensagem de erro apropriada.

DELIMITER //

CREATE TRIGGER before_insert_projeto
BEFORE INSERT ON projeto
FOR EACH ROW
BEGIN
    IF NEW.horasPrevistas > 2000 THEN
        SIGNAL SQLSTATE '80000'
        SET MESSAGE_TEXT = 'Erro: Um projeto não pode ter mais de 2.000 horas previstas.';
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_update_projeto
BEFORE UPDATE ON projeto
FOR EACH ROW
BEGIN
    IF NEW.horasPrevistas > 2000 THEN
        SIGNAL SQLSTATE '80000'
        SET MESSAGE_TEXT = 'Erro: Um projeto não pode ter mais de 2.000 horas previstas.';
    END IF;
END//

DELIMITER ;

-- 6. Crie um gatilho que aumente o salário de um funcionário em R$ 800,00 toda vez que ele for alocado a um projeto. Esse bônus deve ser removido nas seguintes situações:
-- − Quando a alocação for encerrada (dataFim preenchida na tabela FuncionarioProjeto);
-- − Quando a alocação for excluída.
-- O gatilho deve garantir que o valor da bonificação seja corretamente ajustado nesses casos.

DELIMITER //

CREATE TRIGGER after_insert_funcionarioprojeto
AFTER INSERT ON funcionarioprojeto
FOR EACH ROW
BEGIN
    UPDATE funcionario
    SET salario = salario + 800
    WHERE matricula = NEW.matricula;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_update_funcionarioprojeto
AFTER UPDATE ON funcionarioprojeto
FOR EACH ROW
BEGIN
    IF NEW.dataFim IS NOT NULL AND OLD.dataFim IS NULL THEN
        UPDATE funcionario
        SET salario = salario - 800
        WHERE matricula = NEW.matricula;
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_delete_funcionarioprojeto
AFTER DELETE ON funcionarioprojeto
FOR EACH ROW
BEGIN
    UPDATE funcionario
    SET salario = salario - 800
    WHERE matricula = OLD.matricula;
END//

DELIMITER ;
