-- ATIVIDADE 2 / UC4



-- 1.Crie um stored procedure que receba id de cliente, data inicial e data final e que mostre a lista de compras realizadas pelo referido cliente entre as datas informadas (incluindo essas datas), mostrando nome do cliente, id da compra, total, nome e quantidade de cada produto comprado. No script, inclua o código de criação e uma chamada ao procedure.

-- criação da stored procedure.

-- Usei três parâmetros: o id do cliente, a data inicial e a data final;
--  Fiz um JOIN nas tabelas vendas, clientes, venda_produtos e produtos para obter as informações necessárias;
-- Usei o  WHERE para filtra as compras realizadas pelo cliente entre as datas informadas;

use uc4atividades;
drop procedure listarComprasPorCliente;
DELIMITER $$
CREATE PROCEDURE listarComprasPorCliente (IN id_Cliente INT, IN dataInicial DATE, IN dataFinal DATE)
BEGIN
    SELECT c.nome AS nome_cliente, 
           v.id AS id_compra, 
           v.valor_total, 
           p.nome AS nome_produto, 
           iv.quantidade
     FROM cliente c
    INNER JOIN venda v ON c.id = v.cliente_id
    INNER JOIN item_venda iv ON v.id = iv.venda_id
    INNER JOIN produto p ON iv.produto_id = p.id
    WHERE c.id = id_cliente
      AND v.data BETWEEN dataInicial AND dataFinal;
  
END $$
DELIMITER ;

-- chamar a stored procedure:

CALL listarComprasPorCliente(31, '2020-01-01', '2020-12-31');


-- 2.Crie uma stored function que receba id de funcionário, data inicial e data final e retorne a comissão total desse funcionário no período indicado. No script, inclua o código de criação e uma chamada à function.

-- usei o parâmetro funcionario_id para filtrar as vendas feitas por aquele funcionario;
-- Usei O parâmetro data_inicial para filtrar as vendas realizadas a partir daquela data,e o data_final para filtrar as vendas realizadas até aquela data. 

DELIMITER $$
CREATE FUNCTION calcular_comissao(
    funcionario_id INT, 
    data_inicial DATE, 
    data_final DATE
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_comissao DECIMAL(10,2);
    SELECT SUM(valor_total) INTO total_comissao
    FROM venda v
    WHERE funcionario_id = funcionario_id 
    AND data BETWEEN data_inicial AND data_Final;
    
    IF total_comissao IS NULL THEN
        SET total_comissao = total_comissao * 0.10;
    END IF;
    
    RETURN total_comissao;
END$$
DELIMITER ;

SELECT calcular_comissao(1, '2022-01-01', '2022-12-31'); -- teste.


-- 3. Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”. Um cliente é “PREMIUM” se já realizou mais de R$ 10 mil em compras nos últimos dois anos. Um cliente é “REGULAR” se ao contrário. No script, inclua o código de criação e uma chamada à function.

-- usei a função VERIFICACLIENTE recebendo um id_cliente como parâmetro para retornar a categoria do cliente ('PREMIUM' ou 'REGULAR').
--  A função consulta a tabela orders usei para obter o total de compras realizadas pelo cliente nos últimos dois anos.
--  Se o total for maior que R$ 10 mil, a função retorna 'PREMIUM'.Senao , retorna 'REGULAR'.

DELIMITER $$
CREATE FUNCTION verificacliente (id_cliente INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE total_compras DECIMAL(10,2);
    SELECT SUM(valor_total)
    INTO total_compras
    FROM venda
    WHERE id_cliente = cliente_id
    AND data Between DATE_SUB(NOW(), INTERVAL 2 YEAR)  AND NOW(); 
    
    IF total_compras > 10000 THEN
        RETURN 'PREMIUM';
    ELSE
        RETURN 'REGULAR';
    END IF;
END$$
DELIMITER ;


SELECT verificacliente(1); -- testar.


-- 4.Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário, aplique automaticamente MD5() à coluna “senha”.
 
 CREATE TRIGGER tr_usuario BEFORE INSERT ON usuario
FOR EACH ROW
  SET NEW.senha = MD5(NEW.senha) ;

INSERT INTO uc4atividades.usuario (id, login, senha, ultimo_login) VALUES (12, 'joao', 'senha123', '2023-04-29 10:00:02');
select * from usuario;