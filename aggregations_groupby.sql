SELECT * FROM information_schema.columns WHERE table_name='banco';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name='banco';

SELECT * FROM cliente_transacoes;
SELECT valor FROM cliente_transacoes;
SELECT AVG(valor) FROM cliente_transacoes;
SELECT AVG(valor) FROM cliente_transacoes WHERE cliente_numero=208;

SELECT * FROM cliente;
SELECT numero FROM cliente;
SELECT COUNT(numero) FROM cliente;

SELECT COUNT(numero), email 
FROM cliente
WHERE email LIKE '%gmail.com'
GROUP BY email;

SELECT MAX(numero) FROM cliente;
SELECT MIN(numero) FROM cliente;
SELECT MAX(valor) FROM cliente_transacoes;
SELECT MIN(valor) FROM cliente_transacoes;

SELECT MAX(valor), tipo_transacao_id 
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT MIN(valor), tipo_transacao_id 
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT COUNT(id), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
HAVING COUNT(id) > 150;

SELECT SUM(valor)
FROM cliente_transacoes;

SELECT SUM(valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT SUM(valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY SUM(valor) DESC;
