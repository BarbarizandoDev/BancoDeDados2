-- ATIVIDADE 2 / UC4

-- SEGUE ABAIXO NOVAMENTE MINHA ATIVIDADE , MODIFIQUEI E REFIZ TUDO O QUE CONSEGUI ,TENDO EM CONTA QUE O QUE SE PEDE NOS ENUCIADOS É ALGO ESPECIFICO SOBRE O MESMO BANCO DE DADOS DOS DEMAIS COLEGAS , FIZ ATÉ ONDE MEU CONHECIMENTO ALCANÇA!
-- SE EXISTIR MAIS ALGUMA OUTRA MANEIRA DE FAZER EU AINDA NAO APRENDI .


-- 1.Crie um stored procedure que receba id de cliente, data inicial e data final e que mostre a lista de compras realizadas pelo referido cliente entre as datas informadas (incluindo essas datas), mostrando nome do cliente, id da compra, total, nome e quantidade de cada produto comprado. No script, inclua o código de criação e uma chamada ao procedure.

-- criação da stored procedure.

use uc4atividades;
drop procedure listarComprasPorCliente;
DELIMITER $$
CREATE PROCEDURE listarComprasPorCliente (
    IN id_Cliente INT, 
    IN dataInicial DATE, 
    IN dataFinal DATE
)
BEGIN
    SELECT 
        cliente.nome AS nome_cliente, 
        venda.id AS id_compra, 
        venda.valor_total, 
        produto.nome AS nome_produto, 
        item_venda.quantidade
    FROM 
        cliente 
        INNER JOIN venda ON cliente.id = venda.cliente_id
        INNER JOIN item_venda ON venda.id = item_venda.venda_id
        INNER JOIN produto ON item_venda.produto_id = produto.id
    WHERE 
        cliente.id = id_Cliente
        AND venda.data BETWEEN dataInicial AND dataFinal;
END $$
DELIMITER ;

-- chamar a stored procedure:
CALL listarComprasPorCliente(10, '2022-04-14', '2022-05-01');

-- 2.Crie uma stored function que receba id de funcionário, data inicial e data final e retorne a comissão total desse funcionário no período indicado. No script, inclua o código de criação e uma chamada à function.

DELIMITER $$
CREATE FUNCTION calcular_comissao(
    funcionario_id INT, 
    data_inicial DATE, 
    data_final DATE
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN IFNULL(
        (SELECT SUM(valor_total) * 0.10
         FROM venda
         WHERE funcionario_id = funcionario_id
         AND data BETWEEN data_inicial AND data_final),
        0.0
    );
END$$
DELIMITER ;

-- chamar fuction :

SELECT calcular_comissao(20, '2020-03-11', '2021-08-12');


-- 3. Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”. Um cliente é “PREMIUM” se já realizou mais de R$ 10 mil em compras nos últimos dois anos. Um cliente é “REGULAR” se ao contrário. No script, inclua o código de criação e uma chamada à function.

DELIMITER $$
CREATE FUNCTION verificacliente (id_cliente INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE total_compras DECIMAL(10,2) DEFAULT 0.0;
    SELECT COALESCE(SUM(valor_total), 0.0)
    INTO total_compras
    FROM venda
    WHERE id_cliente = cliente_id
    AND data BETWEEN DATE_SUB(NOW(), INTERVAL 2 YEAR) AND NOW();
    
    RETURN CASE
        WHEN total_compras > 10000 THEN 'PREMIUM'
        ELSE 'REGULAR'
    END;
END$$
DELIMITER ;

-- chamar fuction :

SELECT verificacliente(1);

-- 4.Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário, aplique automaticamente MD5() à coluna “senha”.

ALTER TABLE uc4atividades.usuario
ADD COLUMN senha_md5 VARCHAR(32) DEFAULT NULL AFTER senha;

DELIMITER $$
CREATE TRIGGER tr_usuario BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
  SET NEW.senha_md5 = MD5(NEW.senha);
END$$
DELIMITER ;

INSERT INTO uc4atividades.usuario (id, login, senha, ultimo_login) VALUES (11, 'zé', 'senha123', '2021-04-29 12:45:02');

SELECT * FROM usuario;

