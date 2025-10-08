--1
select count(*) as count
from wizzarddeposits;

--2
select max(magic_wand_size) as longest_wand 
from wizzarddeposits;

--3
select deposit_group, max(magic_wand_size) as longest_wand 
from wizzarddeposits
group by deposit_group;

--4
select deposit_group 
from wizzarddeposits
group by deposit_group
order by avg(magic_wand_size) asc
limit 2;

--5
select deposit_group, sum(deposit_amount) as total_sum
from wizzarddeposits
group by deposit_group;

--6
select deposit_group, sum(deposit_amount) as total_sum
from wizzarddeposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group;

--7
select deposit_group, sum(deposit_amount) as total_sum
from wizzarddeposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
having sum(deposit_amount) < 150000
order by total_sum desc;

--8
select deposit_group, magic_wand_creator, min(deposit_charge) as deposit_charge
from wizzarddeposits
group by deposit_group, magic_wand_creator
order by magic_wand_creator, deposit_group;

--9
select 
	case
		when age between 0 and 10 then '[0-10]'
		when age between 11 and 20 then '[11-20]'
		when age between 21 and 30 then '[21-30]'
		when age between 31 and 40 then '[31-40]'
		when age between 41 and 50 then '[41-50]'
		when age between 51 and 60 then '[51-60]'
		when age >= 61 then '[61+]'	
	end as age_group, count(age) as wizard_count
from wizzarddeposits
group by age_group 
order by age_group;

--10
select left(first_name, 1) as first_letter
from wizzarddeposits
where deposit_group = 'Troll Chest'
group by first_letter
order by first_letter;

--11
select deposit_group, is_deposit_expired, avg(deposit_interest) as average_interest
from wizzarddeposits
where deposit_start_date > '01/01/1985'
group by deposit_group, is_deposit_expired
order by deposit_group desc, is_deposit_expired asc;

--12
select sum(e.difference) as total_sum	from (
select deposit_amount - lead(deposit_amount) over (order by id) as difference
from wizzarddeposits) as e;

--13
select department_id, sum(salary) as total_salary
from employees
group by department_id
order by department_id;

--14
select department_id, min(salary) as min_salary
from employees
where department_id in (2, 5, 7) and hire_date > '01/01/2000'
group by department_id
order by department_id;

--15
drop table high_salaries;
create table high_salaries as 
select * 
from employees
where salary > 30000;

select * from high_salaries where department_id = 1;
select * from high_salaries;

delete from high_salaries
where manager_id = 42;

update high_salaries
set salary = salary + 5000
where department_id = 1;

select department_id, avg(salary) as avg_salary
from high_salaries
group by department_id
order by department_id ;

--16
select department_id, max(salary) as max_salary
from employees
where salary not in (30000, 70000)
group by department_id
order by max_salary desc;

--17
select count(*) as count
from employees
where manager_id is null;

--18
select distinct department_id, salary as third_highest_salary
from (
    select 
        department_id,
        salary,
        dense_rank() over (partition by department_id order by salary desc) as rank
    from employees
) as ranked
where rank = 3;

--19
select first_name, last_name, department_id 
from employees
where salary > (
		select avg(salary)
		from employees e
		where department_id = e.department_id
)
order by department_id
limit 10;