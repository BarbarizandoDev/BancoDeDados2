/***
consulta para encontrar todas as vendas de produtos de um dado fabricante
Mostrar dados do produto, quantidade vendida, data da venda.
Ordena-se pelo nome do produto.
***/
SELECT * 
FROM produto p, item_venda iv, venda v
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND p.fabricante like '%lar%';
 
 
 -- 1.Realize ajustes na consulta (colunas, junções, comparações etc.).
 
 SELECT p.nome_produto, iv.quantidade, v.data_venda -- Especifiquei as colunas que desejo na consulta em vez de usar *.
FROM produto p
JOIN item_venda iv ON p.id = iv.produto_id 
JOIN venda v ON v.id = iv.venda_id
WHERE p.fabricante = 'Nome do Fabricante' -- Usei JOIN explícito em vez de junções implícitas na cláusula WHERE.
ORDER BY p.nome_produto;

-- usei aliases para cada tabela, simplificando a escrita do código pra ficar  ais legil a quem ler.

-- 2.Crie índices para colunas que possam se beneficiar do recurso para melhorar o desempenho das consultas.

CREATE INDEX idx_produto_id ON produto(id);
CREATE INDEX idx_venda_id ON venda(id);
CREATE INDEX idx_produto_fabricante ON produto(fabricante);

-- Para criar os índices, usei o comando CREATE INDEX, especificando a tabela e a coluna a ser indexada.

-- 3. Mostre detalhes da execução da consulta (EXPLAIN), com dados de linhas percorridas, antes e depois das otimizações.


EXPLAIN SELECT p.nome_produto, iv.quantidade, v.data_venda
FROM produto p
JOIN item_venda iv ON p.id = iv.produto_id
JOIN venda v ON v.id = iv.venda_id
WHERE p.fabricante LIKE '%lar%'
ORDER BY p.nome_produto;

-- Para verificar o desempenho da consulta antes e depois da criação dos índices,usei o EXPLAIN antes de executá-la.

-- 4.Crie uma view para cada uma das consultas ajustadas.

-- abaixo ,estou usando o comando CREATE VIEW,especificando o nome da view e a consulta que ela deve retornar:

CREATE VIEW vendas_produto_lar AS
SELECT p.nome_produto, iv.quantidade, v.data_venda
FROM produto p
JOIN item_venda iv ON p.id = iv.produto_id
JOIN venda v ON v.id = iv.venda_id
WHERE p.fabricante LIKE '%lar%'
ORDER BY p.nome_produto;

-- Essa view vai criar uma tabela virtual com as mesmas colunas e valores da consulta,ficando rápido acessar esses dados depois.
-- apos isso consigo consultar a view de forma mais simples usando :

SELECT * FROM vendas_produto_lar;

