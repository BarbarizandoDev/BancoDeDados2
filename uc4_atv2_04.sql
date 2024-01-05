--  4. Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário, 
-- aplique automaticamente MD5() à coluna “senha”.

CREATE TRIGGER trig_md5_usuario
BEFORE INSERT ON usuario
FOR EACH ROW
SET NEW.senha = MD5(NEW.senha);
