# 🎓 Projeto Prático: Sistema de Gestão Acadêmica "SigaEdu"
Este desafio simula um cenário real onde você deverá transformar dados brutos e desorganizados em um sistema de gestão acadêmica profissional, seguro e escalável.

## 🎯 O Desafio
O objetivo deste projeto é projetar e implementar o núcleo de um sistema universitário. Você partirá de uma lista de dados brutos (planilha legada) e deverá chegar a um banco de dados relacional totalmente normalizado e funcional.

---

## 📂 Estrutura do Projeto

### 1. Modelagem e Arquitetura (Teoria)
**Tarefa:** Responda às questões de planejamento estratégico do sistema:
* **SGBD:** Justifique a escolha de um SGBD Relacional (ex: PostgreSQL ou MySQL) para gerenciar notas e frequências em vez de um modelo NoSQL orientado a Documentos.

### 2. Projeto e Normalização (O Coração do Trabalho)
**Tarefa:** Você recebeu a tabela denormalizada abaixo, extraída de uma planilha antiga. Aplique as regras de **1NF, 2NF e 3NF**:

`PLANILHA_GERAL(RA_Aluno, Nome_Aluno, Email_Aluno, Cod_Disciplina, Nome_Disciplina, Carga_Horaria, ID_Professor, Nome_Professor, Data_Matricula, Nota_Final, Semestre_Ano)`

> **⚠️ Ponto de Atenção:** Identifique corretamente a dependência da `Nota_Final`. Ela depende apenas do aluno? Apenas da disciplina? Ou da combinação de ambos?

**Entrega desta fase:**
- Imagem do **DER (Diagrama Entidade-Relacionamento)**.
- Esquema do **Modelo Lógico** após a normalização.

### 3. Implementação SQL (DDL e DCL)
**Tarefa:** Desenvolva o script SQL de criação do ambiente:
* **Estrutura:** Criar as tabelas normalizadas definindo **Primary Keys (PK)** e **Foreign Keys (FK)**.
* **Integridade:** Configurar a integridade referencial (ex: impedir a exclusão de um aluno que possua registros de notas ativos).
* **Segurança (DCL):** - Criar o perfil `professor_role`: permissão de `UPDATE` apenas na tabela de notas.
    - Criar o perfil `coordenador_role`: acesso total ao banco.

### 4. Consultas e Relatórios (DML)
**Tarefa:** Escreva as queries para atender às demandas da secretaria:
1. **Listagem de Matriculados:** Nome de todos os alunos e suas respectivas disciplinas no semestre `2026/1` (**INNER JOIN**).
2. **Desempenho Acadêmico:** Média de notas por disciplina, filtrando apenas aquelas com média inferior a `6.0` (**Agregação & HAVING**).
3. **Alocação de Docentes:** Todos os professores e suas disciplinas (incluindo aqueles sem turmas vinculadas) (**LEFT JOIN**).
4. **Destaque Acadêmico:** Nome do aluno com a maior nota na disciplina de "Banco de Dados" (**Subconsulta**).

### 5. Transações e Segurança
**Tarefa:** Analise o seguinte cenário de concorrência:
* *Dois funcionários da secretaria tentam alterar a nota do mesmo aluno simultaneamente.*
* **Pergunta:** Como os conceitos de **Transações (ACID)** e o **Controle de Concorrência** do SGBD garantem que o dado final não seja corrompido?

---

## 📤 Estrutura de Entrega Esperada

Para a entrega oficial, organize seu repositório no GitHub com:

1. **`/docs`**: Contendo a imagem do **DER** e a justificativa das decisões de normalização.
2. **`/scripts`**: Arquivo `.sql` contendo todo o código (DDL, DCL e as consultas DML).
3. **`README.md`**: Documentação principal explicando como rodar o projeto e as respostas das questões teóricas.

---
*Este projeto é parte integrante da avaliação da disciplina de Banco de Dados.*