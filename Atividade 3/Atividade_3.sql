-- João Vitor Lemos Oliveira

-- 5. Quais as disciplinas não têm nenhum pré-requisito? Fazer solução com Join, outra com Exists e outra com All.

-- JOIN

SELECT d.nome
FROM disciplinas d
LEFT JOIN pre_requisitos p ON d.id = p.disciplina_id
WHERE p.pre_requisito_id IS NULL;

-- EXISTS

SELECT d.nome
FROM disciplinas d
WHERE NOT EXISTS (
    SELECT 1 FROM pre_requisitos p WHERE p.disciplina_id = d.id
);

-- ALL

SELECT d.nome
FROM disciplinas d
WHERE d.id <> ALL (SELECT p.disciplina_id FROM pre_requisitos p);


-- 6. Qual a menor e a maior nota dos alunos que concluíram a disciplina Estrutura de Dados? Utilizar as funções de agregação estudadas em BD-I.

SELECT MIN(n.nota) AS menor_nota, MAX(n.nota) AS maior_nota
FROM notas n
JOIN disciplinas d ON n.disciplina_id = d.id
WHERE d.nome = 'Estrutura de Dados';


-- 7. Quais os alunos do sistema acadêmico possuem nota maior do que todos os alunos que concluíram a disciplina Banco de Dados I? Informar o nome, a nota, o curso e a disciplina destes alunos. Utilizar os alias apropriados. Fazer solução com All.

SELECT a.nome, n.nota, c.nome AS curso, d.nome AS disciplina
FROM alunos a
JOIN notas n ON a.id = n.aluno_id
JOIN disciplinas d ON n.disciplina_id = d.id
JOIN cursos c ON a.curso_id = c.id
WHERE n.nota > ALL (
    SELECT n2.nota
    FROM notas n2
    JOIN disciplinas d2 ON n2.disciplina_id = d2.id
    WHERE d2.nome = 'Banco de Dados I'
);


-- 8. Quais os alunos do sistema acadêmico possuem nota menor do que algum aluno que concluiu a disciplina Estrutura de Dados? Informar o nome, a nota, o curso e a disciplina destes alunos. Utilizar os alias apropriados. Fazer solução com Some.

SELECT a.nome, n.nota, c.nome AS curso, d.nome AS disciplina
FROM alunos a
JOIN notas n ON a.id = n.aluno_id
JOIN disciplinas d ON n.disciplina_id = d.id
JOIN cursos c ON a.curso_id = c.id
WHERE n.nota < SOME (
    SELECT n2.nota
    FROM notas n2
    JOIN disciplinas d2 ON n2.disciplina_id = d2.id
    WHERE d2.nome = 'Estrutura de Dados'
);

