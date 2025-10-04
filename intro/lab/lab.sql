create table clients (
	id int generated always as identity primary key,
	firstName varchar(50) not null,
	lastName varchar(50) not null 
);

create table account_types (
	id int generated always as identity primary key,
	name varchar(50) not null 
);

create table accounts (
	id int generated always as identity primary key,
	account_type_id int references account_types(id),
	balance decimal(15, 2) default 0,
	client_id int references clients(id)	
);

insert into clients (firstname, lastname)
values
('Gosho', 'Ivanov'),
('Pesho', 'Petrov'),
('Ivan', 'Iliev'),
('Merry', 'Ivanova');

insert into account_types(name)
values
('Checking'),
('Savings');

insert into accounts(client_id, account_type_id, balance)
values
(1, 1, 175),
(2, 1, 275.56),
(3, 1, 138.01),
(4, 1, 40.30),
(4, 2, 375.50);

create or replace function f_calculate_total_balance (client_id_prop int)
returns numeric(15, 2) as $$
declare 
	result numeric(15, 2);
begin
	select sum(balance)
	into result
	from accounts
	where client_id = client_id_prop;
	return result;
end
$$ language plpgsql;

select f_calculate_total_balance(4) as balance;


create or replace procedure p_add_account (p_client_id INT, p_account_type_id INT )
language plpgsql
as $$
begin
	insert into accounts (client_id, account_type_id)
	values 
	(p_client_id, p_account_type_id);
end
$$;

call p_add_account (2, 2);

select * from accounts;

create ar replace procedure p_deposit (account_id int, amount decimal(15, 2))
language plpgsql
as $$
begin
	update accounts
	set balance = balance + amount
	where id = account_id;
end
$$

call public.p_deposit(8, 500.00);

create or replace procedure p_withdraw (account_id int, amount decimal(15, 2))
language plpgsql
as $$
declare 
	old_balance decimal(15, 2);
begin
	 select balance into old_balance from accounts where id = account_id;
	if old_balance - amount >= 0 then
		update Accounts
		set balance = balance - amount
		where id = account_id;
	
	else
		raise exception 'Insufficient funds';
	end if;
end
$$

call public.p_withdraw(8, 100.00);

create table Transactions (
	id int generated always as identity primary key,
	account_id int references Accounts(id),
	old_balance numeric(15,2) not null,
	new_balance numeric(15,2) not null,
	amount numeric(15,2) generated always as (new_balance - old_balance) stored,
	datetime timestamp not null default current_timestamp
);

create or replace function f_tr_transaction()
returns trigger 
language plpgsql
as $$
begin
    insert into transactions (account_id, old_balance, new_balance, datetime)
    values (new.id, old.balance, new.balance, NOW());
    return new;
end;
$$;

create trigger tr_transaction
after update of balance on accounts
for each row
when (old.balance is distinct from new.balance)
execute function f_tr_transaction();

update accounts
set balance = balance + 100
where id = 1;

select * from transactions;
