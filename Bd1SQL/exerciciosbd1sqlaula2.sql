--inserções especificando campos e suas respectivas ordens

INSERT INTO ambulatorios (nroa, andar, capacidade) VALUES
(1, 1, 30),
(2, 1, 50),
(3, 2, 40),
(4, 2, 25),
(5, 2, 55);

INSERT INTO medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES
(1, 'Joao', 40, 'ortopedia', '10000100000', 'Florianopolis', 1),
(2, 'Maria', 42, 'traumatologia', '10000110000', 'Blumenau', 2),
(3, 'Pedro', 51, 'pediatria', '11000100000', 'São José', 2),
(4, 'Carlos', 28, 'ortopedia', '11000110000', 'Joinville', NULL),
(5, 'Marcia', 33, 'neurologia', '11000111000', 'Biguacu', 3);

INSERT INTO pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES
(1, 'Ana', 20, 'Florianopolis', '20000200000', 'gripe'),
(2, 'Paulo', 24, 'Palhoca', '20000220000', 'fratura'),
(3, 'Lucia', 30, 'Biguacu', '22000200000', 'tendinite'),
(4, 'Carlos', 28, 'Joinville', '11000110000', 'sarampo');

INSERT INTO funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES
(1, 'Rita', 32, 'Sao Jose', 1200, '20000100000'),
(2, 'Vera', 55, 'Palhoca', 1220, '30000110000'),
(3, 'Caio', 45, 'Florianopolis', 1100, '41000100000'),
(4, 'Marcelo', 44, 'Florianopolis', 1200, '51000110000'),
(5, 'Paula', 33, 'Florianopolis', 2500, '61000111000');

INSERT INTO consultas (codm, codp, data, hora) VALUES
(1, 1, '2020-10-12', '14:00'),
(1, 4, '2020-10-13', '10:00'),
(2, 1, '2020-10-13', '09:00'),
(2, 2, '2020-10-13', '11:00'),
(2, 3, '2020-10-14', '14:00'),
(2, 4, '2020-10-14', '17:00'),
(3, 1, '2020-10-19', '18:00'),
(3, 3, '2020-10-12', '10:00'),
(3, 4, '2020-10-19', '13:00'),
(4, 4, '2020-10-20', '13:00'),
(4, 4, '2020-10-22', '19:30');



--consultei as inserções em todas as tabelas
select * from ambulatorios
select * from medicos
select * from consultas
select * from pacientes
select * from funcionarios


--segunda parte dos exercicios


--1) O paciente Paulo mudou-se para Ilhota
--2) A consulta do médico 1 com o paciente 4 passou para às 12:00 horas do dia 4 de Novembro de 2020
--3) A consulta do médico 3 com o paciente 4 passou para às14h30
--4) O funcionário 4 deixou a clínica
--5) As consultas após as 19 horas devem ser excluídas
--6) Os médicos que residem em Biguacu e Palhoca devem ser excluídos

--1)
select * from pacientes where codp = 2

update pacientes 
set cidade = 'Ilhota'
where codp = 2
--2)
select * from consultas where codm = 1 and codp = 4

UPDATE consultas
SET hora = '12:00:00',
    data = '2020-11-04'
WHERE codm = 1 AND codp = 4;
--3)
select * from consultas where codm = 3 and codp = 4

update consultas
set hora = '14:30:00'
where codm = 3 and codp = 4
--4)
select * from funcionarios where codf = 4

delete from funcionarios 
where codf = 4;

--5)
select * from consultas where hora > '19:00:00'


delete from consultas where hora > '19:00:00';

--6)

select * from medicos
--corrigindo erro do professor
update medicos
set cidade = 'Sao Jose'
where cidade = 'São José'
--
delete from medicos
where cidade in ('Biguacu', 'Palhoca')

select * from medicos


