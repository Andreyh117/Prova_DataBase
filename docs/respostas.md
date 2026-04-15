# QUESTÃO 1 - SGBD Relacional vs NoSQL

A escolha de um SGBD relacional, como PostgreSQL, é mais adequada para um sistema acadêmico, 
pois garante as propriedades ACID (Atomicidade, Consistência, Isolamento e Durabilidade), essenciais para manter a integridade dos dados.

Em um sistema universitário, operações como matrícula, lançamento de notas e cadastro de alunos exigem consistência e confiabilidade.

Diferente dos bancos NoSQL, que priorizam escalabilidade e flexibilidade, o modelo relacional assegura integridade referencial através de 
chaves primárias e estrangeiras, evitando inconsistências como alunos sem matrícula ou notas sem vínculo com disciplinas.

---

# QUESTÃO 2 - Uso de Schemas

O uso de schemas permite organizar o banco de dados em camadas lógicas, separando responsabilidades.

Exemplo:
- Schema "academico": tabelas de alunos, disciplinas e matrículas
- Schema "seguranca": usuários, permissões e controle de acesso

Essa separação melhora a organização, segurança, manutenção e escalabilidade do sistema, além de facilitar o controle de permissões 
por perfil de usuário.

Utilizar apenas o schema "public" em ambientes profissionais não é recomendado, pois dificulta a governança e aumenta o risco de 
erros e acessos indevidos.

---

# NORMALIZAÇÃO

A planilha legada apresentava redundância de dados, com repetição de alunos para cada disciplina cursada. 
Foi necessário aplicar normalização para separar as entidades em tabelas distintas (Aluno, Disciplina, Professor, Turma e Matrícula), 
eliminando dependências indevidas e garantindo integridade e organização dos dados.

Foram aplicadas as seguintes formas normais:

- 1FN: eliminação de grupos repetitivos e atributos multivalorados
- 2FN: remoção de dependências parciais
- 3FN: eliminação de dependências transitivas

---

# MODELO LÓGICO

ALUNO (id_aluno PK, nome, email, ativo)

PROFESSOR (id_professor PK, nome, ativo)

DISCIPLINA (id_disciplina PK, nome)

TURMA (id_turma PK, id_disciplina FK, id_professor FK, ciclo)

MATRICULA (id_matricula PK, id_aluno FK, id_turma FK, nota, ativo)

---

# QUESTÃO 5 - Transações e Concorrência

O isolamento garante que transações concorrentes não interfiram umas nas outras.

Quando dois operadores tentam atualizar a mesma nota simultaneamente, o SGBD utiliza mecanismos de lock (bloqueio) para controlar o acesso ao dado.

Um dos processos obtém o lock primeiro, enquanto o outro aguarda. Isso evita condições de corrida e garante que apenas uma transação seja aplicada por vez, mantendo a consistência do banco.

Dessa forma, mesmo com acessos simultâneos, o dado final não será consistente e não ocorrerá corrupção de dados.
