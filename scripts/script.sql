-- =========================
-- 1. SCHEMAS
-- =========================
CREATE SCHEMA IF NOT EXISTS academico;
CREATE SCHEMA IF NOT EXISTS seguranca;

-- =========================
-- 2. TABELAS
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
-- 3. ROLES
-- =========================

CREATE ROLE professor_role;
CREATE ROLE coordenador_role;

GRANT UPDATE (nota) ON academico.matricula TO professor_role;
REVOKE SELECT (email) ON academico.aluno FROM professor_role;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA academico TO coordenador_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA seguranca TO coordenador_role;

-- =========================
-- 4. DADOS (BASEADOS NA PLANILHA)
-- =========================

-- ALUNOS
INSERT INTO academico.aluno (nome, email) VALUES
('Ana Beatriz Lima', 'ana.lima@aluno.edu.br'),
('Bruno Henrique Souza', 'bruno.souza@aluno.edu.br'),
('Camila Ferreira', 'camila.ferreira@aluno.edu.br'),
('Diego Martins', 'diego.martins@aluno.edu.br'),
('Eduarda Nunes', 'eduarda.nunes@aluno.edu.br'),
('Felipe Araujo', 'felipe.araujo@aluno.edu.br'),
('Gabriela Torres', 'gabriela.torres@aluno.edu.br'),
('Helena Rocha', 'helena.rocha@aluno.edu.br'),
('Igor Santana', 'igor.santana@aluno.edu.br');

-- PROFESSORES
INSERT INTO academico.professor (nome) VALUES
('Prof. Carlos Mendes'),
('Profa. Juliana Castro'),
('Prof. Eduardo Pires'),
('Profa. Marina Lopes'),
('Prof. Renato Alves'),
('Prof. Ricardo Faria');

-- DISCIPLINAS
INSERT INTO academico.disciplina (nome) VALUES
('Banco de Dados'),
('Engenharia de Software'),
('Sistemas Operacionais'),
('Algoritmos'),
('Redes de Computadores'),
('Estruturas de Dados');

-- TURMAS (ciclo baseado na planilha)
INSERT INTO academico.turma (id_disciplina, id_professor, ciclo) VALUES
(1, 1, '2026/1'),
(2, 2, '2026/1'),
(3, 3, '2026/1'),
(4, 5, '2026/1'),
(5, 4, '2026/1'),
(6, 6, '2026/1'),

(1, 1, '2025/2'),
(2, 2, '2025/2'),
(4, 5, '2025/2'),
(5, 4, '2025/2'),
(3, 3, '2025/2'),
(6, 6, '2025/2');

-- MATRÍCULAS (simplificado, mas coerente com planilha)
INSERT INTO academico.matricula (id_aluno, id_turma, nota) VALUES
(1, 1, 9.1),
(1, 2, 8.4),
(1, 3, 8.9),

(2, 1, 7.3),
(2, 4, 6.8),
(2, 5, 7.2),

(3, 1, 5.9),
(3, 2, 7.5),
(3, 6, 6.1),

(4, 4, 4.7),
(4, 5, 6.2),
(4, 3, 5.8),

(5, 2, 9.5),
(5, 5, 8.1),
(5, 6, 8.7),

(6, 1, 6.4),
(6, 4, 5.6),
(6, 3, 6.9),

(7, 1, 6.4),
(7, 2, 7.1),

(8, 4, 8.8),
(8, 5, 7.9),

(9, 3, 5.5),
(9, 6, 6.3);

-- =========================
-- 5. CONSULTAS
-- =========================

-- Matriculados 2026/1
SELECT a.nome, d.nome AS disciplina, t.ciclo
FROM academico.aluno a
JOIN academico.matricula m ON a.id_aluno = m.id_aluno
JOIN academico.turma t ON m.id_turma = t.id_turma
JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina
WHERE t.ciclo = '2026/1';

-- Baixo desempenho
SELECT d.nome, AVG(m.nota) AS media
FROM academico.matricula m
JOIN academico.turma t ON m.id_turma = t.id_turma
JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina
GROUP BY d.nome
HAVING AVG(m.nota) < 6.0;

-- Docentes
SELECT p.nome, d.nome AS disciplina
FROM academico.professor p
LEFT JOIN academico.turma t ON p.id_professor = t.id_professor
LEFT JOIN academico.disciplina d ON t.id_disciplina = d.id_disciplina;

-- Melhor aluno em Banco de Dados
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
