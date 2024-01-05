-- 1) Crie um usuário específico para relatórios. Crie role para ele, com acesso apenas à consulta em tabelas (nem dados, nem estrutura podem ser alterados).
use db_uc4atividades;

-- Criar usuário
CREATE USER 'nome_do_usuario'
identified by  'senha_do_usuario'; 

-- Criar role
CREATE ROLE role_de_relatorios;

-- Conceder permissão de SELECT nas tabelas existentes
GRANT SELECT ON tabela1 TO role_de_relatorios;
GRANT SELECT ON tabela2 TO role_de_relatorios;
-- Adicione mais GRANT SELECT para outras tabelas que o usuário precisa acessar

-- Revogar permissões de DML (Data Manipulation Language) nas tabelas existentes
REVOKE INSERT, UPDATE, DELETE ON tabela1 FROM role_de_relatorios;
REVOKE INSERT, UPDATE, DELETE ON tabela2 FROM role_de_relatorios;
-- Adicione mais REVOKE para outras tabelas que você não deseja permitir DML

-- Conceder role ao usuário
GRANT role_de_relatorios TO nome_do_usuario;
