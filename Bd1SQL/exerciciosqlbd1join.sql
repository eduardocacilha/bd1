--1)
select 
m.nome,
m.cpf
from medicos m 
join pacientes p on p.cpf = m.cpf
--2)
select * from medicos 
select * from funcionarios

select 
m.nome,
f.nome
from funcionarios f
join medicos m on m.cidade = f.cidade


--3)

select distinct
m.nome,
m.idade
from medicos m
join consultas c on c.codm = m.codm
join pacientes p on p.codp = c.codp
where p.nome = 'Ana';

--4)

select 
 a2.nroa
from ambulatorios a1
join ambulatorios a2 on a1.andar = a2.andar
where a1.nroa = 5 and a2.nroa <> 5;


--5)
select distinct
p.codp,
p.nome
from pacientes p
natural join consultas c
where c.hora > '14:00';

--6)

select distinct
a.nroa,
a.andar
from ambulatorios a
natural join medicos m
natural join consultas c
where c.data = '2020-10-12';

--7)
select 
a.*,
m.codm,
m.nome
from ambulatorios a
left join medicos m on m.nroa = a.nroa;

--8)

select 
m.cpf,
m.nome as nome_medico,
p.nome as nome_paciente,
c.data
from medicos m
left join consultas c on c.codm = m.codm
left join pacientes p on p.codp = c.codp;