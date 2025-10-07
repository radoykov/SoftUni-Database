--2
select *
from departments;

--3
select name 
from departments;

--4
select first_name, last_name, salary
from employees;

--5
select  
  first_name || ' ' || coalesce(middle_name || ' ', '') || last_name as "full name"
from employees;

--6
select first_name || '.' || last_name || '@softuni.bg' 
from employees;

--7
select distinct salary
from employees;

--8
select *
from employees
where job_title = 'Sales Representative';

--9
select first_name, last_name, job_title
from employees
where salary between 20000 and 30000;

--10
select first_name || ' ' || coalesce(middle_name || ' ', '') || last_name as "Full name"
from employees
where salary in (25000, 14000, 12500, 23600);

--11
select first_name, last_name
from employees
where manager_id is null;

--12
select first_name, last_name, salary
from employees
where salary > 50000
order by salary desc;

--13
select first_name, last_name, salary
from employees
order by salary desc
limit 5;

--14
select first_name, last_name
from employees
where department_id != 4;

--15
select *
from employees
order by salary desc, first_name, last_name desc, middle_name ; 

--16
create view v_employees_salaries as (
	select first_name, last_name, salary
	from employees
);
--drop view v_employees_salaries;
select * from v_employees_salaries;

--17
create view v_employee_name_job_title as (
	select (first_name || ' ' || coalesce(middle_name || ' ', '') || last_name) as "Full name", job_title
	from employees
);
--drop view v_employee_name_job_title;
select * from v_employee_name_job_title; 

--18
select distinct job_title
from employees
order by job_title ;

--19
select *
from projects
order by start_date, name
limit 10;

--20
select 
e.first_name, e.last_name, p.start_date
from employeesprojects ep
join employees e on ep.employee_id = e.employee_id 
join projects p on ep.project_id = p.project_id;

select first_name, last_name, hire_date
from employees
order by hire_date desc, first_name desc , last_name desc
limit 7;

--21
select e.salary * 1.12  as new_salary
from employees e
join departments d on e.department_id = d.department_id
where name in ('Engineering', 'Tool Design', 'Marketing', 'Information Services', 'Production')
order by new_salary;

--22
select peak_name 
from peaks
order by peak_name;

--23
select country_name, population
from countries
order by population desc, country_name
limit 30;

--24
select country_name, country_code, currency_code as currency
from countries
where currency_code in ('EUR', 'NOT EUR')
order by country_name;

--25
select name
from characters
order by name;