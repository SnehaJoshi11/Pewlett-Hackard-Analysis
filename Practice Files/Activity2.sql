create table cities(
	id int NOT NULL,
	city varchar(30),
	state varchar(30),
	population int,
	PRIMARY KEY (id)
);

create table city_names(
	city varchar(30)
);

select * from cities;
select * from city_names;


insert into cities(id,city,state,population)
values(1,'Almeda','California',79177),(2,'Mesa','Arizona',496401),
(3,'Boerne','Texas',16056),
(4,'Boerne','Texas',16056),
(5,'Anaheim','Texsa',352497),
(6,'Tucson','Arizona',535677),
(7,'Garland','Texas',238002);

insert into city_names(city)
values('Almeda'),('Mesa'),('Boerne'),('Boerne'),
('Anaheim'),('Tucson'),
('Garland');

delete from city_names where city=('Almeda');
delete from city_names where city=('Boerne');
delete from city_names where city=('Anaheim');
delete from city_names where city=('Tucson');
delete from city_names where city=('Garland');


select * from cities where state='Texas';

select * from cities 
where population > 100000;

select state from cities
where state ='california' and population > 100000;

delete from cities 
where id=4;

select* from cities;
