create database Cinema

use Cinema

create table sessionss(id int primary key identity,Start_Time nvarchar(50) unique not null,End_Time nvarchar(50) unique not null);
create table tickers (id int primary key identity,Code nvarchar(50) unique not null, SessionsID int foreign key references sessionss(id));
alter table tickers
--drop constraint FK__tickers__Session__3C69FB99
drop column SessionsID
create table customers(id int primary key identity,FullName nvarchar(50) not null,TickersID int foreign key references tickers(id));
create table halls (id int primary key identity,Name nvarchar(50) unique not null,SessionsID int foreign key references sessionss(id));
alter table halls
--drop constraint FK__halls__SessionsI__4316F928
drop column SessionsID
create table actors(id int primary key identity ,FullName nvarchar(50) unique not null);
create table genres(id int primary key identity,Name nvarchar(50) unique not null);
create table movies(id int primary key identity,Name nvarchar(50) unique not null,
GenreID int foreign key references genres(id),
HallsID int foreign key references halls(id),
ActorsID int foreign key references actors(id));


alter table movies
--drop constraint FK__movies__HallsID__534D60F1
drop column HallsID

create table MoviesActors(id int primary key identity,MoviesID int foreign key references movies(id),ActorsID int foreign key references actors(id));
create table HallsSessionsTickers(id int primary key identity,
HallsID int foreign key references halls(id),
SessionsID int foreign key references sessionss(id),
TickersID int foreign key references tickers(id)
);
alter table HallsSessionsTickers
add MoviesID int foreign key references movies(id)

select * from actors select * from genres select * from halls select * from HallsSessionsTickers select * from movies
select * from MoviesActors select * from sessionss select * from tickers


create view backupp
as
select customers.FullName 'Musteri',tickers.Code 'Bilet kodu',sessionss.Start_Time 'Baslama',sessionss.End_Time 'Bitme',halls.Name 'Zal Adi',movies.Name 'Film Adi',genres.Name 'Janr',actors.FullName 'Oyuncular' from customers
join tickers
on customers.TickersID=tickers.id
join HallsSessionsTickers
on tickers.id=HallsSessionsTickers.TickersID
join sessionss
on sessionss.id = HallsSessionsTickers.SessionsID
join halls
on halls.id=HallsSessionsTickers.HallsID
join movies
on movies.id=HallsSessionsTickers.MoviesID
join genres
on genres.id=movies.GenreID
join MoviesActors
on movies.id=MoviesActors.MoviesID
join actors
on MoviesActors.ActorsID=actors.id

select * from backupp