-- PRIMEIRA VERSÃO:
SELECT e.nome, count(c.id) as qtde_consultas from especialidade e, medico m, consulta c where e.id = m.id_especialidade and m.id = c.id_medico group by e.nome;

-- VERSÃO OTIMIZADA:
ALTER TABLE medico ADD INDEX idx_id_especialidade (id_especialidade);
ALTER TABLE consulta ADD INDEX idx_id_medico (id_medico);

SELECT e.nome, COUNT(c.id) as qtde_consultas
  FROM especialidade e
  INNER JOIN medico m ON e.id = m.id_especialidade
  INNER JOIN consulta c ON m.id = c.id_medico
  GROUP BY e.nome
  HAVING MAX(c.data_hora_inicio) > NOW();

SELECT e.nome, COUNT(c.id) AS qtde_consultas
  FROM especialidade e
  INNER JOIN medico m ON e.id = m.id_especialidade
  INNER JOIN consulta c ON m.id = c.id_medico
  WHERE c.data_hora_inicio > NOW()
  GROUP BY e.nome;

EXPLAIN SELECT e.nome, COUNT(c.id) AS qtde_consultas
  FROM especialidade e
  INNER JOIN medico m ON e.id = m.id_especialidade
  INNER JOIN consulta c ON m.id = c.id_medico
  WHERE c.data_hora_inicio > NOW()
  GROUP BY e.nome;
