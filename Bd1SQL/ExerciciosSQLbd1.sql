--Eduardo Cacilha Steinbach 25105628

--exercicio 1 

create table if not exists Ambulatorios (
    nroa int primary key,
    andar numeric(2) not null,
    capacidade smallint
);

create table if not exists Medicos (
    codm int primary key,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar(40),
    cpf numeric(11) not null unique,
    especialidade varchar(30),
    nroa int references Ambulatorios(nroa)
);

create table if not exists Pacientes (
    codp int primary key,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar(40),
    cpf numeric(11) not null unique,
    doenca varchar(40) not null
);

create table if not exists Funcionarios (
    codf int primary key,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar(40),
    cpf numeric(11) not null unique,
    salario numeric(10),
    cargo varchar(40)
);

create table if not exists Consultas (
    codm int references Medicos(codm),
    codp int references Pacientes(codp),
    data date,
    hora time,
    primary key (codm, data, hora)
);


--exercicio 2
alter table Funcionarios drop column cargo;
--exercicio 3
create index idx_pacientes_cidade on Pacientes (cidade); 
