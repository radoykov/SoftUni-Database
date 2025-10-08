--1
create table passports (
    passport_id serial primary key,
    passport_number varchar(20) not null
);

insert into passports (passport_id, passport_number) 
values
(101, 'n34fg21b'),
(102, 'k65lo4r7'),
(103, 'ze657qp2');


create table persons (
    person_id serial primary key,
    first_name varchar(50) not null,
    salary numeric(10,2),
    passport_id int unique references passports(passport_id)
);

insert into persons (person_id, first_name, salary, passport_id) 
values
(1, 'roberto', 43300.00, 102),
(2, 'tom', 56100.00, 103),
(3, 'yana', 60200.00, 101);

select * from passports;
select * from persons;

--2
create table manufacturers (
    manufacturer_id serial primary key,
    name varchar(50) not null,
    established_on date
);

insert into manufacturers (manufacturer_id, name, established_on)
values
(1, 'bmw', '1916-03-07'),
(2, 'tesla', '2003-01-01'),
(3, 'lada', '1966-05-01');


create table models (
    model_id serial primary key,
    name varchar(50) not null,
    manufacturer_id int references manufacturers(manufacturer_id)
);

insert into models (model_id, name, manufacturer_id) 
values
(101, 'x1', 1),
(102, 'i6', 1),
(103, 'model_s', 2),
(104, 'model_x', 2),
(105, 'model_3', 2),
(106, 'nova', 3);

--3
create table students (
    id serial primary key,
    name varchar(50) not null
);

insert into students (id, name) values
(1, 'mila'),
(2, 'toni'),
(3, 'ron');

create table exams (
    id serial primary key,
    name varchar(50) not null
);

insert into exams (id, name) values
(101, 'springmvc'),
(102, 'neo4j'),
(103, 'oracle_11g');

create table students_exams (
    student_id int references students(id),
    exam_id int references exams(id)
);

insert into students_exams (student_id, exam_id) values
(1, 101),
(1, 102),
(2, 101),
(2, 102),
(2, 103),
(3, 103);

--4
create table teachers (
    teacher_id serial primary key,
    name varchar(50) not null,
    manager_id int references teachers(teacher_id)
);

insert into teachers (teacher_id, name, manager_id) values
(101, 'john', null),
(102, 'maya', 106),
(103, 'silvia', 106),
(104, 'ted', 105),
(105, 'mark', 101),
(106, 'greta', 101);

--5
create table cities (
    city_id serial primary key,
    name varchar(50)
);

create table customers (
    customer_id serial primary key,
    name varchar(50),
    birthday date,
    city_id int references cities(city_id)
);

create table orders (
    order_id serial primary key,
    customer_id int references customers(customer_id)
);

create table item_types (
    item_type_id serial primary key,
    name varchar(50)
);

create table items (
    item_id serial primary key,
    name varchar(50),
    item_type_id int references item_types(item_type_id)
);

create table order_items (
    order_id int references orders(order_id),
    item_id int references items(item_id),
    primary key (order_id, item_id)
);

--6
create table majors (
    major_id serial primary key,
    name varchar(50)
);

create table students (
    student_id serial primary key,
    student_number varchar(20),
    student_name varchar(50),
    major_id int references majors(major_id)
);

create table subjects (
    subject_id serial primary key,
    subject_name varchar(50)
);

create table agenda (
    student_id int references students(student_id),
    subject_id int references subjects(subject_id),
    primary key (student_id, subject_id)
);

create table payments (
    payment_id serial primary key,
    payment_date date,
    payment_amount numeric(10,2),
    student_id int references students(student_id)
);

--7
select m.mountain_range , p.peak_name , p.elevation  
from peaks p
join mountains m on m.id = p.mountain_id
where m.mountain_range = 'Rila'
order by p.elevation desc;