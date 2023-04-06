-- PRIMEIRA VERSÃO:
SELECT m.nome, count(c.id) as qtde_consultas from medico m, consulta c where m.id = c.id_medico and c.data_hora_inicio > sysdate() group by m.nome order by m.nome;

-- VERSÃO OTIMIZADA:
CREATE INDEX idx_id_medico ON consulta(id_medico);

SELECT m.nome, count(c.id) as qtde_consultas FROM medico m
  JOIN consulta c ON m.id = c.id_medico
  WHERE c.data_hora_inicio > sysdate()
  GROUP BY m.nome
  HAVING qtde_consultas > 0
  ORDER BY m.nome;
