
-- Escolha um método de criptografia ou hash para aplicar às senhas dos usuários. Atualize a tabela “usuário” aplicando a criptografia ou hash ao campo de senha em todos os registros.


-- Exemplo de criação de função de hash SHA256
DELIMITER //
CREATE FUNCTION SHA256(plaintext CHAR(64))
RETURNS CHAR(64)
BEGIN
    DECLARE hash CHAR(64);
    SET hash = SHA2(plaintext, 256);
    RETURN hash;
END;
//

-- Exemplo de atualização da tabela "usuário" aplicando a função de hash às senhas
UPDATE usuário SET senha = SHA256(senha);
