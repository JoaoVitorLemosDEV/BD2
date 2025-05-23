-- João Vitor Lemos Oliveira

-- 6. Quais os alunos (nome e nota) ficaram com nota acima de 7 na disciplina Estrutura de Dados?

SELECT a.nome, c.nota
FROM aluno a
JOIN concluido c ON a.matricula = c.matricula
JOIN disciplina d ON c.codDisciplina = d.codDisciplina
WHERE d.nome = 'Estrutura de Dados' AND c.nota > 7;

-- 7. Qual o total das disciplinas do curso Agronomia? Usar alias TotalDiscAgronomia.

SELECT COUNT(d.codDisciplina) AS TotalDiscAgronomia
FROM disciplina d
JOIN matriculado m ON d.codDisciplina = m.codDisciplina
JOIN aluno a ON m.matricula = a.matricula
JOIN curso c ON a.codCurso = c.codCurso
WHERE c.nome = 'Agronomia';

-- 8. Qual a quantidade de alunos do sexo masculino e feminino matriculados na disciplina Introdução a Programação? Mostrar a quantidade para cada sexo em uma única consulta SQL. Utilizar o alias TotalAluno.

SELECT a.sexo, COUNT(a.matricula) AS TotalAluno
FROM aluno a
JOIN matriculado m ON a.matricula = m.matricula
JOIN disciplina d ON m.codDisciplina = d.codDisciplina
WHERE d.nome = 'Introducao a Programacao'
GROUP BY a.sexo;

-- 9. *Qual a disciplina do curso de Sistemas de Informação com maior número de aprovação? Considerar a nota da tabela Concluído como sendo a média final do aluno na disciplina, sendo a média final de aprovação maior igual a 6,0.

SELECT d.nome AS Disciplina, COUNT(c.matricula) AS NumeroDeAprovacoes
FROM disciplina d
JOIN matriculado m ON d.codDisciplina = m.codDisciplina
JOIN aluno a ON m.matricula = a.matricula
JOIN concluido c ON a.matricula = c.matricula AND c.codDisciplina = d.codDisciplina
JOIN curso cu ON a.codCurso = cu.codCurso
WHERE cu.nome = 'Sistemas de Informacao'
AND c.nota >= 6.0
GROUP BY d.codDisciplina
ORDER BY NumeroDeAprovacoes DESC
LIMIT 1;

-- 10. A disciplina Estrutura de Dados é pré-requisito de quais disciplinas? Utilizar subconsulta.

SELECT d.nome AS Disciplina
FROM disciplina d
WHERE d.codDisciplina IN (
    SELECT p.codDisciplina
    FROM prerequisito p
    WHERE p.codPrerequisito = (
        SELECT codDisciplina
        FROM disciplina
        WHERE nome = 'Estrutura de Dados'
    )
);




