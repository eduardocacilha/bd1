--Resolva o que se pede utilizando subconsultas [NOT] IN:
--1) nome dos pacientes com consultas marcadas após às 14 horas

select nome,hora
from pacientes p
join consultas c on c.codp = p.codp

select nome 
from pacientes p 
where codp in (select codp from consultas where hora > '14:00:00')
--2) nome e idade dos médicos que possuem consulta com a paciente Ana
select distinct nome, idade
from medicos 
where codm in (select codm from Consultas where codp in 
(select codp from pacientes where nome = 'Ana') )
--3) número e andar dos ambulatórios onde nenhum médico dá atendimento
select * from Medicos

select * from Ambulatorios

select nroa,andar 
from Ambulatorios
where nroa not in (select nroa from medicos where nroa is not null)

--Resolva o que se pede utilizando subconsultas SOME e/ou ALL:

--4) CPF dos médicos que atendem em ambulatórios do primeiro andar
select cpf from medicos 
where nroa = some  (select nroa from Ambulatorios where andar = 1) 
--5) nome e CPF de todos os funcionários, exceto o de maior salário
select nome,cpf from Funcionarios where salario < some (select salario from Funcionarios)

--6) nome dos pacientes com consultas marcadas para horários anteriores a
--todos os horários de consultas marcadas para o dia 14/10/2020
select nome from pacientes where codp in (select codp from consultas 
where hora < all ( select hora from consultas where data = '14/10/2020'))

--7) número e andar dos ambulatórios com capacidade superior à capacidade
--de qualquer ambulatório que esteja no primeiro andar

select nroa, andar from Ambulatorios 
where capacidade > some (select capacidade from Ambulatorios where andar = 1)






