-- Crie usuário e role para funcionário, o qual pode manipular as tabelas de venda, cliente e produto, mas não deve ter acesso (nem para consulta) a funcionário e cargo e não deve ser capaz de realizar alterações de estrutura em nenhuma tabela.
use db_uc4atividades;

-- Criação do usuário
CREATE USER funcionario_vendas
identified by  'senha_vendas'; 

-- Criação da role
CREATE ROLE funcionario_vendas_role;

-- Atribuição de permissões à role
GRANT SELECT, INSERT, UPDATE, DELETE ON venda TO funcionario_vendas_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente TO funcionario_vendas_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON produto TO funcionario_vendas_role;

-- Revogação de permissões específicas
REVOKE SELECT, INSERT, UPDATE, DELETE ON funcionario FROM funcionario_vendas_role;
REVOKE SELECT, INSERT, UPDATE, DELETE ON cargo FROM funcionario_vendas_role; 

-- Atribuição da role ao usuário
GRANT funcionario_vendas_role TO funcionario_vendas;
