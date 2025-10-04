--car rental database
create table categories (
	id int generated always as identity primary key,
	category_name varchar(50) not null check (char_length(category_name) >= 2),
	daily_rate numeric(6, 2) not null,
	weekly_rate numeric(6, 2) not null,
	monthly_rate numeric(6, 2) not null,
	weekend_rate numeric(6, 2) not null	
);

insert into categories (category_name, daily_rate, weekly_rate, monthly_rate, weekend_rate)
values
('Economy', 29.99, 189.99, 749.99, 59.99),
('SUV', 49.99, 319.99, 1249.99, 89.99),
('Luxury', 89.99, 599.99, 2399.99, 149.99);

create table cars (
	id int generated always as identity primary key,
	plate_number varchar(15) not null unique,
	manufacturer varchar(50) not null,
	model varchar(50) not null,
	car_year int not null  check (car_year > 1990),
	category_id int not null references categories(id),
	doors int not null check (doors between 2 and 5),
	picture bytea,
	condition varchar(50),
	available boolean not null	
);

insert into cars (plate_number, manufacturer, model, car_year, category_id, doors, picture, condition, available) --or "condition" but every where + in declaration.
values
('BG1234AB', 'Toyota', 'Yaris', 2020, 1, 4, 'toyota_yaris.jpg', 'Excellent', true),
('BG5678CD', 'BMW', 'X5', 2022, 2, 5, 'bmw_x5.jpg', 'Good', true),
('BG9012EF', 'Mercedes', 'S-Class', 2021, 3, 4, 'mercedes_sclass.jpg', 'Excellent', false);


create table employees(
	id int generated always as identity primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	title varchar(50),
	notes text
);

insert into employees (first_name, last_name, title, notes) 
values
('alice', 'johnson', 'manager', 'experienced in fleet management'),
('bob', 'smith', 'agent', 'part-time employee'),
('carol', 'davis', 'agent', null);

create table customers (
	id int generated always as identity primary key,
	driver_licence_number varchar(50) not null,
	full_name varchar(100) not null,
	address varchar(100),
	city varchar(20) not null,
	zip_code varchar(10),
	notes text	
);

insert into customers(driver_licence_number, full_name, address, city, zip_code, notes)
values
('d1234567', 'john doe', '123 elm st', 'springfield', '12345', null),
('d7654321', 'jane roe', '456 oak st', 'shelbyville', '54321', 'vip customer'),
('d1122334', 'mike miles', '789 pine st', 'capital city', '67890', null);


create table rental_orders (
	id int generated always as identity primary key,
	employee_id int not null references employees(id),
	customer_id int not null references customers(id),
	car_id int not null references cars(id),
	tank_level decimal(5, 2),
	kilometrage_start int,
    kilometrage_end int,
    total_kilometrage int,
    start_date date not null,
    end_date date,
    total_days int,
    rate_applied decimal(8,2),
    tax_rate decimal(5,2),
    order_status varchar(50),
    notes text
);

insert into rental_orders (employee_id, customer_id, car_id, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
values
(1, 1, 1, 75.00, 10000, 10200, 200, '2025-10-01', '2025-10-03', 2, 30.00, 10.00, 'completed', 'no issues'),
(2, 2, 2, 50.00, 5000, 5200, 200, '2025-10-02', '2025-10-05', 3, 60.00, 10.00, 'completed', 'returned early'),
(3, 3, 3, 90.00, 8000, null, null, '2025-10-04', null, null, 100.00, 10.00, 'ongoing', 'customer extended rental');
select * from rental_orders;



