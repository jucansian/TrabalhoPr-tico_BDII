-- PRIMEIRA VERSÃO:
SELECT p.nome AS paciente, m.nome AS medico, e.nome AS especialidade, c.data_hora_inicio 
  FROM consulta c, medico m, paciente p, especialidade e
  WHERE c.id_medico = m.id 
  AND c.id_paciente = p.id
  AND m.id_especialidade = e.id;
  
-- VERSÃO OTIMIZADA:
CREATE INDEX idx_consulta_id_medico ON consulta (id_medico);
CREATE INDEX idx_medico_id ON medico (id);

SELECT p.nome as paciente, m.nome as medico, e.nome as especialidade, c.data_hora_inicio
  FROM consulta c
  JOIN medico m ON c.id_medico = m.id
  JOIN paciente p ON c.id_paciente = p.id
  JOIN especialidade e ON m.id_especialidade = e.id;
  
EXPLAIN SELECT p.nome as paciente, m.nome as medico, e.nome as especialidade, c.data_hora_inicio
  FROM consulta c
  JOIN medico m ON c.id_medico = m.id
  JOIN paciente p ON c.id_paciente = p.id
  JOIN especialidade e ON m.id_especialidade = e.id;
