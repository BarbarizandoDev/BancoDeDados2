/***
Relatório de vendas de produto por cliente.
Mostrar dados do cliente, dados do produto e valor e quantidade totais de venda ao cliente de cada produto.
*/
SELECT SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p, item_venda iv, venda v, cliente c
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND c.id = v.cliente_id /*f.id = v.funcionario_id*/
GROUP BY c.nome, p.nome;

-- 1.Realize ajustes na consulta (colunas, junções, comparações etc.).

SELECT c.nome AS nome_cliente, p.nome AS nome_produto, SUM(iv.subtotal) AS valor_total_venda, SUM(iv.quantidade) AS quantidade_vendida
FROM produto p
INNER JOIN item_venda iv ON p.id = iv.produto_id
INNER JOIN venda v ON v.id = iv.venda_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE c.id = 123
GROUP BY c.nome, p.nome;

 -- 2.Crie índices para colunas que possam se beneficiar do recurso para melhorar o desempenho das consultas.

CREATE INDEX idx_nome_indice ON nome_tabela (nome_coluna);
CREATE INDEX idx_produto_id ON produto (id);

-- 3. Mostre detalhes da execução da consulta (EXPLAIN), com dados de linhas percorridas, antes e depois das otimizações.

EXPLAIN SELECT c.nome AS nome_cliente, p.nome AS nome_produto, SUM(iv.subtotal) AS valor_total_venda, SUM(iv.quantidade) AS quantidade_vendida
FROM produto p
INNER JOIN item_venda iv ON p.id = iv.produto_id
INNER JOIN venda v ON v.id = iv.venda_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE c.id = 123
GROUP BY c.nome, p.nome;

-- 4.Crie uma view para cada uma das consultas ajustadas.

CREATE VIEW relatorio_vendas_cliente_produto AS
SELECT c.nome AS nome_cliente, p.nome AS nome_produto, SUM(iv.subtotal) AS valor_total_venda, SUM(iv.quantidade) AS quantidade_vendida
FROM produto p
INNER JOIN item_venda iv ON p.id = iv.produto_id
INNER JOIN venda v ON v.id = iv.venda_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE c.id = 123
GROUP BY c.nome, p.nome;

SELECT * FROM relatorio_vendas_cliente_produto;




