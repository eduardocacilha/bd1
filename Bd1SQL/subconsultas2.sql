
-- Responda utilizando subconsultas com EXISTS:
-- 1) Buscar o nome e o CPF dos médicos que também são pacientes do
-- hospital
select 
    m.nome, 
    m.cpf
from medicos m
where exists (
    select 1 
    from pacientes p 
    where p.cpf = m.cpf
);
-- 2) Buscar o nome e o CPF dos médicos ortopedistas, e a data das
-- suas consultas, para os ortopedistas que têm consulta marcada com
-- a paciente Ana
select * from medicos

select nome,cpf
from medicos m
where especialidade = 'ortopedia'
and exists (
	select 1
	from pacientes p
	join consultas c on c.codm = m.codm
	where p.nome = 'Ana'
)
-- 3) Buscar o nome e o CPF dos médicos que têm consultas marcadas
-- com todos os pacientes

select 
    m.nome,
    m.cpf
from medicos m
where not exists (
    select *
    from pacientes p
    where not exists (
        select *
        from consultas c
        where c.codm = m.codm
          and c.codp = p.codp
    )
);
-- 4) Buscar o nome e o CPF dos médicos ortopedistas que têm
-- consultas marcadas com todos os pacientes de Florianópolis

select 
    m.nome,
    m.cpf
from medicos m
where m.especialidade = 'ortopedia'
  and not exists (
      select *
      from pacientes p
      where p.cidade = 'Florianopolis'
        and not exists (
            select *
            from consultas c
            where c.codm = m.codm
              and c.codp = p.codp
        )
  );


-- 1) Buscar a data e a hora das consultas marcadas para a médica Maria
select 
    c.data, 
    c.hora
from consultas c
join (
    select codm 
    from medicos 
    where nome = 'Maria'
) as sub on sub.codm = c.codm;

-- 2) Buscar o nome e a cidade dos pacientes que têm consultas marcadas com ortopedistas
select distinct
    p.nome,
    p.cidade
from pacientes p
join (
    select c.codp
    from consultas c
    join medicos m on m.codm = c.codm
    where m.especialidade = 'ortopedia'
) as c_orto on c_orto.codp = p.codp;

-- 3) Buscar o nome e o CPF dos médicos que atendem no mesmo ambulatório do médico Pedro
select 
    m.nome,
    m.cpf
from medicos m
join (
    select nroa
    from medicos
    where nome = 'Pedro'
) as sub on sub.nroa = m.nroa
where m.nome <> 'Pedro';

