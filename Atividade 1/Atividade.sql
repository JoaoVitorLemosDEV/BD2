-- João Vitor Lemos Oliveira

-- 5

SELECT 
    UPPER(p.nome) AS Participante, 
    p.sexo 
FROM participante AS p 
ORDER BY p.sexo DESC, p.nome ASC;

-- 6

SELECT 
    m.titulo AS Minicurso, 
    m.turma, 
    COUNT(i.cpf) AS QuantParticipante
FROM minicurso AS m
JOIN inscricao AS i ON m.codMinicurso = i.codMinicurso
WHERE i.ultima_inscricao = 'sim'
GROUP BY m.titulo, m.turma
ORDER BY QuantParticipante DESC;

-- 7

SELECT 
    p.nome, 
    (SELECT COUNT(i.codMinicurso) 
     FROM inscricao AS i 
     WHERE i.cpf = p.cpf 
     AND i.ultima_inscricao = 'sim') AS QuantidadeInscricoes
FROM participante AS p
WHERE (SELECT COUNT(i.codMinicurso) 
       FROM inscricao AS i 
       WHERE i.cpf = p.cpf 
       AND i.ultima_inscricao = 'sim') > 2
ORDER BY p.nome ASC;

-- 8

SELECT p.nome
FROM participante AS p
LEFT JOIN inscricao AS i ON p.cpf = i.cpf AND i.ultima_inscricao = 'sim'
WHERE i.cpf IS NULL
ORDER BY p.nome ASC;
