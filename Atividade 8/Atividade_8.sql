-- João Vitor Lemos Oliveira

-- 1. Mostrar em consulta SQL qual a Engine das tabelas do BD Certificados10k.

SELECT table_name, engine
FROM information_schema.tables
WHERE table_schema = 'certificados10k';

-- 2. Mostrar em consulta SQL quais os índices das tabelas participante e evento.

SHOW INDEX FROM participante FROM certificados10k;
SHOW INDEX FROM evento FROM certificados10k;

-- 3. Mostrar o comando SQL para criar o índice secundário idx_nome_completo na tabela participante e idx_ano na tabela evento.

CREATE INDEX idx_nome_completo 
ON participante (nome_completo);

CREATE INDEX idx_ano 
ON evento (ano);

-- 4. Mostrar o desempenho de uma consulta pontual usando o índice primário e comparar o resultado com e sem o índice secundário idx_nome_completo. Exemplo:
--  - Procurar o participante pelo ID (índice primário)

EXPLAIN SELECT * FROM participante WHERE id = 2;

--  - Procurar o participante pelo nome_completo (sem índice)

DROP INDEX idx_nome_completo ON participante;
EXPLAIN SELECT * FROM participante WHERE nome_completo = 'Marcelo da Cunha Domingues';

--  - Procurar o participante pelo nome_completo (índice secundário)

CREATE INDEX idx_nome_completo ON participante (nome_completo);
EXPLAIN SELECT * FROM participante WHERE nome_completo = 'Marcelo da Cunha Domingues';

-- 5. Mostrar o desempenho de uma consulta com junção com e sem o índice secundário idx_nome_completo. Exemplo: Procurar as atividades de um participante. Mostrar o título e a carga horária da atividade, e o nome, a sigla e o ano do evento.

DROP INDEX idx_nome_completo ON participante;

EXPLAIN
SELECT a.titulo, a.carga_horaria, e.nome AS nome_evento, e.sigla, e.ano
FROM participacao p
JOIN atividade a ON p.atividade_id = a.id
JOIN evento e ON p.evento_id = e.id
WHERE p.participante_id = 2;

CREATE INDEX idx_nome_completo ON participante (nome_completo);

EXPLAIN
SELECT a.titulo, a.carga_horaria, e.nome AS nome_evento, e.sigla, e.ano
FROM participante pa
JOIN participacao p ON pa.id = p.participante_id
JOIN atividade a ON p.atividade_id = a.id
JOIN evento e ON p.evento_id = e.id
WHERE pa.nome_completo = 'Marcelo da Cunha Domingues';

-- 6. Mostrar o desempenho de uma subconsulta com e sem o índice secundário idx_nome_completo. Exemplo: Procurar as atividades de um participante. Mostrar o título e a carga horária da atividade.

DROP INDEX idx_nome_completo ON participante;

EXPLAIN
SELECT a.titulo, a.carga_horaria
FROM atividade a
WHERE a.id IN (
    SELECT p.atividade_id
    FROM participacao p
    JOIN participante pa ON p.participante_id = pa.id
    WHERE pa.nome_completo = 'Marcelo da Cunha Domingues'
);

CREATE INDEX idx_nome_completo ON participante (nome_completo);

EXPLAIN
SELECT a.titulo, a.carga_horaria
FROM atividade a
WHERE a.id IN (
    SELECT p.atividade_id
    FROM participacao p
    JOIN participante pa ON p.participante_id = pa.id
    WHERE pa.nome_completo = 'Marcelo da Cunha Domingues'
);

-- 7. Acrescentar na subconsulta da questão anterior o nome, a sigla e o ano do evento. Para isto, utilizar junção para mostrar essas informações. Mostrar o desempenho da nova subconsulta com e sem o índice secundário idx_nome_completo.

DROP INDEX idx_nome_completo ON participante;

EXPLAIN
SELECT a.titulo, a.carga_horaria, e.nome AS nome_evento, e.sigla, e.ano
FROM atividade a
JOIN participacao p ON a.id = p.atividade_id
JOIN evento e ON p.evento_id = e.id
WHERE p.participante_id IN (
    SELECT pa.id
    FROM participante pa
    WHERE pa.nome_completo = 'Marcelo da Cunha Domingues'
);

CREATE INDEX idx_nome_completo ON participante (nome_completo);

EXPLAIN
SELECT a.titulo, a.carga_horaria, e.nome AS nome_evento, e.sigla, e.ano
FROM atividade a
JOIN participacao p ON a.id = p.atividade_id
JOIN evento e ON p.evento_id = e.id
WHERE p.participante_id IN (
    SELECT pa.id
    FROM participante pa
    WHERE pa.nome_completo = 'Marcelo da Cunha Domingues'
);

-- 8. Mostrar o desempenho de uma consulta com faixa de valores com e sem o índice secundário idx_ano.
-- Exemplo:
-- Na consulta com a utilização do índice secundário, pergunta-se:
-- (i) Caso o índice não foi utilizado, explica por que não foi. Em seguida, altera os valores do período e mostra um exemplo de consulta que usa o índice idx_ano.
-- (ii) Caso o índice foi utilizado, altera os valores do período e mostra um exemplo de consulta que não usa o índice idx_ano. Em seguida, explica por que o índice não foi utilizado.

-- - Procurar o evento no período de X a Y (sem índice)

DROP INDEX idx_ano ON evento;

EXPLAIN
SELECT * FROM evento
WHERE ano BETWEEN 2016 AND 2021;

-- - Procurar o evento no período de X a Y (índice secundário)

CREATE INDEX idx_ano ON evento (ano);

EXPLAIN
SELECT * FROM evento
WHERE ano BETWEEN 2016 AND 2021;

-- O índice não foi usado, pois o MySQL pode ter achado que olhar a tabela toda fosse mais rápido do que procurar pelo índice.

EXPLAIN
SELECT * FROM evento
WHERE ano = 2020;

-- 9. Mostrar o desempenho de uma consulta com agrupamento com e sem o índice secundário. Em seguida, alterar a consulta criada para utilizar o índice primário. Utiliza-se um dos índices criados ou cria-se um novo índice.

DROP INDEX idx_nome_completo ON participante;

EXPLAIN
SELECT nome_completo, COUNT(*) AS total_participantes
FROM participante
GROUP BY nome_completo;

CREATE INDEX idx_nome_completo ON participante (nome_completo);

EXPLAIN
SELECT nome_completo, COUNT(*) AS total_participantes
FROM participante
GROUP BY nome_completo;

EXPLAIN
SELECT pa.id, pa.nome_completo, COUNT(p.id) AS total_participacoes
FROM participante pa
JOIN participacao p ON pa.id = p.participante_id
GROUP BY pa.id, pa.nome_completo;

-- 10. Mostrar o comando SQL para excluir os índices secundários idx_nome_completo e idx_ano.

DROP INDEX idx_nome_completo ON participante;

DROP INDEX idx_ano ON evento;