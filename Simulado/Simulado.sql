-- João Vitor Lemos Oliveira

-- 1. O Hospital não permitirá a visualização, inserção, atualização ou exclusão diretamente nas tabelas do banco de dados. Assim, as operações de escrita serão realizadas através de procedures, enquanto que as consultas serão pré-estabelecidas através de visões. Sabendo disso, faça o que se pede:
-- a) Crie um usuário com o nome de "Recepcionista". Esse usuário deve possuir uma senha e apenas terá acesso ao banco a partir da máquina local. Ele será o usuário utilizado nas transações iniciadas pela recepção do hospital.

CREATE USER Recepcionista@localhost IDENTIFIED BY 'JoaoLindo';

-- b) A recepção poderá consultar as consultas cadastradas, algumas informações dos pacientes e algumas informações dos médicos. Essas informações serão necessárias para o registro de novas consultas e para a confirmação de consultas já existentes. Portanto, crie a seguinte visão:
-- − Deve-se exibir, em relação a cada paciente, o nome completo, o CPF, a data de nascimento, a cor, o sexo, a quantidade de consultas aguardando atendimento, a quantidade de consultas que foram realizadas e a quantidade de consultas que foram canceladas.

CREATE VIEW visao_pacientes_consultas AS
SELECT p.nome_completo, p.cpf_paciente, p.data_nascimento, p.cor, p.sexo,
    (
        SELECT COUNT(*)
        FROM consulta c
        WHERE c.cpf_paciente = p.cpf_paciente AND c.status = 'Aguardando'
    ) AS qtd_aguardando,
    (
        SELECT COUNT(*)
        FROM consulta c
        WHERE c.cpf_paciente = p.cpf_paciente AND c.status = 'Realizada'
    ) AS qtd_realizadas,
    (
        SELECT COUNT(*)
        FROM consulta c
        WHERE c.cpf_paciente = p.cpf_paciente AND c.status = 'Cancelada'
    ) AS qtd_canceladas
FROM paciente p;

-- c) Conceda, ao usuário "Recepcionista", o privilégio de CONSULTA na visão criada no Item b). Em seguida, mostra os privilégios desse usuário.

GRANT SELECT ON visao_pacientes_consultas TO Recepcionista@localhost;
SHOW GRANTS FOR Recepcionista@localhost;

-- 2. O Hospital deseja melhorar o desempenho das consultas SQL com técnicas de tuning (otimização) a fim de permitir que os usuários acessem as informações mais rápidas. Diante deste contexto, responda:
-- a) Que técnica, estudada em BD-2, pode ser utilizada para aumentar o desempenho das consultas?

-- Indexação

-- b) Dê um exemplo de otimização que possa ser feita a partir da necessidade do usuário "Recepcionista".

-- A criação de índices para as colunas mais consultadas, como por exemplo:

CREATE INDEX idx_consulta_cpf_status ON consulta(cpf_paciente, status);
CREATE INDEX idx_paciente_cpf ON paciente(cpf_paciente);

-- c) Implemente o código do Item b) e dê um exemplo do uso da técnica criada.

EXPLAIN
SELECT COUNT(*) AS qtd_aguardando
FROM consulta
WHERE cpf_paciente = '14672391191'
  AND status = 'Aguardando';
  
-- 3. Responder as questões com as regras de negócio a fim de garantir as restrições de integridade:
-- a) Criar um gatilho (trigger), ao cadastrar um médico na tabela "Medico", a fim de efetuar duas verificações:
-- - Se a hierarquia do médico for "Residente", deve-se cadastrar um novo registro na tabela "Residente" com a data atual sendo a data de início da residência e a especialidade sendo "Clínica";
-- - Se a hierarquia do médico for "Docente", deve-se cadastrar um novo registro na tabela "Docente" com a titulação "Assistente", que é a titulação inicial do hospital.
-- Por fim, mostrar um exemplo de acionamento do gatilho para cada situação supracitada.

  DELIMITER //

CREATE TRIGGER trg_pos_insert_medico
AFTER INSERT ON medico
FOR EACH ROW
BEGIN
    
    IF NEW.hierarquia = 'Residente' THEN
        INSERT INTO residente (crm_residente, especialidade, data_inicio_residencia)
        VALUES (NEW.crm_medico, 'Clínica', CURDATE());
    
    ELSEIF NEW.hierarquia = 'Docente' THEN
        INSERT INTO docente (crm_docente, titulacao)
        VALUES (NEW.crm_medico, 'Assistente');
    END IF;
END//

DELIMITER ;

INSERT INTO medico (crm_medico, nome_completo, salario, hierarquia)
VALUES ('12345-RJ', 'João Silva', 8000.00, 'Residente');

INSERT INTO medico (crm_medico, nome_completo, salario, hierarquia)
VALUES ('67890-SP', 'Maria Oliveira', 12000.00, 'Docente');

-- b) Criar um procedimento (stored procedure) a fim de atualizar o status das consultas conforme as regras:
-- - Se o status está "Aguardando" e a consulta não foi realizada após 24 horas da data prevista de realização, o status da consulta deve ser alterado para "Cancelada";
-- - Se o status está "Aguardando" e a consulta foi realizada até 24 horas da data prevista de realização, o status da consulta deve ser alterado para "Realizada".
-- Por fim, mostrar como é feita a chamada do procedimento.

DELIMITER //

CREATE PROCEDURE atualizar_status_consultas()
BEGIN
    
    UPDATE consulta
    SET status = 'Cancelada'
    WHERE status = 'Aguardando'
      AND data_hora_consulta_realizada IS NULL
      AND data_hora_consulta_prevista < NOW() - INTERVAL 1 DAY;

    UPDATE consulta
    SET status = 'Realizada'
    WHERE status = 'Aguardando'
      AND data_hora_consulta_realizada IS NOT NULL
      AND TIMESTAMPDIFF(HOUR, data_hora_consulta_prevista, data_hora_consulta_realizada) <= 24;
END//

DELIMITER ;

CALL atualizar_status_consultas();

-- c) Criar uma função (function) que retorna a quantidade de consulta com status "Aguardando" de um paciente para um específico tipo de exame, tendo o CPF do paciente e o tipo de exame como parâmetros.
-- Por fim, mostrar um exemplo de chamada da função.

DELIMITER //

CREATE FUNCTION qtd_consultas_aguardando(cpf_param CHAR(11), tipo_exame_param ENUM('Ecocardiograma','Eletrocardiograma','Mapa','Holter'))
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE qtd INT;

    SELECT COUNT(*) INTO qtd
    FROM consulta
    WHERE cpf_paciente = cpf_param
      AND tipo_exame = tipo_exame_param
      AND status = 'Aguardando';

    RETURN qtd;
END//

DELIMITER ;

SELECT qtd_consultas_aguardando('14672391191', 'Holter') AS total_aguardando;

-- d) Um paciente pode agendar várias consultas para diferentes tipos de exame, exceto fazer um agendamento para o mesmo tipo de exame que ainda esteja com status "Aguardando". Assim, é necessário criar um gatilho (trigger) para atender essa regra de negócio. Então, o gatilho:
-- - Não deve permitir a inserção de uma consulta com o mesmo tipo de exame se já existir uma, com status "Aguardando", para o mesmo paciente;
-- - Deve emitir uma mensagem de erro para o usuário, caso esta regra de negócio seja infringida.
-- Por fim, mostrar um exemplo de acionamento do gatilho.
-- OBS: Utilizar a função criação no Item c) a fim de auxiliar na resolução desta questão.

DELIMITER //

CREATE TRIGGER trg_prevent_duplicate_exame_aguardando
BEFORE INSERT ON consulta
FOR EACH ROW
BEGIN
    DECLARE qtd INT;

    SET qtd = qtd_consultas_aguardando(NEW.cpf_paciente, NEW.tipo_exame);

    IF qtd > 0 THEN
        SIGNAL SQLSTATE '80000'
        SET MESSAGE_TEXT = 'Erro: Já existe uma consulta aguardando para esse tipo de exame e paciente.';
    END IF;
END//

DELIMITER ;

-- Válido
INSERT INTO consulta (
    data_hora_consulta_prevista,
    hipotese_diagnostica,
    valor_consulta,
    tipo_exame,
    status,
    crm_medico,
    cpf_paciente
) VALUES (
    '2025-06-01 10:00:00',
    'Arritmia',
    250.00,
    'Holter',
    'Aguardando',
    '12345-RJ',
    '12345678900'
);

-- Erro
INSERT INTO consulta (
    data_hora_consulta_prevista,
    hipotese_diagnostica,
    valor_consulta,
    tipo_exame,
    status,
    crm_medico,
    cpf_paciente
) VALUES (
    '2025-06-02 09:00:00',
    'Taquicardia',
    250.00,
    'Holter',
    'Aguardando',
    '12345-RJ',
    '12345678900'
);

-- 4. O Hospital terá uma alta quantidade de acessos simultâneos. Sendo assim, deseja-se que o SGBD seja o mais performático possível. Todavia, por questões de segurança e integridade, não deve ser permitido que dados que não foram efetivamente gravados na base de dados possam ser lidos por alguma outra transação. Sendo assim, o problema da leitura suja não pode ocorrer. Tendo em vista esse cenário, responda:
-- a) Qual é o nível de isolamento ideal para o SGBD nesse cenário?

-- Read Commited.

-- b) Demonstre o problema da leitura suja utilizando um nível de isolamento diferente do informado no Item a).

-- Transação 1
START TRANSACTION;

UPDATE medico
SET salario = 99999.99
WHERE crm_medico = '111224-BA';

-- Transação 2
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

SELECT salario
FROM medico
WHERE crm_medico = '111224-BA';

-- Transação 1 decide desfazer
ROLLBACK;

-- 5. Os dois esquemas conceituais conseguem armazenar as mesmas informações? Qual a vantagem de um esquema em relação ao outro? Explique e justifique sua resposta.

-- Ambos os esquemas conceituais armazenam as mesmas informações, porém o segundo também registra o identificador do empréstimo. A principal vantagem do segundo esquema é a possibilidade de expansão futura, facilitando a adição de novos atributos relacionados ao empréstimo. Já o primeiro esquema se destaca pela simplicidade, sendo mais adequado em contextos com menor complexidade ou quando não há necessidade de gerenciar muitos detalhes sobre os empréstimos.

-- 6. Faça o mapeamento dos seguintes Esquemas Conceituais para o respectivo Esquema Relacional Descritivo:

-- a)

-- Departamento (codigo*, nome)
-- Empregado (cpf*, codigo*, nome, data_inicio)
-- 	codigo referncia Departamento

-- b)

-- Cliente (cpf*, nome, estadoCivil, fone)
-- Conjuge (cpf, nome, cpf_cliente*)
-- 	cpf_cliente referencia Cliente

-- 7. Considere a relação Artista a seguir.
-- Artista (cod_artista, nome_artista, cod_disco, titulo_disco, quantidade_de_musicas, cod_genero, descricao_genero, data_de_producao, data_de_gravacao, cod_local, nome_local)
-- Considere as seguintes Regras de Negócio:
-- − Um artista possui um nome que é identificado pelo código do artista;
-- − Um disco possui um título e uma determinada quantidade de músicas que são identificadas pelo código do disco;
-- − Cada gênero musical possui uma descrição que é identificada pelo código do gênero;
-- − Um disco possui um gênero musical e um gênero pode estar associado a mais de um disco;
-- − Um artista pode produzir vários discos e um disco pode ser produzido por vários artistas diferentes. Cada disco que é produzido por um artista possui uma data que deve ser registrada no sistema. Ademais, um artista não pode produzir um mesmo disco mais de uma vez;
-- − Um local de gravação possui um nome que é identificado pelo código do local;
-- − Um disco produzido por um artista pode ser gravado em diferentes locais, e nesta ocasião, a data de cada gravação deve ser registrada no sistema. O artista não pode, no mesmo local, gravar o disco em datas diferentes.
-- Responda as questões a seguir de acordo com o conceito de Normalização.
-- a) Lista as Dependências Funcionais (DFs) da relação Artista, e em seguida, mescla as DFs, se necessário.

-- DF1: cod_artista -> nome artista
-- DF2: cod_disco -> titulo disco, quantidade_de_musicas, cod_genero
-- DF3: cod_genero -> descricao_genero,
-- DF4: cod_local -> nome local 
-- DF5: (cod_artista, cod_disco) -> data_de_producao
-- DF6: (cod_artista, cod_disco, cod_local) -> data_de_gravacao

-- Não é necessario mesclar as DF's

-- b) A relação Artista fere alguma das três formas normais (FN) estudadas em sala de aula? Se sim, informa qual(is) e justifica sua resposta e, se necessário, informa qual(is) DF(s) fere(m) a FN em questão. Em seguida, Normaliza a relação Artista até a 3FN.

-- Não fere a 1FN porque não há atributos multivalorados 
-- DF1, DF2, DF4 e DF5 ferem a 2FN porque os atributos não chave (nome artista, titulo disco, quantidade_de_musicas, cod_genero, nome local, data_de_producao) dependem de parte da chave, respectivamente cod_artista, cod_disco, cod_local
 
 -- Normalizando: 
-- Artista(cod_artista, nome artista)
-- Disco(cod_disco, titulo disco, quantidade_de_musicas, cod_genero)
-- Local(cod_local, nome local)
-- Producao(cod_artista, cod_disco, data_de_producao)
-- 	cod_artista referencia Artista
-- 	cod_disco referencia Disco
-- Gravação(cod_artista, cod_disco, cod_local, data_de_gravacao)
-- 	cod_artista referencia Artista
-- 	cod_disco referencia Disco
-- 	cod_local referencia Local

-- Fere a 3FN porque descricao_genero depende de outro atributo não chave, cod_genero, que por sua vez depende de um atributo chave (cod_disco) gerando assim uma dependencia transitiva (cod_disco -> descricao_genero). 

-- Relação normalizada:

-- Artista(cod_artista, nome artista)
-- Genero(cod_genero, descricao_genero, data produção)
-- Disco(cod_disco, titulo disco, quantidade_de_musicas, cod_genero)
-- 	cod_genero referencia Genero
-- Local(cod_local, nome local)
-- Producao(cod_artista, cod_disco, data_de_producao)
-- 	cod_artista referencia Artista
-- 	cod_disco referencia Disco
-- Gravação(cod_artista, cod_disco, cod_local, data_de_gravacao)
-- 	cod_artista referencia Artista
-- 	cod_disco referencia Disco
-- 	cod_local referencia Local

-- 8. Elabore as consultas a seguir utilizando o comando SELECT da DML/SQL, a partir da base de dados AgendaAuditório, disponível no Google Classroom. Utilize alias nas junções das tabelas e nos campos quando necessário. ATENÇÃO: cada comando SQL deve ser escrito em uma única linha.
-- a) Qual o nome e o e-mail dos servidores que não fizeram nenhuma reserva do auditório? Utilize o operador Exists.

SELECT s.nome, s.email 
FROM servidor s 
WHERE NOT EXISTS (
SELECT 1 
FROM reservaauditorio ra 
WHERE ra.siape = s.siape
);

-- b) Quais os servidores fizeram a maior quantidade de solicitação de reserva do auditório? Mostrar o nome do servidor em ordem alfabética. Utilize o operador All.

SELECT s.nome 
FROM servidor s 
JOIN reservaauditorio ra ON s.siape = ra.siape 
GROUP BY s.siape, s.nome 
HAVING COUNT(ra.codReserva) >= ALL (
SELECT COUNT(ra2.codReserva) 
FROM reservaauditorio ra2 
WHERE ra2.siape IS NOT NULL GROUP BY ra2.siape
) 
ORDER BY s.nome;

-- c) Quais os servidores (SIAPE e nome) fizeram pelo menos 03 (três) solicitações de reserva do auditório, cujas solicitações foram feitas em outubro de 2024? Mostrar em ordem crescente pelo nome do servidor.

SELECT s.siape, s.nome AS Servidor 
FROM servidor s 
JOIN reservaauditorio ra ON s.siape = ra.siape 
WHERE DATE_FORMAT(ra.dataHoraSolicitacao, '%Y-%m') = '2024-10' 
GROUP BY s.siape, s.nome 
HAVING COUNT(ra.codReserva) >= 3 
ORDER BY s.nome ASC;
