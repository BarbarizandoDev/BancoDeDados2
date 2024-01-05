--  3. Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”. 
-- Um cliente é “PREMIUM” se já realizou mais de R$ 10 mil em compras nos últimos dois anos. 
-- Um cliente é “REGULAR” se ao contrário. No script, inclua o código de criação e uma chamada à function.


DELIMITER $$
CREATE FUNCTION cliente_tipo(id_cliente INT) RETURNS VARCHAR(10)
BEGIN
    DECLARE total_compras DECIMAL(10,2);
    SELECT SUM(valor) INTO total_compras FROM compras WHERE id_cliente = id AND data_compra >= DATE_SUB(NOW(), INTERVAL 2 YEAR);
    IF total_compras > 10000 THEN
        RETURN 'PREMIUM';
    ELSE
        RETURN 'REGULAR';
    END IF;
END$$
DELIMITER ;
SELECT cliente_tipo(1);
