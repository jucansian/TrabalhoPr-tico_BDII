-- PRIMEIRA VERSÃO:
SELECT m.nome, count(c.id) AS consultas 
  FROM medico m, especialidade e, consulta c 
  WHERE m.id = c.id_medico 
  AND e.id = m.id_especialidade 
  AND c.data_hora_fim < DATE_ADD(sysdate(), INTERVAL 300 minute) 
  GROUP BY m.id 
  ORDER BY consultas DESC LIMIT 1;
  
-- VERSÃO OTIMIZADA:
CREATE INDEX idx_data_hora_fim ON consulta (data_hora_fim);
  
EXPLAIN SELECT m.nome, COUNT(c.id) AS consultas
  FROM medico m
  JOIN consulta c ON m.id = c.id_medico
  JOIN especialidade e ON m.id_especialidade = e.id
  WHERE c.data_hora_fim < DATE_ADD(sysdate(), INTERVAL 300 MINUTE)
  GROUP BY m.id
  ORDER BY consultas DESC LIMIT 1;

