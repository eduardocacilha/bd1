-- =====================================================================
--  BD do Museu – Lista de Exercícios SQL (INE5613 / Prof. Ronaldo Mello)
--  PostgreSQL – rode o arquivo inteiro de novo sempre que quiser
--  "resetar" o banco (ex.: depois de testar os exercícios 12 e 13).
--
--  Uso:  psql -U postgres -d <seu_banco> -f museu_bd1.sql
--        (ou abrir no pgAdmin/DBeaver e executar tudo)
--
--  Nomes sem acento (padrão no Postgres):
--    Funcionários -> funcionarios | Lotações -> lotacoes | Salões -> saloes
--    título -> titulo | salão -> salao | área -> area | salário -> salario
--    função -> funcao | número -> numero | horaEntrada -> horaentrada ...
--  Os VALORES mantêm acento: funcao = 'segurança' / 'faxineiro'.
-- =====================================================================

DROP SCHEMA IF EXISTS museu CASCADE;
CREATE SCHEMA museu;
-- Todas as tabelas são criadas com prefixo museu. para não colidir com
-- tabelas de outros exercícios (ex.: funcionarios do BD do hospital no public).
-- Para as consultas, rode antes:  SET search_path TO museu;
-- (ou escreva museu.obras, museu.autores etc.)
SET search_path TO museu;

-- ---------------------------------------------------------------------
-- SCHEMA
-- ---------------------------------------------------------------------

CREATE TABLE museu.saloes (
    numero  INTEGER       PRIMARY KEY,
    andar   INTEGER       NOT NULL,
    area    NUMERIC(8,2)  NOT NULL CHECK (area > 0)
);

CREATE TABLE museu.autores (
    codigo         INTEGER      PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    nacionalidade  VARCHAR(50)
);

CREATE TABLE museu.obras (
    codigo  INTEGER      PRIMARY KEY,
    titulo  VARCHAR(150) NOT NULL,
    ano     INTEGER,
    -- SET NULL: ao remover um autor, a obra continua no museu sem autor
    autor   INTEGER      REFERENCES museu.autores (codigo) ON DELETE SET NULL,
    salao   INTEGER      REFERENCES museu.saloes  (numero)
);

CREATE TABLE museu.pinturas (
    codigo  INTEGER      PRIMARY KEY REFERENCES museu.obras (codigo) ON DELETE CASCADE,
    estilo  VARCHAR(50),
    area    NUMERIC(6,2)            -- área da tela em m²
);

CREATE TABLE museu.esculturas (
    codigo    INTEGER      PRIMARY KEY REFERENCES museu.obras (codigo) ON DELETE CASCADE,
    altura    NUMERIC(6,2),         -- metros
    peso      NUMERIC(8,2),         -- kg
    material  VARCHAR(50)
);

CREATE TABLE museu.funcionarios (
    cpf      CHAR(11)      PRIMARY KEY,
    nome     VARCHAR(100)  NOT NULL,
    salario  NUMERIC(10,2) NOT NULL,
    turno    CHAR(1)       NOT NULL CHECK (turno IN ('M', 'T', 'N')),
    funcao   VARCHAR(20)   NOT NULL CHECK (funcao IN ('segurança', 'faxineiro'))
);

-- (Exercício 14 pede para você criar esta tabela – tente escrever a sua
--  versão no papel antes de olhar esta.)
CREATE TABLE museu.lotacoes (
    cpf          CHAR(11) REFERENCES museu.funcionarios (cpf) ON DELETE CASCADE,
    numero       INTEGER  REFERENCES museu.saloes (numero)    ON DELETE CASCADE,
    horaentrada  TIME     NOT NULL,
    horasaida    TIME     NOT NULL,   -- turno da noite pode "virar" o dia (22:00 -> 06:00)
    PRIMARY KEY (cpf, numero, horaentrada)
);

-- ---------------------------------------------------------------------
-- DADOS
-- ---------------------------------------------------------------------

INSERT INTO museu.saloes (numero, andar, area) VALUES
    (10, 1, 300),
    (11, 1, 450),
    (20, 2, 520),
    (25, 2, 380),
    (30, 3, 600),
    (31, 3, 350),
    (36, 3, 480),
    (40, 4, 250),
    (41, 4, 280),
    (42, 4, 310),
    (50, 5, 900);

INSERT INTO museu.autores (codigo, nome, nacionalidade) VALUES
    ( 1, 'Pablo Picasso',          'espanhola'),
    ( 2, 'Claude Monet',           'francesa'),
    ( 3, 'Auguste Rodin',          'francesa'),
    ( 4, 'Salvador Dalí',          'espanhola'),
    ( 5, 'Edgar Degas',            'francesa'),
    ( 6, 'Tarsila do Amaral',      'brasileira'),
    ( 7, 'Camille Claudel',        'francesa'),
    ( 8, 'Frida Kahlo',            'mexicana'),
    ( 9, 'Pierre-Auguste Renoir',  'francesa'),
    (10, 'Leonardo da Vinci',      'italiana'),
    (11, 'Ron Mueck',              'australiana'),
    (12, 'Beatriz Milhazes',       'brasileira'),
    (13, 'Mestre Vitalino',        'brasileira'),
    (14, 'Vik Muniz',              'brasileira');

INSERT INTO museu.obras (codigo, titulo, ano, autor, salao) VALUES
    -- Picasso
    ( 101, 'Guernica',                              1937,  1, 30),
    ( 102, 'Les Demoiselles d''Avignon',            1907,  1, 31),
    ( 103, 'Cabeça de Mulher (Fernande)',           1909,  1, 30),
    ( 104, 'O Velho Guitarrista Cego',              1903,  1, 20),
    -- Monet
    ( 201, 'Impressão, Nascer do Sol',              1872,  2, 20),
    ( 202, 'Ninfeias',                              1906,  2, 50),
    ( 203, 'A Ponte Japonesa',                      1899,  2, 25),
    -- Rodin
    ( 301, 'O Pensador',                            1880,  3, 11),
    ( 302, 'O Beijo',                               1882,  3, 11),
    ( 303, 'Os Burgueses de Calais',                1889,  3, 41),
    -- Dalí
    ( 401, 'A Persistência da Memória',             1931,  4, 31),
    ( 402, 'Os Elefantes',                          1948,  4, 30),
    ( 403, 'Vênus de Milo com Gavetas',             1936,  4, 42),
    -- Degas
    ( 501, 'A Aula de Dança',                       1874,  5, 20),
    ( 502, 'Pequena Bailarina de Catorze Anos',     1881,  5, 42),
    -- Tarsila
    ( 601, 'Abaporu',                               1928,  6, 42),
    -- Camille Claudel
    ( 701, 'A Valsa',                               1893,  7, 41),
    -- Renoir
    ( 901, 'Baile no Moulin de la Galette',         1876,  9, 40),
    ( 902, 'O Almoço dos Remadores',                1881,  9, 25),
    -- Leonardo
    (1001, 'Mona Lisa',                             1503, 10, 50),
    (1002, 'A Virgem das Rochas',                   1486, 10, 50),
    -- Ron Mueck
    (1101, 'Boy',                                   1999, 11, 36),
    (1102, 'Mask II',                               2002, 11, 36),
    -- Beatriz Milhazes
    (1201, 'O Mágico',                              2001, 12, 36),
    (1202, 'Gamboa',                                2010, 12, 36),
    (1203, 'Mulatinho',                             1993, 12, 36),
    -- Mestre Vitalino
    (1301, 'Vaqueiro',                              1955, 13, 41),
    -- Vik Muniz
    (1401, 'Marat (Sebastião)',                     2008, 14, 36),
    (1402, 'Imagens de Lixo',                       2017, 14, 36),
    (1403, 'Crianças de Açúcar',                    1995, 14, 36),
    (1404, 'Retrato em Chocolate',                  2015, 14, 36);

INSERT INTO museu.pinturas (codigo, estilo, area) VALUES
    ( 101, 'cubista',        27.30),
    ( 102, 'cubista',         5.62),
    ( 104, 'expressionista',  1.68),
    ( 201, 'impressionista',  0.31),
    ( 202, 'impressionista',  1.80),
    ( 203, 'impressionista',  0.85),
    ( 401, 'surrealista',     0.08),
    ( 402, 'surrealista',     0.45),
    ( 501, 'impressionista',  0.62),
    ( 601, 'modernista',      0.73),
    ( 901, 'impressionista',  2.34),
    ( 902, 'impressionista',  2.25),
    (1001, 'renascentista',   0.40),
    (1002, 'renascentista',   2.39),
    (1201, 'abstrato',        4.00),
    (1202, 'abstrato',        6.25),
    (1203, 'abstrato',        3.20),
    (1401, 'contemporâneo',   2.10),
    (1402, 'contemporâneo',   1.50),
    (1403, 'contemporâneo',   1.20),
    (1404, 'contemporâneo',   0.90);

INSERT INTO museu.esculturas (codigo, altura, peso, material) VALUES
    ( 103, 0.41,   12.0, 'bronze'),
    ( 301, 1.86,  680.0, 'bronze'),
    ( 302, 1.82, 3180.0, 'mármore'),
    ( 303, 2.17, 8500.0, 'bronze'),
    ( 403, 0.98,   35.0, 'gesso'),
    ( 502, 0.98,   28.0, 'bronze'),
    ( 701, 0.43,    8.5, 'argila'),
    (1101, 4.90,  400.0, 'silicone'),
    (1102, 0.77,   60.0, 'resina'),
    (1301, 0.30,    2.0, 'argila');

INSERT INTO museu.funcionarios (cpf, nome, salario, turno, funcao) VALUES
    ('11111111111', 'João da Silva',   3200.00, 'N', 'segurança'),
    ('22222222222', 'Pedro Souza',     3100.00, 'N', 'segurança'),
    ('33333333333', 'Carlos Santos',   3000.00, 'M', 'segurança'),
    ('44444444444', 'José Pereira',    3300.00, 'M', 'segurança'),
    ('55555555555', 'Marcos Lima',     2900.00, 'T', 'segurança'),
    ('66666666666', 'Ana Costa',       3050.00, 'T', 'segurança'),
    ('77777777777', 'Maria Oliveira',  1900.00, 'M', 'faxineiro'),
    ('88888888888', 'Lúcia Ferreira',  1850.00, 'T', 'faxineiro'),
    ('99999999999', 'Paulo Rocha',     1800.00, 'N', 'faxineiro'),
    ('10101010101', 'Rita Almeida',    1950.00, 'M', 'faxineiro');

INSERT INTO museu.lotacoes (cpf, numero, horaentrada, horasaida) VALUES
    -- João da Silva (segurança, N)
    ('11111111111', 30, '22:00', '06:00'),
    ('11111111111', 25, '22:00', '06:00'),
    ('11111111111', 50, '22:00', '06:00'),
    -- Pedro Souza (segurança, N)
    ('22222222222', 30, '22:00', '06:00'),
    ('22222222222', 50, '18:00', '22:00'),
    -- Carlos Santos (segurança, M)
    ('33333333333', 20, '08:00', '14:00'),
    ('33333333333', 31, '08:00', '14:00'),
    ('33333333333', 25, '08:00', '14:00'),
    ('33333333333', 36, '14:00', '18:00'),
    -- José Pereira (segurança, M)
    ('44444444444', 20, '08:00', '14:00'),
    ('44444444444', 31, '10:00', '13:00'),
    ('44444444444', 31, '14:00', '16:00'),
    -- Marcos Lima (segurança, T)
    ('55555555555', 10, '12:00', '14:00'),
    ('55555555555', 20, '14:00', '17:00'),
    ('55555555555', 11, '17:00', '20:00'),
    -- Ana Costa (segurança, T)
    ('66666666666', 20, '14:00', '17:00'),
    ('66666666666', 40, '17:00', '18:00'),
    ('66666666666', 41, '18:00', '19:00'),
    ('66666666666', 42, '19:00', '20:00'),
    -- Maria Oliveira (faxineiro, M)
    ('77777777777', 40, '06:00', '07:00'),
    ('77777777777', 41, '07:00', '08:00'),
    ('77777777777', 20, '08:00', '14:00'),
    ('77777777777', 42, '14:00', '15:00'),
    -- Lúcia Ferreira (faxineiro, T)
    ('88888888888', 40, '14:00', '16:00'),
    ('88888888888', 41, '16:00', '18:00'),
    -- Paulo Rocha (faxineiro, N)
    ('99999999999', 25, '22:00', '02:00'),
    -- Rita Almeida (faxineiro, M)
    ('10101010101', 42, '08:00', '10:00'),
    ('10101010101', 30, '10:00', '12:00');

-- Conferência rápida
SELECT 'saloes' AS tabela, COUNT(*) FROM museu.saloes
UNION ALL SELECT 'autores',      COUNT(*) FROM museu.autores
UNION ALL SELECT 'obras',        COUNT(*) FROM museu.obras
UNION ALL SELECT 'pinturas',     COUNT(*) FROM museu.pinturas
UNION ALL SELECT 'esculturas',   COUNT(*) FROM museu.esculturas
UNION ALL SELECT 'funcionarios', COUNT(*) FROM museu.funcionarios
UNION ALL SELECT 'lotacoes',     COUNT(*) FROM museu.lotacoes;
