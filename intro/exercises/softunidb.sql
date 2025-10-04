create table towns (
	id int generated always as identity primary key,
	name varchar(50) not null
);
insert into towns (name) 
values
('sofia'), ('plovdiv'), ('varna'), ('burgas');

create table addresses (
	id int generated always as identity primary key,
	address_text varchar(50) not null,
	town_id int not null references towns(id)
);
insert into addresses (address_text, town_id) 
values
('123 main st', 1),
('456 central blvd', 2),
('789 sea rd', 3),
('101 river ave', 4),
('202 forest ln', 1);


create table departments (
	id int generated always as identity primary key,
	name varchar(50) not null
);
insert into departments (name) 
values
('engineering'), ('sales'), ('marketing'), ('software development'), ('quality assurance');


create table employees (
	id int generated always as identity primary key,
	first_name varchar(50) not null,
	middle_name varchar(50) not null,
	last_name varchar(50) not null,
	job_title varchar(50),
	department_id int not null references departments(id),
	hire_date date default current_date,
	salary decimal(10, 2) not null,
	address_id int not null references addresses(id)	
);
insert into employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id) 
values
('ivan', 'ivanov', 'ivanov', '.net developer', 4, '2013-02-01', 3500.00, 1),
('petar', 'petrov', 'petrov', 'senior engineer', 1, '2004-03-02', 4000.00, 2),
('maria', 'petrova', 'ivanova', 'intern', 5, '2016-08-28', 525.25, 3),
('georgi', 'teziev', 'ivanov', 'ceo', 2, '2007-12-09', 3000.00, 4),
('peter', 'pan', 'pan', 'intern', 3, '2016-08-28', 599.88, 5);


--drop table addresses, departments, employees, towns;

select * from towns;
select * from departments;
select * from employees;

select * from towns 
order by name;
select * from departments
order by name;
select * from employees
order by salary desc;

select name from towns 
order by name;
select name from departments
order by name;
select first_name, salary from employees
order by salary desc;

update employees
set salary = salary * 1.10;

select salary 
from employees 
order by salary desc;