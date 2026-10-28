-- Buscar o que se pede utilizando ORDER BY ou GROUP BY:
-- 1) os dados de todos os funcionários ordenados pelo salário (decrescente) e pela idade
-- (crescente). Buscar apenas os três primeiros funcionários nesta ordem*
select * from funcionarios order by salario desc, idade asc limit 3


-- 2) o nome dos médicos e o número e andar do ambulatório onde eles atendem,
-- ordenado pelo número do ambulatório
select * from medicos limit 1
select * from ambulatorios limit 1

select m.nome, a.andar, m.nroa
from medicos m
join ambulatorios a on a.nroa = m.nroa
order by a.nroa

-- 3) andares dos ambulatórios e a capacidade total por andar

select 
    andar, 
    sum(capacidade) as capacidade_total
from ambulatorios 
group by andar

-- 4) andares dos ambulatórios cuja média de capacidade no andar seja >= 40
select andar, avg(capacidade)
from ambulatorios
group by andar
having avg(capacidade) >= 40
-- 5) nome dos médicos que possuem mais de uma consulta marcada 

select m.nome
from medicos m
join consultas c on c.codm = m.codm
group by m.codm, m.nome
having count(*) > 1;


-- Realizar as seguintes atualizações:
-- 6) excluir os ambulatórios que não possuem médicos atendendo neles

delete from ambulatorios a
where not exists (
    select 1 
    from medicos m 
    where m.nroa = a.nroa
);

-- 7) o médico Pedro passa a residir na mesma cidade do paciente Paulo e sua idade
-- passa a ser o dobro da idade da paciente Ana. Realizar essa alteração.

select * from medicos where nome = 'Pedro'

update medicos m
set cidade = (select cidade from pacientes where nome = 'Paulo'),
idade = 2*(select idade from pacientes where nome = 'Ana')
where m.nome = 'Pedro'

-- 8) o funcionário Caio (codf = 3) tornou-se médico. Sua especialidade é a mesma da
-- médica Maria (codm = 2) e ele vai atender no mesmo ambulatório dela. Inserir Caio
-- na tabela Médicos, aproveitando os dados em comum.

insert into medicos (codm, nome, idade, especialidade, cpf, cidade, nroa)
select 
    (select max(codm) from medicos) + 1,
    f.nome,
    f.idade,
    (select especialidade from medicos where codm = 2),
    f.cpf,
    f.cidade,
    (select nroa from medicos where codm = 2)
from funcionarios f
where f.codf = 3;