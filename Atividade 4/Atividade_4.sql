-- João Vitor Lemos Oliveira


-- 1. Elaborar uma função, que tem como parâmetro o nome do canal, a fim de retornar a quantidade de usuários inscritos em um determinado canal.

DELIMITER //
DROP FUNCTION IF EXISTS f_qtdInscritos//
CREATE FUNCTION f_qtdInscritos (nome_canal VARCHAR(50)) RETURNS INT 
DETERMINISTIC
BEGIN
	RETURN (SELECT quantidade_inscritos FROM canal WHERE nome = nome_canal);
END//
DELIMITER ;

SELECT f_qtdInscritos('Akitando') AS QuantidadeDeInscritos;

-- 2. Elaborar uma função, que tem como parâmetro o nome do canal e o ano da transmissão que deve ser em número cardinal (por exemplo, 2), a fim de retornar a média de visualizações de um canal nos últimos X anos. Deve-se:
-- − Considerar somente o campo data_hora_inicio para calcular as visualizações nos últimos X anos;
-- − Utilizar a função DATE_SUB que subtrai um intervalo de tempo especificado de uma data. Por exemplo, SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR).

DELIMITER //
DROP FUNCTION IF EXISTS f_mediaVisualizacoes//
CREATE FUNCTION f_mediaVisualizacoes(nome_canal VARCHAR(50), anos INT) RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
	DECLARE media DECIMAL(10,2);
    
    SET @data_limite = DATE_SUB(CURRENT_DATE(), INTERVAL anos YEAR);

	SET media = (SELECT (AVG(t.quantidade_visualizacoes)) FROM transmissao t
    JOIN canal c ON c.codigo = t.codigo_canal
    WHERE c.nome = nome_canal AND t.data_hora_inicio >= @data_limite);
    RETURN media;
END//
DELIMITER ;

SELECT f_mediaVisualizacoes('CS50', 2) MediaDeVisualizacoes;

-- 3. Elaborar um procedimento, sem parâmetro, para registrar quais canais possuem no mínimo 1.000 inscrições e conseguiram atingir um total de 10.000 visualizações nos últimos 4 meses. Deve-se:
-- − Inserir os canais na tabela HistoricoCanal, a qual deve ser criada dentro do procedimento, caso não exista. Essa tabela tem os seguintes campos obrigatórios: o código, o nome, a descrição, a quantidade de inscritos e de visualizações do canal, e a data/hora atual. Um determinado canal pode aparecer na tabela de histórico mais de uma vez;
-- − Utilizar a função DATE_SUB que subtrai um intervalo de tempo especificado de uma data. Por exemplo, SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 2 MONTH).

DELIMITER //
DROP PROCEDURE IF EXISTS sp_historico//
CREATE PROCEDURE sp_historico()
BEGIN
	DECLARE data_limite DATETIME;
    
	SET data_limite = DATE_SUB(NOW(), INTERVAL 4 MONTH);
    
    CREATE TABLE IF NOT EXISTS HistoricoCanal (
		codigo INT PRIMARY KEY,
        nome VARCHAR(50),
        descricao VARCHAR(256),
        Quantidade_inscritos INT,
        visualizacoes INT,
        data_hora_atual DATETIME
    );
    
    INSERT INTO HistoricoCanal (codigo, nome, descricao, Quantidade_inscritos, visualizacoes, data_hora_atual)
    SELECT c.codigo, c.nome, c.descricao, c.Quantidade_inscritos, SUM(t.quantidade_visualizacoes), NOW() FROM canal c
    JOIN transmissao t ON t.codigo_canal = c.codigo
    WHERE t.data_hora_inicio >= data_limite
    GROUP BY c.codigo, c.nome, c.descricao, c.quantidade_inscritos
    HAVING c.Quantidade_inscritos >= 1000 AND SUM(t.quantidade_visualizacoes) >= 10000;
END//

DELIMITER ;
CALL sp_historico();

-- 4. Elaborar procedimento, sem parâmetro, para desativar a conta de todos os usuários que acessaram a plataforma, pela última vez, há mais de 3 anos. Para desativar uma conta, precisa definir o “Status” como “Desativado”.

DELIMITER //
DROP PROCEDURE IF EXISTS desativar_contas_inativas//
CREATE PROCEDURE desativar_contas_inativas()
BEGIN
  UPDATE usuario
  SET Status = 'Desativado'
  WHERE Data_hora_ultimo_acesso < DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
    AND Status = 'Ativado';  -- Somente usuários com status "Ativado" serão atualizados
END//

DELIMITER ;

CALL desativar_contas_inativas();

-- 5. Elaborar um procedimento, sem parâmetro, para atualizar o nível de influência dos canais registrados no banco de dados. Para isso, é necessário calcular, para cada canal, a média de visualizações por transmissão dos últimos 2 anos. Se a média de visualizações for:
-- − Até 50, o canal tem uma influência quase nula, então defina o campo nivel_influencia para 4;
-- − Até 500, o canal tem pouca influência, então defina o campo nivel_influencia para 3;
-- − Até 10.000, o canal é bastante influente, então defina o campo nivel_influencia para 2; e
-- − Maior do que 10.000, o canal é extremamente influente, então defina o campo nivel_influencia para 1.
-- Elaborar uma função para auxiliar na resolução desta questão.

DELIMITER //
CREATE FUNCTION media_visualizacoes(codigo_canal INT) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE media INT;
    
    SELECT AVG(Quantidade_visualizacoes) INTO media
    FROM transmissao
    WHERE codigo_canal = codigo_canal
    AND Data_hora_inicio >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR);

    RETURN media;
END//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE atualizar_nivel_influencia()
BEGIN
    DECLARE canal_codigo INT;
    DECLARE media INT;
    DECLARE fim INT DEFAULT 0;

    DECLARE canal_cursor CURSOR FOR 
        SELECT Codigo FROM canal;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;
    OPEN canal_cursor;
    canal_loop: LOOP
        FETCH canal_cursor INTO canal_codigo;
        IF fim = 1 THEN
            LEAVE canal_loop;
        END IF;
        SET media = media_visualizacoes(canal_codigo);
        IF media <= 50 THEN
            UPDATE canal SET Nivel_Influencia = 4 WHERE Codigo = canal_codigo;
        ELSEIF media <= 500 THEN
            UPDATE canal SET Nivel_Influencia = 3 WHERE Codigo = canal_codigo;
        ELSEIF media <= 10000 THEN
            UPDATE canal SET Nivel_Influencia = 2 WHERE Codigo = canal_codigo;
        ELSE
            UPDATE canal SET Nivel_Influencia = 1 WHERE Codigo = canal_codigo;
        END IF;
    END LOOP;

    CLOSE canal_cursor;
END//
DELIMITER ;

CALL atualizar_nivel_influencia();

