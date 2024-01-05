/**
consulta para um relatório de todas as vendas pagas em dinheiro. 
Necessários para o relatório data da venda, valor total; produtos vendidos, quantidade e valor unitário; nome do cliente, cpf e telefone.
Ordena-se pela data de venda, as mais recentes primeiro.
**/
SELECT * FROM venda v, item_venda iv, produto p, cliente c, funcionario f
WHERE v.id = iv.venda_id AND c.id = v.cliente_id AND p.id = iv.produto_id AND f.id = v.funcionario_id and tipo_pagamento = 'D';



-- 1. Realize ajustes na consulta (colunas, junções, comparações etc.);
SELECT v.data_venda, v.valor_total, iv.quantidade, iv.valor_unitario, p.nome_produto, c.nome_cliente, c.cpf, c.telefone
FROM venda v -- Utilizei apenas as colunas relevantes para o relatório, renomeando-as de acordo com o que foi solicitado.
INNER JOIN item_venda iv ON v.id = iv.venda_id -- usei  INNER JOIN, para garantir que todas as tabelas relacionadas tenham correspondência na consulta.
INNER JOIN produto p ON p.id = iv.produto_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE v.tipo_pagamento = 'D' --  a cláusula WHERE foi modificada para usar a sintaxe mais moderna de junção de tabelas (INNER JOIN),  
ORDER BY v.data_venda DESC;

-- usei aliases para cada tabela, simplificando a escrita do código pra ficar  ais legil a quem ler.




-- 2. Crie índices para colunas que possam se beneficiar do recurso para melhorar o desempenho das consultas.
CREATE INDEX idx_venda_tipo_pagamento ON venda (tipo_pagamento);
CREATE INDEX idx_venda_id ON venda (id);
CREATE INDEX idx_item_venda_venda_id ON item_venda (venda_id);
CREATE INDEX idx_item_venda_produto_id ON item_venda (produto_id);
CREATE INDEX idx_produto_id ON produto (id);
CREATE INDEX idx_cliente_id ON cliente (id);

-- Para criar os índices, usei o comando CREATE INDEX, especificando a tabela e a coluna a ser indexada.

-- 3. Mostre detalhes da execução da consulta (EXPLAIN), com dados de linhas percorridas, antes e depois das otimizações.

EXPLAIN SELECT v.data_venda, v.valor_total, iv.quantidade, iv.valor_unitario, p.nome_produto, c.nome_cliente, c.cpf, c.telefone
FROM venda v
INNER JOIN item_venda iv ON v.id = iv.venda_id
INNER JOIN produto p ON p.id = iv.produto_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE v.tipo_pagamento = 'D'
ORDER BY v.data_venda DESC;

-- Para verificar o desempenho da consulta antes e depois da criação dos índices,usei o EXPLAIN antes de executá-la.

-- 4.Crie uma view para cada uma das consultas ajustadas.

-- abaixo ,estou usando o comando CREATE VIEW,especificando o nome da view e a consulta que ela deve retornar:

CREATE VIEW relatorio_vendas AS
SELECT v.data_venda, v.valor_total, iv.quantidade, iv.valor_unitario, p.nome_produto, c.nome_cliente, c.cpf, c.telefone
FROM venda v
INNER JOIN item_venda iv ON v.id = iv.venda_id
INNER JOIN produto p ON p.id = iv.produto_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE v.tipo_pagamento = 'D'
ORDER BY v.data_venda DESC;

-- Essa view vai criar uma tabela virtual com as mesmas colunas e valores da consulta,ficando rápido acessar esses dados depois.