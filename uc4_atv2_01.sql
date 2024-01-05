-- 1. Crie um stored procedure que receba id de cliente,
-- data inicial e data final e que mostre a lista de compras realizadas pelo referido cliente entre as datas informadas (incluindo essas datas), 
-- mostrando nome do cliente, id da compra, total, nome e quantidade de cada produto comprado.
-- No script, inclua o código de criação e uma chamada ao procedure.


-- Criação da tabela de compras
CREATE TABLE Compras (
  id_compra INT PRIMARY KEY,
  id_cliente INT,
  nome_cliente VARCHAR(100),
  nome_produto VARCHAR(100),
  quantidade INT,
  total DECIMAL(10, 2),
  data_compra DATE
);

-- Criação da stored procedure
DELIMITER //
CREATE PROCEDURE listar_compras_cliente(
  IN cliente_id INT,
  IN data_inicial DATE,
  IN data_final DATE
)
BEGIN
  SELECT c.nome_cliente, c.id_compra, c.total, c.nome_produto, c.quantidade
  FROM Compras c
  WHERE c.id_cliente = cliente_id
    AND c.data_compra BETWEEN data_inicial AND data_final;
END //
DELIMITER ;

-- Chamada à stored procedure
CALL listar_compras_cliente(1, '2023-01-01', '2023-04-18');
