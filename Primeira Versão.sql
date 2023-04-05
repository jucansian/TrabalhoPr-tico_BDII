-- ================ CRIANDO DATABASE E TABELAS ===============
CREATE DATABASE IF NOT EXISTS TRABALHO2;
USE TRABALHO2;

CREATE TABLE IF NOT EXISTS ESPECIALIDADE (
id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS MEDICO (
id INT PRIMARY KEY,
    id_especialidade INT,
    nome VARCHAR(100),
    celular VARCHAR(15),
    FOREIGN KEY(id_especialidade) REFERENCES ESPECIALIDADE(id)
);

CREATE TABLE IF NOT EXISTS PACIENTE (
id INT PRIMARY KEY,
    nome VARCHAR(100),
    celular VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS CONSULTA (
id INT PRIMARY KEY,
    id_medico INT,
    id_paciente INT,
    data_hora_inicio DATETIME,
    data_hora_fim DATETIME,
    FOREIGN KEY(id_medico) REFERENCES MEDICO(id),
    FOREIGN KEY(id_paciente) REFERENCES PACIENTE(id)
);
-- ================= INSERINDO DADOS ====================

-- ESPECIALIDADE
-- INSERT INTO ESPECIALIDADE VALUE(1, 'Pediatra');
-- INSERT INTO ESPECIALIDADE VALUE(2, 'Urologista');
-- INSERT INTO ESPECIALIDADE VALUE(3, 'Cirurgião Plástico');

-- MEDICO
-- INSERT INTO MEDICO VALUE (1, 1, 'Roberto', '47992611819');
-- INSERT INTO MEDICO VALUE (2, 2, 'Bernardo', '47992612319');
-- INSERT INTO MEDICO VALUE (3, 3, 'Alexandre', '47992456819');

-- PACIENTE
-- INSERT INTO PACIENTE VALUE (1, 'Luiz', '47992611819');
-- INSERT INTO PACIENTE VALUE (2, 'Júlia', '47992456819');
-- INSERT INTO PACIENTE VALUE (3, 'Fabio', '47992623819');

-- CONSULTA

-- INSERT INTO CONSULTA VALUE (1, 1, 1, DATE_ADD(sysdate(), interval 0 minute), DATE_ADD(sysdate(), interval 45 minute));
-- INSERT INTO CONSULTA VALUE (2, 1, 2, DATE_ADD(sysdate(), interval 50 minute), DATE_ADD(sysdate(), interval 112 minute));
-- INSERT INTO CONSULTA VALUE (3, 1, 3, DATE_ADD(sysdate(), interval 114 minute), DATE_ADD(sysdate(), interval 196 minute));
-- INSERT INTO CONSULTA VALUE (4, 2, 1, DATE_ADD(sysdate(), interval 200 minute), DATE_ADD(sysdate(), interval 244 minute));
-- INSERT INTO CONSULTA VALUE (5, 2, 2, DATE_ADD(sysdate(), interval 245 minute), DATE_ADD(sysdate(), interval 315 minute));
-- INSERT INTO CONSULTA VALUE (6, 2, 3, DATE_ADD(sysdate(), interval 320 minute), DATE_ADD(sysdate(), interval 380 minute));
-- INSERT INTO CONSULTA VALUE (7, 3, 1, DATE_ADD(sysdate(), interval 385 minute), DATE_ADD(sysdate(), interval 440 minute));
-- INSERT INTO CONSULTA VALUE (8, 3, 2, DATE_ADD(sysdate(), interval 445 minute), DATE_ADD(sysdate(), interval 500 minute));
-- INSERT INTO CONSULTA VALUE (9, 3, 3, DATE_ADD(sysdate(), interval 505 minute), DATE_ADD(sysdate(), interval 565 minute));

-- ================= ALTERNATIVA 1 ======================

-- SELECT m.nome, count(c.id) as qtde_consultas from medico m, consulta c where m.id = c.id_medico and c.data_hora_inicio > sysdate() group by m.nome order by m.nome;

-- ================= ALTERNATIVA 2 ======================

-- SELECT e.nome, count(c.id) as qtde_consultas from especialidade e, medico m, consulta c where e.id = m.id_especialidade and m.id = c.id_medico group by e.nome;

-- ================= ALTERNATIVA 3 ======================

-- SELECT DATE_FORMAT(c.data_hora_inicio, '%d/%m'), (MAX(TIMESTAMPDIFF(MINUTE, c.data_hora_inicio, c.data_hora_fim))) as maior_duracao from CONSULTA C group by DATE_FORMAT(c.data_hora_inicio, '%d/%m');

-- ================= ALTERNATIVA 4 ======================

-- select m.nome, count(c.id) as consultas from medico m, especialidade e, consulta c where m.id = c.id_medico and e.id = m.id_especialidade and c.data_hora_fim < DATE_ADD(sysdate(), INTERVAL 300 minute) group by m.id order by consultas desc LIMIT 1;

-- ================= ALTERNATIVA 5 ======================

-- SELECT p.nome as paciente, m.nome as medico, e.nome as especialidade, c.data_hora_inicio from consulta c, medico m, paciente p, especialidade e where c.id_medico = m.id and c.id_paciente = p.id and m.id_especialidade = e.id