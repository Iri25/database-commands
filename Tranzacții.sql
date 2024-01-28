if exists(select * from sys.databases where name = 'Laborator14')
begin
	use master;
	drop database Laborator14;
end;

create database Laborator14;
go

use Laborator14;

create table Clienti (
	id int primary key,
	denumire varchar(50)
);

go

create table Facturi (
	id int primary key,
	serie nchar(10),
	numar int,
	data date,
	id_client int constraint fk_clienti_facturi foreign key references Clienti(id)
);

go

create table Produse (
	id int primary key,
	denumire nvarchar(50),
	pret_curent money
);
go

create table RanduriFact(
	id int primary key,
	id_produs int foreign key references Produse(id),
	id_factura int foreign key references Facturi(id),
	cantitate int,
	pret money,
	valoare as cantitate * pret -- camp calculat
);

insert into Clienti(id, denumire) values (1, 'client1'), (2, 'client2');

go

insert into Facturi(id, serie, numar, id_client) values
(1, 'as', 1, 1),
(2, 'as', 2, 1),
(3, 'as', 3, 1),
(4, 'as', 4, 2);

insert into Produse(id, denumire) values
(1, 'pr1'),
(2, 'pr2'),
(3, 'pr3');

go

insert into RanduriFact(id, id_produs, id_factura, cantitate, pret) values
(1, 1, 1, 2, 1),
(2, 2, 1, 3, 2),
(3, 3, 1, 4, 3),
(4, 1, 1, 5, 4),
(5, 2, 2, 6, 5),
(6, 3, 2, 7, 6);

go

select * from RanduriFact;
select * from Facturi;

select (select denumire from Produse where Produse.id = id_produs) as denumire,
cantitate, pret, cantitate * pret as val_rand, valoare from RanduriFact;

alter table Facturi
add valoare_factura money;

go

create or alter trigger tr_val_fact
on RanduriFact
after insert, delete, update
as
begin
	declare @id_fact int, @val_fact money;

	if exists(select * from inserted)
		select @id_fact = id_factura from inserted;
	if exists(select * from deleted)
		select @id_fact = id_factura from deleted;
	select @val_fact = sum(valoare) from RanduriFact where RanduriFact.id_factura = @id_fact;
	update Facturi set valoare_factura = @val_fact
	where id = @id_fact;
end;

go

-- tranzactie
begin tran

commit tran

insert into RanduriFact values(7, 1, 2, 1, 2.0);

delete from RanduriFact where id = 7;

update RanduriFact set cantitate = 2 where id = 7;

select * from Facturi;

update RanduriFact set cantitate = 2 where id > 5;