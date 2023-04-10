-- PRIMEIRA VERSÃO:
SELECT DATE_FORMAT(c.data_hora_inicio, '%d/%m'), (MAX(TIMESTAMPDIFF(MINUTE, c.data_hora_inicio, c.data_hora_fim))) AS maior_duracao
  FROM CONSULTA c 
  GROUP BY DATE_FORMAT(c.data_hora_inicio, '%d/%m');

-- VERSÃO OTIMIZADA 1:
CREATE INDEX ix_consulta_data_hora_inicio ON CONSULTA (data_hora_inicio);

EXPLAIN SELECT DATE_FORMAT(c.data_hora_inicio, '%d/%m') AS data_consulta, (MAX(TIMESTAMPDIFF(MINUTE, c.data_hora_inicio, c.data_hora_fim))) AS maior_duracao
  FROM CONSULTA c
  GROUP BY DATE_FORMAT(c.data_hora_inicio, '%d/%m');
  
