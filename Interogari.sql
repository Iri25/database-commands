use CompanieTelefonicaBD;

--Sedii
insert into Sedii values(124551, 'Phone Shop', 10, 'Afrim', 'Marius', 0741638990, 'Cluj-Napoca', 'Plopilor', 2, 'telefoane, tablete, laptopuri, accesorii');
insert into Sedii values(124552, 'Phone Store', 11, 'Lazar', 'Darius', 0766638190, 'Cluj-Napoca', 'Dorabantilor', 32, 'telefoane, tablete, laptopuri, accesorii');
insert into Sedii values(124553, 'Phone', 12, 'Mariuc', 'Anastasia', 0766638102, 'Cluj-Napoca', 'Manastur', 12, 'telefoane, tablete');
select* from Sedii;

--Servicii
insert into Servicii values(100, 124551, 'Cumparare cartela SIM', 'credit/minut ', 30.00 );
insert into Servicii values(101, 124551, 'Reincarcare cartela PrePay ', '6 EUR', 33.00 );
insert into Servicii values(102, 124553, 'Plata abonament telefon', 'Fun 10 EUR/luna', 48.00 );
insert into Servicii values(103, 124553, 'Cumparare accesorii telefon', 'Devia Husa silicon transparent', 20.00 );
insert into Servicii values(104, 124552, 'Cumparare accesorii audio ', 'Samsung Casti InEar', 71.00 );
insert into Servicii values(105, 124551, 'Cumparare telefon', 'Samsung Galaxy A51 128GB Black', 1068.22 );
insert into Servicii values(106, 124551, 'Cumparare laptop', 'Laptop Huawei Matebook X Pro i7 16RAM 1TBSSD W10PRO', 908.42 );
insert into Servicii values(107, 124551, 'Reincarcare cartela PrePay', '10 EUR', 70.00 );
insert into Servicii values(108, 124552, 'Reincarcare cartela PrePay ', '7 EUR', 39.00 );
insert into Servicii values(109, 124552, 'Plata abonament telefon', 'Fun 8 EUR/luna', 40.00 );
insert into Servicii values(110, 124551, 'Cumparare telefon', 'Samsung Galaxy A20e 32GB Black', 908.42 );
insert into Servicii values(111, 124553, 'Cumparare tableta', 'iPad Pro 11 2020 WiFi Cellular 256GB Space Grey', 5914.99);
select* from Servicii;

--Produse
insert into Produse values (200, 124551, 'Telefon', 'Samsung Galaxy A51 128GB Black', 1068.22, '1 an');
insert into Produse values (201, 124551, 'Telefon', 'Samsung Galaxy A51 128GB White', 1068.22, '1 an');
insert into Produse values (202, 124551, 'Telefon', 'Samsung Galaxy A20e 32GB Black', 908.42, '1 an');
insert into Produse values (203, 124551, 'Laptop', 'Laptop Huawei Matebook X Pro i7 16RAM 1TBSSD W10PRO', 908.42, '1 an');
insert into Produse values (204, 124553, 'Tableta', 'iPad Pro 11 2020 WiFi Cellular 256GB Space Grey', 5914.99, '6 luni');
insert into Produse values (205, 124552, 'Laptop', 'Laptop Dell Vostro 5501 i5 a 10-a gen 8GB 256SSD', 4239.92, '2 an');
insert into Produse values (206, 124553, 'Laptop', 'Laptop Apple MacBook Air 13 2020 256GB Space Gray', 5699.40, '2 ani');
insert into Produse values (207, 124553, 'Tableta', 'iPad Pro 11 2nd gen WiFi Cellular 512GB Space Grey', 6995.67, '2 ani');
select* from Produse;

--Promotii
insert into Promotii values (1, 124551, 'Oferta speciala', '3 luni');
insert into Promotii values (2, 124551, 'Best Deal', '6 luni');
insert into Promotii values (3, 124552, 'Oferta speciala', '3 luni');
insert into Promotii values (4, 124552, 'Best Deal', '6 luni');
insert into Promotii values (5, 124553, 'Thank You', '3 luni');
select* from Promotii;

--Angajati
insert into Angajati values (1, 124551, 'Operator', 'Alexia', 'Dimitrie', 0744455510);
insert into Angajati values (2, 124551, 'Operator', 'Miclaus', 'Cosmina', 0744455911);
insert into Angajati values (3, 124551, 'Tehnician', 'Axia', 'Alexander', 0744415513);
insert into Angajati values (4, 124551, 'Reprezentat', 'Buta', 'Anamaria', 0744455122);
insert into Angajati values (5, 124551, 'Casier', 'Chis', 'Ecaterina', 0749955519);
insert into Angajati values (6, 124552, 'Operator', 'Lucas', 'Marc', 0744451122);
insert into Angajati values (7, 124552, 'Operator', 'Miclaus', 'Catalin', 0734455911);
insert into Angajati values (8, 124552, 'Tehnician', 'Iremia', 'Alexandra', 0754415913);
insert into Angajati values (9, 124552, 'Reprezentat', 'Popescu', 'Ana', 0748455142);
insert into Angajati values (10, 124552, 'Casier', 'Dujac', 'Ecaterina', 0749955919);
insert into Angajati values (11, 124553, 'Operator', 'Nemes', 'Ema', 0744451722);
insert into Angajati values (12, 124553, 'Operator', 'Miclaus', 'Catalin', 0734455991);
insert into Angajati values (13, 124553, 'Tehnician', 'Gadea', 'Veronica', 0754415813);
insert into Angajati values (14, 124553, 'Reprezentat', 'Pop', 'ALin', 0748455192);
insert into Angajati values (15, 124553, 'Casier', 'Drajmici', 'Paula', 0749955929);
insert into Angajati values (16, 124551, 'Curier', 'Checherita', 'Aurel', 0749955109);
insert into Angajati values (17, 124552, 'Curier', 'Criste', 'Radu', 0746955200);
insert into Angajati values (18, 124553, 'Curier', 'Moldovean', 'Viorel', 0759955115);
select* from Angajati;

--Clienti
insert into Clienti values(1, 102, 'Cu abonament', 'Popa', 'Monica', 0747561121);
insert into Clienti values(2, 100, 'Fara abonament', 'Pop', 'Raul', 0747561881);
insert into Clienti values(3, 105, 'Cu abonament', 'Irimia', 'Florin', 0747561120);
insert into Clienti values(4, 108, 'Fara abonament', 'Ureche', 'Mihai', 0747561721);
insert into Clienti values(5, 106, 'Cu abonament', 'Alexa', 'Ioana', 0747561990);
insert into Clienti values(6, 110, 'Fara abonament', 'Ureche', 'Marcela', 0741561461);
insert into Clienti values(7, 111, 'Fara abonament', 'Turda', 'Adrian', 0741561421);
select * from Clienti;

--Cereri
insert into Cereri values (1, 1, 11, '2020-09-14');
insert into Cereri values (2, 2, 5, '2020-09-14');
insert into Cereri values (3, 3, 5, '2020-09-15');
insert into Cereri values (4, 4, 16, '2020-10-19');
select * from Cereri;

--Comenzi
insert into Comenzi values (178901, 204, 18, 7, '2020-10-15', 5914.99);
insert into Comenzi values (178902, 200, 16, 2, '2020-10-18', 1068.22);
insert into Comenzi values (178903, 202, 16, 7, '2020-10-27', 908.42);
select * from Comenzi;

--Livrari
insert into Livrari values (124901, 178901, 7, '2020-10-16', 'Cluj - Napoca', ' Cluj - Napoca', 'Bucuresti', 68);
insert into Livrari values (124902, 178902, 2, '2020-10-21', 'Suceava', 'Gura Humorului', 'Liceului', 10);
select * from Livrari;

--Oferte
insert into Oferte values (20, 1, 1, 'Client fidel', '2020-09-11', '2020-12-11');
insert into Oferte values (21, 3, 5, 'Client fidel', '2020-10-20', '2021-01-28');
insert into Oferte values (22, 4, 7, 'Bonus', '2020-10-28', '2021-04-28');
select * from Oferte;

/*
interogare ce extrage clientii a caror comanda si livrare s-a realizat in luna octombrie
*/
select Cl.nume, Cl.prenume, Cl.numar_telefon from Clienti Cl
inner join Comenzi Co on Cl.id_client = Co.id_client
inner join Livrari L on Cl.id_client = L.id_client
where Co.data_comanda > '2020-09-30' and L.data_livrare > '2020-09-30';

/*
interogare ce extrage angajatii care au finalizat cereri si comenzi in luna octombrie
*/
select distinct A.nume, A.prenume, A.functie from Angajati A
inner join Cereri Ce on A.id_angajat = Ce.id_angajat 
inner join Comenzi Co on A.id_angajat = Co.id_angajat
where Ce.data_cerere > '2020-09-30' and Co.data_comanda > '2020-09-30';

/*
interogare ce extrage servicile pe care un angajat poate sa le finalizeze la un anumit sediu
*/
select distinct Ser.denumire, Ser.descriere from Servicii Ser
inner join Sedii S on Ser.numar_inregistrare_sediu = S.numar_inregistrare_sediu
inner join Angajati A on Ser.numar_inregistrare_sediu = A.numar_inregistrare_sediu;

/*
interogare ce extrage produsele pe care un angajat le poate vinde la un sediu
*/
select distinct P.denumire, P.descriere, P.perioada_de_garantie, P.pret from Produse P
inner join Sedii S on S.numar_inregistrare_sediu = P.numar_inregistrare_sediu
inner join Angajati A on S.numar_inregistrare_sediu = A.numar_inregistrare_sediu;

/*
interogare ce extrage sediile in care s-au vandut/cumparat un produs Samsung
*/
select distinct S.nume_sediu, S.localitate_sediu, S.strada_sediu, S.numar_sediu from Sedii S
inner join Servicii Ser on S.numar_inregistrare_sediu = Ser.numar_inregistrare_sediu
inner join Angajati A on S.numar_inregistrare_sediu = A.numar_inregistrare_sediu
where Ser.descriere like 'Samsung%';

/*
interogare ce extrage sediile care au produse de tip iPad
*/
select distinct S.nume_sediu, S.localitate_sediu, S.strada_sediu, S.numar_sediu, P.descriere, P.pret from Sedii S
inner join Produse P on S.numar_inregistrare_sediu = P.numar_inregistrare_sediu
inner join Angajati A on S.numar_inregistrare_sediu = A.numar_inregistrare_sediu
where P.descriere like 'iPad%';

/*
interogare ce extrage produsele al caror pret este mai mare decat 1.000 lei
*/
select distinct P.denumire, P.descriere, P.pret from Produse P
inner join Sedii S on S.numar_inregistrare_sediu = P.numar_inregistrare_sediu
inner join Angajati A on S.numar_inregistrare_sediu = A.numar_inregistrare_sediu
where P.pret > 1000.00;

/*
interogare ce afiseaza numarul total de comenzi efectuate pentru fiecare client care a comandat produse
*/
select id_client,
count(numar_inregistrare_comanda) as [numar_de_comenzi]
from Comenzi
group by id_client;

/*
interogare ce afiseaza totalul comenzilor pentru fiecare client care a comandat produse
*/
select id_client,
sum(pret) as [suma_totala]
from Comenzi
group by id_client
having sum(pret) > 1000.00;

/*
interogare ce afiseaza totalul angajatiilor de la fiecare sediu
*/
select numar_inregistrare_sediu,
count(id_angajat) as [angajati_in_total]
from Angajati
group by numar_inregistrare_sediu
having count(id_angajat) > 5;