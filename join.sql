SELECT COUNT(1) FROM banco; -- 151
SELECT COUNT(1) FROM agencia; -- 296
SELECT COUNT(1) FROM cliente; -- 500

-- Show name and code of banks and agencies
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
JOIN agencia
	ON banco.numero = agencia.banco_numero;

-- Count agencies in each bank
SELECT banco.nome, COUNT(agencia.numero)
FROM banco
JOIN agencia
	ON banco.numero = agencia.banco_numero
GROUP BY banco.nome
ORDER BY COUNT(agencia.numero) DESC;

-- Show banks that have agencies
SELECT banco.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero
GROUP BY banco.nome;

-- 296 bank entries with agencies
SELECT count(banco.nome)
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero

-- 438 bank entries with/without agencies
SELECT count(banco.nome)
FROM banco
LEFT JOIN agencia ON agencia.banco_numero = banco.numero

-- Same as before, with right join
SELECT count(banco.nome)
FROM agencia
RIGHT JOIN banco ON agencia.banco_numero = banco.numero

-- Same as before, with full join
SELECT count(banco.nome)
FROM agencia
FULL JOIN banco ON agencia.banco_numero = banco.numero

-- 9 unique banks
SELECT count(distinct banco.nome)
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

-- Order clients by highest transaction sum
select cliente.nome, SUM(cliente_transacoes.valor)
from cliente
join cliente_transacoes
	ON cliente.numero = cliente_transacoes.cliente_numero
GROUP BY nome
ORDER BY SUM(cliente_transacoes.valor) DESC;

CREATE TABLE IF NOT EXISTS teste_a (id serial primary key, valor varchar(10));
CREATE TABLE IF NOT EXISTS teste_b (id serial primary key, valor varchar(10));

INSERT INTO teste_a (valor) VALUES ('teste1');
INSERT INTO teste_a (valor) VALUES ('teste2');
INSERT INTO teste_a (valor) VALUES ('teste3');
INSERT INTO teste_a (valor) VALUES ('teste4');

INSERT INTO teste_b (valor) VALUES ('testea');
INSERT INTO teste_b (valor) VALUES ('testeb');
INSERT INTO teste_b (valor) VALUES ('testec');
INSERT INTO teste_b (valor) VALUES ('tested');

SELECT a.valor, b.valor
FROM teste_a a
CROSS JOIN teste_b b;

DROP TABLE IF EXISTS teste_a, teste_b;

SELECT 	banco.nome "bank name",
		agencia.nome "agency name",
		conta_corrente.numero "account number",
		conta_corrente.digito "code number",
		cliente.nome "cliente name"
FROM banco
JOIN agencia 
	ON agencia.banco_numero = banco.numero
JOIN conta_corrente
	ON conta_corrente.banco_numero = banco.numero
	AND conta_corrente.agencia_numero = agencia.numero
JOIN cliente
	ON cliente.numero = conta_corrente.cliente_numero;
	
SELECT 	banco.nome "bank name",
		agencia.nome "agency name",
		conta_corrente.numero "account number",
		conta_corrente.digito "code number",
		cliente.nome "cliente name",
		cliente_transacoes.valor "valor",
		tipo_transacao.nome "transacao"
FROM banco
JOIN agencia 
	ON agencia.banco_numero = banco.numero
JOIN conta_corrente
	ON conta_corrente.banco_numero = banco.numero
	AND conta_corrente.agencia_numero = agencia.numero
JOIN cliente
	ON cliente.numero = conta_corrente.cliente_numero
JOIN cliente_transacoes
	ON cliente_transacoes.cliente_numero = cliente.numero
JOIN tipo_transacao
	ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
ORDER BY cliente_transacoes.valor DESC
