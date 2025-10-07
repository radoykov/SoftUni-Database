--1
select first_name, last_name
from employees
where first_name like 'Sa%';

--2
select first_name, last_name
from employees addresses
where last_name like '%ei%';

--3
select first_name
from employees
where department_id in (3, 10)
	and extract(year from hire_date) between 1995 and 2005;

--4
select first_name, last_name
from employees
where job_title not like '%engineer%';

--5
select name
from towns
where length(name) = 5 or length(name) = 6
order by name;

--6
select town_id, name
from towns
--where name similar to '(M|K|B|E)%'
where left(name, 1) in ('M', 'K', 'B', 'E')
order by name;

--7
select town_id, name
from towns
where  left(name, 1) not in ('R', 'B', 'D')
order by name;

--8
create view v_employees_hired_after_2000 as (
	select first_name, last_name
	from employees
	where extract (year from hire_date) > 2000
);
select * from v_employees_hired_after_2000;

--9
select first_name, last_name
from employees
where length(last_name) = 5;

--10
select country_name, iso_code
from countries
where length(lower(country_name))- length(replace(lower(country_name), 'a', '')) >= 3
order by iso_code;

--11
select peak_name, river_name, lower(concat(left(peak_name, length(peak_name) - 1), river_name)) as mix
from peaks, rivers
where lower(right(peak_name, 1)) = lower(left(river_name, 1))
order by mix;

--12
select name, start
from games
where extract (year from start) in (2011, 2012)
order by start, name
limit 50;

--13
select username, split_part(email, '@', 2) AS "Email Provider"
from users
order by "Email Provider", username;

--14
select username, ip_address
from users
where ip_address like '___.1%.%.___'
order by username;

--15
select name, 
case 
	when extract(hour from start) >= 0 and extract(hour from start) < 12 then 'Morning'
	when extract(hour from start) >= 12 and extract(hour from start) < 18 then 'Afternoon'
	when extract(hour from start) >= 18 and extract(hour from start) < 24 then 'Evening'
end as "Part of the day",
case
	when duration is null then 'Extra Long'
	when duration <= 3 then 'Extra Short'
	when duration between 4 and 6 then 'Short'
	when duration > 6 then 'Long'
end as "Duration"
from games
order by name, "Part of the day", "Duration";

--16
select product_name,
order_date,
order_date + interval '3 days' as "Pay Due",
order_date + interval '1 month' as "Deliver Due"
from orders;

--17
select first_name,
extract (years from age(now(), registration_date)) as "Age in Years",
extract (years from age(now(), registration_date)) * 12 + extract(months from age(now(), registration_date)) as "Age in Months",
date_part('day', now() - registration_date) as "Age in Days",
date_part('epoch', now() - registration_date) / 60 as "Age in Minutes"
from users;