--hotel database

create table employees (
	id int generated always as identity primary key,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	title varchar(30),
	notes text	
);
insert into employees (first_name, last_name, title, notes) 
values
('Alice', 'Brown', 'Manager', 'Oversees operations'),
('Bob', 'Smith', 'Receptionist', 'Handles check-ins'),
('Carol', 'Jones', 'Housekeeping', null);


create table customers (
	account_number int primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	phone_number varchar(20),
	emergency_name varchar(50),
	emergency_number varchar(20), 
	notes text	
);
insert into customers (account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)
values
(1, 'John', 'Doe', '555-1234', 'Jane Doe', '555-5678', null),
(2, 'Emily', 'Stone', '555-2345', 'Mark Stone', '555-6789', 'VIP guest'),
(3, 'Mike', 'Miles', '555-3456', null, null, null);

create table room_status (
	room_status varchar(20) primary key,
	notes text
);
insert into room_status (room_status, notes) 
values
('available', 'Ready for check-in'),
('occupied', 'Currently in use'),
('maintenance', 'Under repair');

create table room_types (
	room_type varchar(20) primary key,
	notes text
);
insert into room_types (room_type, notes)
values
('single', 'One bed'),
('double', 'Two beds'),
('suite', 'Luxury suite');

create table bed_types (
	bed_type varchar(20) primary key,
	notes text
);
insert into bed_types
values
('twin', 'Two single beds'),
('queen', 'One queen bed'),
('king', 'One king bed');

create table rooms (
	room_number int primary key,
	room_type varchar(20) not null references room_types(room_type),
	bed_type varchar(20) not null  references bed_types(bed_type),
	rate decimal(6, 3),
	room_status varchar(20) not null  references room_status(room_status),
	notes text
);
insert into rooms (room_number, room_type, bed_type, rate, room_status, notes)
values
(101, 'single', 'queen', 100.00, 'available', null),
(102, 'double', 'twin', 150.00, 'occupied', 'Sea view'),
(103, 'suite', 'king', 300.00, 'maintenance', 'Jacuzzi included');


create table payments (
	id int generated always as identity primary key,
	employee_id int not null references employees(id),
	payment_date date not null,
	account_number int not null references customers(account_number),
	first_date_occupied date,
    last_date_occupied date,
    total_days int,
    amount_charged decimal(10,2),
    tax_rate decimal(5,2),
    tax_amount decimal(10,2),
    payment_total decimal(10,2),
    notes text
);
insert into payments (employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)
values
(1, '2025-10-01', 1, '2025-09-28', '2025-10-01', 3, 300.00, 10.00, 30.00, 330.00, 'Paid in full'),
(2, '2025-10-02', 2, '2025-09-30', '2025-10-02', 2, 400.00, 10.00, 40.00, 440.00, 'Late checkout'),
(3, '2025-10-03', 3, '2025-10-01', '2025-10-03', 2, 600.00, 10.00, 60.00, 660.00, null);

create table occupancies (
	id int generated always as identity primary key,
	employee_id int not null references employees(id),
	date_occupied date not null,
	account_number int not null references customers(account_number),
	room_number int not null references rooms(room_number),
	rate_applied decimal(6, 3),
	phone_charge decimal(6, 3),
	notes text
);

insert into occupancies (Employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes) 
values
(1, '2025-09-28', 1, 101, 100.00, 5.00, 'Guest requested extra towels'),
(2, '2025-09-30', 2, 102, 150.00, 0.00, 'No phone usage'),
(3, '2025-10-01', 3, 103, 300.00, 12.50, 'Used room service and spa');

select * from occupancies;


update payments
set tax_rate = tax_rate - 3;

select tax_rate from payments;
delete from occupancies;--deletes the content of occupancies
