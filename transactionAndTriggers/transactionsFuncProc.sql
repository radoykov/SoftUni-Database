--1
create or replace function f_getemployees_salary_above_35000()
returns table (
    first_name varchar,
    last_name varchar
)
language plpgsql
as $$
begin
    return QUERY
    select employees.first_name, employees.last_name
    from employees
    where salary > 35000;
end;
$$;

select * from f_getemployees_salary_above_35000();

--2
create or replace function f_getemployees_salary_above_number(num decimal(18, 4))
returns table (
    first_name varchar,
    last_name varchar
)
language plpgsql
as $$
begin
	if num < 0 then
		raise exception 'Error must be non positive number';
	end if;

    return query
    select employees.first_name, employees.last_name
    from employees
    where salary > num;
end;
$$;

select * from f_getemployees_salary_above_number(48100);

--3
create or replace function f_get_towns_starting_with (str varchar)
returns table (
    town_name varchar
)
language plpgsql
as $$
begin

    return query
    select name
    from towns
    where name ilike str || '%';
end;
$$;

select * from f_get_towns_starting_with ('b');

--4
create or replace function f_get_employees_from_town (town_name varchar)
returns table (
    first_name varchar,
    last_name varchar
)
language plpgsql
as $$
begin

    return query
    select e.first_name, e.last_name 
	from towns t 
	join addresses a on t.town_id = a.town_id 
	join employees e on a.address_id = e.address_id 
	where t."name" = town_name;
end;
$$;

select * from f_get_employees_from_town ('Sofia');

--5
create or replace function f_get_salary_level(salary decimal(18,4))
returns text
language plpgsql
as $$
begin
	return case
		when salary < 30000 then 'Low'
		when salary between 30000 and 50000 then 'Average'
		when salary > 50000 then 'High'
	end;
end;
$$;

select * from f_get_salary_level(13500.00);
select * from f_get_salary_level(43300.00);
select * from f_get_salary_level(125500.00);

--6
create or replace function f_employees_by_salary_level(level varchar)
returns table (
	first_name varchar,
	last_name varchar
)
language plpgsql
as $$
begin
	return query
	select e.first_name, e.last_name
	from employees e
	where f_get_salary_level(e.salary) = level;
end;
$$;

select * from f_employees_by_salary_level('High');

--7
create or replace function f_is_word_comprised(setOfLetters text, word text)
returns boolean 
language plpgsql
as $$
declare 
    idx int := 1;
    currChar char(1);
begin
    while idx <= length(word) loop
        currChar := lower(substring(word, idx, 1));

        if position(currChar in lower(setOfLetters)) = 0 then
            return false;
        end if;

        idx := idx + 1;
    end loop;

    return true;
end;
$$;

select f_is_word_comprised('oistmiahf', 'Sofia');
select f_is_word_comprised('oistmiahf', 'halves'); 
select f_is_word_comprised('bobr', 'Rob');
select f_is_word_comprised('pppp', 'Guy'); 

--8
CREATE OR REPLACE PROCEDURE p_delete_employees_from_department(department_id_p INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1. Delete all employees in that department
    DELETE FROM Employees
    WHERE department_id = department_id_p;

    -- 2. Delete the department itself
    DELETE FROM Departments
    WHERE department_id = department_id_p;

    -- 3. Show remaining employees
    RAISE NOTICE 'Remaining employees in department %: %',
        department_id_p,
        (SELECT COUNT(*) FROM Employees WHERE department_id = department_id_p);
END;
$$;

call p_delete_employees_from_department(5);

--9
create or replace function f_get_holders_full_name()
returns table(
	full_name text
)
language plpgsql
as $$
begin
    return query
	select a.first_name || ' ' || a.last_name as fullname
	from accountholders a;
end;
$$;
select * from f_get_holders_full_name();

--10
create or replace function f_get_holders_with_balance_higher_than(num int)
returns table(
	first_name varchar,
	last_name varchar
)
language plpgsql
as $$
begin
    return query
	select ah.first_name, ah.last_name
	from accountholders ah
	join accounts a on ah.id = a.account_holder_id 
	group by a.id, ah.first_name, ah.last_name
	having sum(a.balance) > num
	order by sum(a.balance) desc;
end;
$$;
select * from f_get_holders_with_balance_higher_than (12000);

--11
create or replace function f_calculate_future_value (
    initial_sum decimal,
    yearly_interest_rate float,
    years int
)
returns decimal(20,4) as $$
declare
    future_value decimal(20,4);
begin
      future_value := round(cast(initial_sum * power(1 + yearly_interest_rate, years) as numeric),
        4
    );
    return future_value;
end;
$$ language plpgsql;

select f_calculate_future_value(1000, 0.1, 5);

--12
create or replace function f_calculate_future_value_for_account(
  p_account_id int,
  p_interest_rate float
)
returns table (
	id int,
  first_name varchar(50),
  last_name varchar(50),
  balance decimal(13,2),
  future_value decimal(20,4)
) as $$
begin
  return query
  select 
    a.id,
    ah.first_name,
    ah.last_name,
    sum(a.balance),
    f_calculate_future_value(sum(a.balance), p_interest_rate, 5)
  from accounts a
  join accountholders ah on a.account_holder_id = ah.id
  where a.id = p_account_id
  group by a.id, ah.first_name, ah.last_name;
 
end;
$$ language plpgsql;

select * from f_calculate_future_value_for_account(1, 0.1);

--13
create or replace function  f_cash_in_users_games (p_game_name TEXT)
returns table(sum_cash money) as $$
begin
  return query
  select sum(cash) as sum_cash
  from (
     select ug.cash,
           row_number() over (order by ug.cash desc) as row_num
    from usersgames ug
    join games g on ug.game_id = g.id
    where g.name = p_game_name
  ) ranked
  where row_num % 2 = 1;
end;
$$ language plpgsql;

select * from f_cash_in_users_games('Paris');
select * from f_cash_in_users_games('Fuzzy Wuzzy');

--14
create table logs (
  log_id serial primary key,
  account_id int,
  old_sum numeric(13,2),
  new_sum numeric(13,2)
);
create or replace function log_account_balance_change()
returns trigger as $$
begin
  if new.balance is distinct from old.balance then
    insert into logs (account_id, old_sum, new_sum)
    values (old.id, old.balance, new.balance);
  end if;
  return new;
end;
$$ language plpgsql;

create trigger trg_log_balance_change
after update on accounts
for each row
execute function log_account_balance_change();

update accounts
set balance = 450.00
where id = 2;

select * from logs;

--15
create table notificationemails (
  id SERIAL primary key,
  recipient int not null,
  subject text not null,
  body text not null
);
create or replace function notify_balance_change()
returns trigger as $$
begin
  insert into notificationemails (recipient, subject, body)
  values (
    new.account_id,
    'Balance change for account: ' || new.account_id,
    'On ' || to_char(now(), 'Mon DD YYYY HH12:MIAM') ||
    ' your balance was changed from ' || new.old_sum || ' to ' || new.new_sum || '.'
  );
  return new;
end;
$$ language plpgsql;

create trigger trg_notify_balance_change
after insert on logs
for each row
execute function notify_balance_change();

insert into logs(log_id, account_id, old_sum, new_sum)
values 
(5, 2, 200, 5502);
select * from notificationemails;

--16
create or replace procedure p_deposit_money(p_account_id int, p_money_amount numeric(20,4))
language plpgsql
as $$
begin
  if p_money_amount <= 0 then
    raise exception 'Deposit amount must be positive.';
    -- This automatically triggers a rollback of the transaction
  end if;

  update accounts
  set balance = round(balance + p_money_amount, 4)
  where id = p_account_id;

  if not found then
    raise exception 'Account with ID % does not exist.', p_account_id;
    -- This also triggers rollback
  end if;
end;
$$;
select * from accounts a order by a.id ;
begin;
call p_deposit_money(15, 1000.00);
commit;
select * from accounts a order by a.id ;

--17
create or replace procedure p_withdraw_money(p_account_id int, p_money_amount numeric(20,4))
language plpgsql
as $$
declare 
	current_balance numeric(20,4);
begin
  if p_money_amount <= 0 then
    raise exception 'Withdraw amount must be positive.';
  end if;

  select a.balance into current_balance
  from accounts a
  where id = p_account_id;

	if current_balance is null then
		raise exception 'Null balance';
	end if;

  if current_balance < p_money_amount then
    raise exception 'Withdraw amount not enough.';
  end if;

  update accounts
  set balance = round(balance - p_money_amount, 4)
  where id = p_account_id;

  if not found then
    raise exception 'Account with ID % does not exist.', p_account_id;
  end if;
end;
$$;
select * from accounts a order by a.id ;
begin;
call p_withdraw_money(15, 1000.00);
commit;
select * from accounts a order by a.id ;

--18
create or replace procedure p_transfer_money(p_account_id_sender int, p_money_amount numeric(20,4), p_account_id_receiver int)
language plpgsql
as $$
begin
  if p_money_amount <= 0 then
    raise exception 'Transfer amount must be positive.';
  end if;

	call p_withdraw_money(p_account_id_sender, p_money_amount);
  	call p_deposit_money(p_account_id_receiver, p_money_amount);
end;
$$;
select * from accounts a order by a.id ;
begin;
call p_transfer_money(13, 100.00, 2);
commit;
select * from accounts a order by a.id ;

--19
create or replace function check_item_level()
returns trigger as $$
declare
  user_level int;
  item_level int;
begin
  select level into user_level from users where id = new.user_id;
  select required_level into item_level from items where id = new.item_id;

  if user_level < item_level then
    raise exception 'User level too low to purchase item %', new.item_id;
  end if;

  return new;
end;
$$ language plpgsql;

create trigger trg_check_item_level
before insert on items
for each row
execute function check_item_level();
--
update usersgames ug
set cash = ug.cash + '50000'
from users u, games g
where ug.user_id = u.id
  and ug.game_id = g.id
  and u.username in ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
  and g.name = 'Bali';
--
create table user_items (
  	user_id int references users(id),
	item_id int references items(id)
);

with selected_items as (
  select id, price
  from items
  where id between 251 and 299 or id between 501 and 539
),
target_users as (
  select ug.user_id
  from users u
  join usersgames ug on u.id = ug.user_id
  join games g on ug.game_id = g.id
  where u.username in ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
    and g.name = 'Bali'
)
insert into user_items (user_id, item_id)
select tu.user_id, si.id
from target_users tu, selected_items si;

update usersgames ug
set cash = ug.cash - sub.total_price
from (
  select ug.user_id, sum(i.price) as total_price
  from usersgames ug
  join users u on u.id = ug.user_id
  join games g on g.id = ug.game_id
  join items i on i.id between 251 and 299 or i.id between 501 and 539
  where u.username in ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
    and g.name = 'Bali'
  group by ug.user_id
) sub
where ug.user_id = sub.user_id
and ug.cash >= sub.total_price;
--
select 
  u.username as "Username",
  g.name as "Name",
  ug.cash as "Cash",
  i.name as "Item Name"
from 
  users u
join 
  usersgames ug on u.id = ug.user_id
join 
  games g on ug.game_id = g.id
join 
  user_items ui on u.id = ui.user_id
join 
  items i on ui.item_id = i.id
where 
  g.name = 'Bali'
order by 
  u.username asc,
  i.name asc;

--20
do $$
declare
  v_user_id int;
  v_game_id int;
  v_user_cash numeric;
  v_total_cost numeric;
begin
  select ug.user_id, ug.game_id, ug.cash::numeric
  into v_user_id, v_game_id, v_user_cash
  from users u
  join usersgames ug on u.id = ug.user_id
  join games g on ug.game_id = g.id
  where u.username = 'stamat' and g.name = 'safflower';

  select sum(price)::numeric
  into v_total_cost
  from items
  where min_level between 11 and 12;

  if v_user_cash < v_total_cost then
    raise exception 'insufficient funds for level 11–12 items';
  end if;

  update usersgames ug
  set cash = (ug.cash::numeric - v_total_cost)::money
  where ug.user_id = v_user_id and ug.game_id = v_game_id;

  insert into user_items (user_id, item_id)
  select v_user_id, id
  from items
  where min_level between 11 and 12;

exception
  when others then
    raise notice 'transaction failed: %', sqlerrm;
    rollback;
end $$;
do $$
declare
  v_user_id int;
  v_game_id int;
  v_user_cash numeric;
  v_total_cost numeric;
begin
  select ug.user_id, ug.game_id, ug.cash::numeric
  into v_user_id, v_game_id, v_user_cash
  from users u
  join usersgames ug on u.id = ug.user_id
  join games g on ug.game_id = g.id
  where u.username = 'stamat' and g.name = 'safflower';

  select sum(price)::numeric
  into v_total_cost
  from items
  where min_level between 19 and 21;

  if v_user_cash < v_total_cost then
    raise exception 'insufficient funds for level 19–21 items';
  end if;

  update usersgames ug
  set cash = (ug.cash::numeric - v_total_cost)::money
  where ug.user_id = v_user_id and ug.game_id = v_game_id;

  insert into user_items (user_id, item_id)
  select v_user_id, id
  from items
  where min_level between 19 and 21;

exception
  when others then
    raise notice 'transaction failed: %', sqlerrm;
    rollback;
end $$;
select i.name as item_name
from users u
join usersgames ug on u.id = ug.user_id
join games g on ug.game_id = g.id
join user_items ui on u.id = ui.user_id
join items i on ui.item_id = i.id
--where u.username = 'stamat' and g.name = 'safflower'
group by item_name
order by i.name asc;

--21
create procedure p_assign_project(
    p_employee_id int,
    p_project_id int
)
language plpgsql
as $$
declare
    v_project_count int;
begin
    -- Count current projects
    select count(*)
    into v_project_count
    from employees_projects
    where employee_id = p_employee_id;

    -- Check if limit exceeded
    if v_project_count >= 3 then
        raise exception 'The employee has too many projects!';
    end if;

    -- Assign project
    insert into employees_projects (employee_id, project_id)
    values (p_employee_id, p_project_id);
end;
$$;

begin;
call p_assign_project(1, 2);
commit;

--22
create table deleted_employees (
    employee_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    middle_name varchar(50),
    job_title varchar(100),
    department_id int,
    salary numeric(15,2)
);
create or replace function log_deleted_employee()
returns trigger as $$
begin
    insert into deleted_employees (
        employee_id,
        first_name,
        last_name,
        middle_name,
        job_title,
        department_id,
        salary
    )
    values (
        old.employee_id,
        old.first_name,
        old.last_name,
        old.middle_name,
        old.job_title,
        old.department_id,
        old.salary
    );

    return old;
end;
$$ language plpgsql;
create trigger trg_log_deleted_employee
after delete on employees
for each row
execute function log_deleted_employee();

delete from employees where employee_id = 101;
