-- PRIMEIRA VERSÃO:
SELECT m.nome, COUNT(c.id) AS qtde_consultas FROM medico m, consulta c 
  WHERE m.id = c.id_medico 
  AND c.data_hora_inicio > sysdate() 
  GROUP BY m.nome 
  ORDER BY m.nome;

-- VERSÃO OTIMIZADA 1:
CREATE INDEX idx_id_medico ON consulta(id_medico);

SELECT m.nome, count(c.id) as qtde_consultas FROM medico m
  JOIN consulta c ON m.id = c.id_medico
  WHERE c.data_hora_inicio > sysdate()
  GROUP BY m.nome
  ORDER BY m.nome;
  
-- VERSÃO OTIMIZADA 2:
CREATE INDEX idx_id_medico ON consulta(id_medico);

EXPLAIN SELECT m.nome, COUNT(c.id) AS qtde_consultas
  FROM medico m
  JOIN consulta c ON m.id = c.id_medico
  WHERE c.data_hora_inicio > sysdate()
  GROUP BY m.nome
  HAVING qtde_consultas > 0
  ORDER BY m.nome;
