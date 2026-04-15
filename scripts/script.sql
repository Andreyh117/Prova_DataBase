-- =========================
-- 1. SCHEMAS
-- =========================
CREATE SCHEMA IF NOT EXISTS academico;
CREATE SCHEMA IF NOT EXISTS seguranca;

-- =========================
-- 2. TABELAS (DDL)
-- =========================

CREATE TABLE academico.aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.professor (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.disciplina (
    id_disciplina SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE academico.turma (
    id_turma SERIAL PRIMARY KEY,
    id_disciplina INT REFERENCES academico.disciplina(id_disciplina),
    id_professor INT REFERENCES academico.professor(id_professor),
    ciclo VARCHAR(10)
);

CREATE TABLE academico.matricula (
    id_matricula SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES academico.aluno(id_aluno),
    id_turma INT REFERENCES academico.turma(id_turma),
    nota DECIMAL(4,2),
    ativo BOOLEAN DEFAULT TRUE
);

-- =========================
-- 3. DCL (PERMISSÕES)
-- =========================

CREATE ROLE professor_role;
CREATE ROLE coordenador_role;

-- Professor pode atualizar apenas nota
GRANT UPDATE (nota) ON academico.matricula TO professor_role;

-- Remove acesso ao email
REVOKE SELECT (email) ON academico.aluno FROM professor_role;

-- Coordenador acesso total
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA academico TO coordenador_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA seguranca TO coordenador_role;

-- =========================
-- 4. INSERTS (DADOS)
-- =========================

INSERT INTO academico.aluno (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Souza', 'maria@email.com'),
('Carlos Lima', 'carlos@email.com');

INSERT INTO academico.professor (nome) VALUES
('Ana Paula'),
('Roberto Alves');

INSERT INTO academico.disciplina (nome) VALUES
('Banco de Dados'),
('Programação');

INSERT INTO academico.turma (id_disciplina, id_professor, ciclo) VALUES
(1, 1, '2026/1'),
(2, 2, '2026/1');

INSERT INTO academico.matricula (id_aluno, id_turma, nota) VALUES
(1, 1, 8.5),
(2, 1, 5.5),
(3, 2, 7.0);

-- =========================
-- 5. QUERIES (CONSULTAS)
-- =========================

-- 1. Matriculados 2026/1
SELECT a.nome, d.nome AS disciplina, t.ciclo
FROM academico.aluno a
JOIN academico.matricula m ON a.id_aluno = m.id_aluno
JOIN academico.turma t ON m.id_turma = t.id_turma
JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina
WHERE t.ciclo = '2026/1';

-- 2. Baixo desempenho
SELECT d.nome, AVG(m.nota) AS media
FROM academico.matricula m
JOIN academico.turma t ON m.id_turma = t.id_turma
JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina
GROUP BY d.nome
HAVING AVG(m.nota) < 6.0;

-- 3. Docentes (LEFT JOIN)
SELECT p.nome, d.nome AS disciplina
FROM academico.professor p
LEFT JOIN academico.turma t ON p.id_professor = t.id_professor
LEFT JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina;

-- 4. Melhor aluno em Banco de Dados
SELECT a.nome, m.nota
FROM academico.aluno a
JOIN academico.matricula m ON a.id_aluno = m.id_aluno
JOIN academico.turma t ON m.id_turma = t.id_turma
JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina
WHERE d.nome = 'Banco de Dados'
AND m.nota = (
    SELECT MAX(m2.nota)
    FROM academico.matricula m2
    JOIN academico.turma t2 ON m2.id_turma = t2.id_turma
    JOIN academico.disciplina d2 ON t2.id_disciplina = d2.id_disciplina
    WHERE d2.nome = 'Banco de Dados'
);
