QUESTÃO 1 - SGBD Relacional vs NoSQL

A escolha de um SGBD relacional, como PostgreSQL, é mais adequada para um sistema acadêmico, 
pois garante as propriedades ACID (Atomicidade, Consistência, Isolamento e Durabilidade), essenciais para manter a integridade dos dados.

Em um sistema universitário, operações como matrícula, lançamento de notas e cadastro de alunos exigem consistência e confiabilidade.

Diferente dos bancos NoSQL, que priorizam escalabilidade e flexibilidade, o modelo relacional assegura integridade referencial através de 
chaves primárias e estrangeiras, evitando inconsistências como alunos sem matrícula ou notas sem vínculo com disciplinas.

QUESTÃO 2 - Uso de Schemas

O uso de schemas permite organizar o banco de dados em camadas lógicas, separando responsabilidades.
Por exemplo:

Schema "academico": tabelas de alunos, disciplinas e matrículas
Schema "seguranca": usuários, permissões e controle de acesso

Essa separação melhora a organização, segurança, manutenção e escalabilidade do sistema, além de facilitar o controle de permissões 
por perfil de usuário.

Utilizar apenas o schema "public" em ambientes profissionais não é recomendado, pois dificulta a governança e aumenta o risco de 
erros e acessos indevidos.

 *A planilha legada apresentava redundância de dados, com repetição de alunos para cada disciplina cursada. 
Foi necessário aplicar normalização para separar as entidades em tabelas distintas (Aluno, Disciplina, Professor, Turma e Matrícula), eliminando dependências indevidas e garantindo integridade e organização dos dados.
