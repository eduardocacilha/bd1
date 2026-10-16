--1
select * from medicos where idade < 40 or especialidade <> 'traumatologia'

--2
select nome,idade from pacientes where cidade <> 'Florianopolis'

--3
select nome, idade*12 as IdadeMeses from pacientes 

--4
--select * from consultas where data = '2020-10-13'
select max(hora) from consultas where data = '2020-10-13'

--5
select * from medicos
--transformando media em inteiro para não trazer idade quebrada, ficou 40
select cast(avg(idade) as int) from medicos
select codm, nome, count(distinct nroa) from medicos group by codm

--6
select codf, nome, salario*0.8 as SalarioLiquido from funcionarios

--7

select nome from funcionarios where nome like '%a'

--8

 select nome,especialidade from medicos where nome like '_o%' and nome like '%o'

 --9
--select * from pacientes
 select codp, nome from pacientes where idade > 25 and doenca in ('tendinite', 'fratura', 'gripe', 'sarampo')

 --10

select cpf, nome, idade from medicos where cidade = 'Florianopolis'
union
select cpf, nome, idade from pacientes where cidade = 'Florianopolis'
union
select cpf, nome, idade from funcionarios where cidade = 'Florianopolis';




