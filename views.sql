SELECT numero, nome, ativo
FROM banco;

CREATE OR REPLACE VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    FROM banco
);

SELECT numero, nome, ativo
FROM vw_bancos;

CREATE OR REPLACE VIEW vw_bancos_2 (banco_numero, banco_nome, banco_ativo) AS (
    SELECT numero, nome, ativo
    FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos_2;

INSERT INTO vw_bancos_2 (banco_numero, banco_nome, banco_ativo)
VALUES (51, 'Banco Boa Ideia', TRUE);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos_2
WHERE banco_numero = 51;

SELECT numero, nome, ativo
FROM banco
WHERE numero = 51;

UPDATE vw_bancos_2
SET banco_ativo = FALSE
WHERE banco_numero = 51;

DELETE FROM vw_bancos_2
WHERE banco_numero = 51;

CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
    SELECT nome FROM agencia
);

SELECT nome FROM vw_agencia;

CREATE OR REPLACE VIEW vw_bancos_ativos AS (
    SELECT numero, nome, ativo
    FROM banco
    WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

CREATE OR REPLACE VIEW vw_bancos_ativos AS (
    SELECT numero, nome, ativo
    FROM banco
    WHERE ativo IS TRUE
);

INSERT INTO vw_bancos_ativos (numero, nome, ativo)
VALUES (51, 'Banco Boa Ideia', FALSE);

SELECT nome FROM vw_bancos_ativos;

CREATE OR REPLACE VIEW vw_bancos_com_a AS (
    SELECT numero, nome, ativo
    FROM vw_bancos_ativos
    WHERE nome ILIKE 'Banco A%'
) WITH LOCAL CHECK OPTION;

CREATE OR REPLACE VIEW vw_bancos_com_a AS (
    SELECT numero, nome, ativo
    FROM vw_bancos_ativos
    WHERE nome ILIKE 'Banco A%'
) WITH CASCADED CHECK OPTION;

SELECT nome FROM vw_bancos_com_a;

INSERT INTO vw_bancos_com_a (numero, nome, ativo)
VALUES (333, 'Banco Z', FALSE);

INSERT INTO vw_bancos_com_a (numero, nome, ativo)
VALUES (333, 'Banco ABBA', FALSE);

INSERT INTO vw_bancos_com_a (numero, nome, ativo)
VALUES (333, 'Banco ABBA', TRUE);

DELETE FROM vw_bancos_com_a
WHERE numero = 333;


CREATE TABLE IF NOT EXISTS funcionarios (
    id SERIAL,
    nome VARCHAR(50),
    gerente INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY (gerente) REFERENCES funcionarios(id)
);

INSERT INTO funcionarios (nome, gerente) VALUES ('Ancelmo', null);
INSERT INTO funcionarios (nome, gerente) VALUES ('Beatriz', 1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Magno', 1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Cremilda', 2);
INSERT INTO funcionarios (nome, gerente) VALUES ('Wagner', 4);

SELECT id, nome, gerente FROM funcionarios WHERE gerente IS NULL
UNION ALL
SELECT id, nome, gerente FROM funcionarios WHERE id = 999;

CREATE OR REPLACE RECURSIVE VIEW vw_func(id, gerente, funcionario) AS (
    SELECT id, gerente, nome
    FROM funcionarios
    WHERE gerente IS NULL
    
    UNION ALL
    
    SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
    FROM funcionarios
    JOIN vw_func ON vw_func.id = funcionarios.gerente
);

CREATE OR REPLACE RECURSIVE VIEW vw_func_2(id, gerente, funcionario) AS (
    SELECT id, CAST('' AS VARCHAR) AS gerente, nome
    FROM funcionarios
    WHERE gerente IS NULL
    
    UNION ALL
    
    SELECT funcionarios.id, gerentes.nome, funcionarios.nome
    FROM funcionarios
    JOIN vw_func_2 ON vw_func_2.id = funcionarios.gerente
    JOIN funcionarios gerentes ON gerentes.id = vw_func_2.id
);

SELECT id, gerente, funcionario FROM vw_func;
SELECT id, gerente, funcionario FROM vw_func_2;
