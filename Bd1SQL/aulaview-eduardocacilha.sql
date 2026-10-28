-- 1) criar uma visão que enxerga o código, nome, CPF e idade os dados
-- dos funcionários de Florianopolis com mais de 40 anos. Defina essa
-- visão com a cláusula WITH CHECK OPTION;

create view Floripa (codf, nome, cpf, idade)
as 
select codf, nome, cpf, idade
from funcionarios f
where f.cidade = 'Florianopolis' and f.idade > 40
with check option;



-- 2) consulte os dados da visão. Qual(is) funcionário(s) você enxerga?
--caio
select * from Floripa

-- 3) inserir o funcionário de nome Francisco, CPF 33300033333, 38 anos
-- e código 9 através da visão. A inserção funcionou?

insert into Floripa values 
(9,'Francisco',33300033333,38)

--nao por causa da clausula with check

-- 4) inserir o funcionário de nome Rodrigo, CPF 22200022233, 41 anos e
-- código 10 através da visão;

insert into Floripa values 
(10,'Rodrigo',22200022233,41)
-- 5) consulte os dados da visão. Você visualiza a tupla do Rodrigo?

select * from Floripa

--não


-- 6) definir uma trigger que, ao invés de inserir na visão, insere
-- diretamente na tabela Funcionários preenchendo o atributo cidade com
-- ‘Florianopolis’;

 
create or replace rule InsercaoFloripa as
on insert to Floripa
do instead
insert into funcionarios (codf, nome, cpf, idade, cidade)
values (new.codf, new.nome, new.cpf, new.idade, 'Florianopolis');

-- 7) inserir o funcionário de nome Raul, CPF 44400044433, 53 anos e
-- código 11;

insert into Floripa values 
(11,'Raul',44400044433,53)

-- 8) consulte os dados da visão. Você visualiza a tupla do Raul?

select * from Floripa

--SIM!!



