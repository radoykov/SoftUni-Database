create table towns (
	id int primary key,
	name varchar(50)
);

create table minions (
	id int primary key,
	name varchar(50),
	age int,
	town_id int references towns(id)
);

insert into towns (id, name)
values
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

insert into minions (id, "name", age, town_id) 
values 
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 2),
(3, 'Steward', NULL, 3);

truncate table minions;
drop table minions;
select * from minions;

create table people (
	id int generated always as identity primary key,
	name varchar(200) not null,
	picture bytea,
	height decimal(15, 2), -- in meters
	weight decimal(15, 2), -- in kilograms
	gender varchar(1) not null check (gender in ('m', 'f')) ,
	birthdate timestamp not null,
	biography text not null
);

insert into people (name, height, weight, gender, birthdate, biography)
values
('Pesho', 180, 90, 'm', '1992-04-15 08:30:00', 'His name is Pesho!'),
('Alexa', 185, 80, 'f', '1985-04-15 08:30:00', 'Her name is Alexa!'),
('Steward', 50, 30, 'm', '2000-04-15 08:30:00', 'Rock and roll!'),
('Bob', 30, 20, 'm', '1890-04-15 08:30:00', 'His name is Bob!'),
('Kevin', 42, 27, 'm', '2025-04-15 08:30:00', 'Do it Kevin!')

select * from people;

create table users (
	id int generated always as identity,
	username varchar(30) not null unique check (char_length(username) >= 3),
	password varchar(26) not null check (char_length(password) >= 5),
	profile_picture bytea,
	last_login_time timestamp default current_timestamp,
	is_deleted boolean default false,
	primary key (id, username)
);
drop table users;

insert into users (username, password)
values
('Pesho', '111111'),
('Alex', '1234567'),
('Steward', 'banana1'),
('Bob', 'banana2'),
('Kevin', 'banana3')

select * from users;
insert into users (username, password, is_deleted)
values ('Poloo', 'Panda', true)

--or this way
alter table users
drop constraint users_pkey;
alter table users
add primary key (id, username);--(id)

alter table users
add constraint chk_password_length check (char_length(password) >= 5);

alter table users
alter column last_login_time set default current_timestamp;

alter table users
drop constraint users_pkey;
alter table users
add primary key (id);
alter table users
add constraint uq_username unique (username);
alter table users
add constraint chk_username_length check (char_length(username) >= 3);
