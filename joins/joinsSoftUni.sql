--1
select e.employee_id, e.job_title, a.address_id, a.address_text
from employees e 
join addresses a 
on e.address_id = a.address_id
order by address_id asc
limit 5;

--2
select e.first_name, e.last_name, t."name" as town, a.address_text
from employees e 
left outer join addresses a 
on e.address_id = a.address_id 
join towns t 
on a.town_id = t.town_id 
order by e.first_name asc, e.last_name 
limit 50;

--3
select e.employee_id, e.first_name, e.last_name, d."name"  as departmentName
from employees e 
join departments d 
on e.department_id = d.department_id and d."name" = 'Sales'
order by e.employee_id asc;

--4
select e.employee_id, e.first_name, e.salary, d."name" as departmentName
from employees e
join departments d 
on e.department_id = d.department_id and e.salary > 15000
order by d.department_id asc
limit 5;

--5
select e.employee_id, e.first_name 
from employees e 
left join employeesprojects e2 
on e.employee_id = e2.employee_id 
left join projects p 
on e2.project_id = p.project_id 
where e2.project_id is null
order by e.employee_id asc
limit 3;

--6
select e.first_name, e.last_name, e.hire_date, d."name" as department_name
from employees e 
join departments d 
on e.department_id = d.department_id and d."name" in ('Sales', 'Finance') and e.hire_date > '01/01/1999'
order by e.hire_date asc;

--7
select e.employee_id, e.first_name, p."name" as project_name
from employees e 
join employeesprojects e2 
on e.employee_id = e2.employee_id 
join projects p 
on e2.project_id = p.project_id 
where p.start_date > '2002-08-13' and p.end_date is null
order by e.employee_id asc
limit 5;

--8
select e.employee_id, 
	   e.first_name, 
	   case 
	   	when extract(year from p.start_date)>=2005 then null 
	   	else p."name" 
	   end as project_name
from employees e 
join employeesprojects ep on e.employee_id = ep.employee_id
join projects p on ep.project_id = p.project_id 
where e.employee_id = 24;

--9
select e.employee_id, e.first_name, m.employee_id as manager_id, m.first_name 
from employees e 
join employees m on e.manager_id = m.employee_id
where m.employee_id  in (3, 7)
order by e.employee_id;

--10
select e.employee_id, e.first_name || ' ' || e.last_name as employee_name, m.first_name || ' ' ||  m.last_name as manager_name, d."name" as department_name
from employees e 
join employees m on e.manager_id = m.employee_id
join departments d on e.department_id = d.department_id 
order by e.employee_id 
limit 50;

--11
select min(department_avgs.avg ) as min_avg_salary
from ( select avg(e.salary)
from employees e 
join departments d 
on e.department_id = d.department_id
group by d."name") as department_avgs;

--12
select c.country_code, m.mountain_range, p.peak_name, p.elevation
from peaks p 
join mountains m on p.mountain_id = m.id
join mountainscountries mc on p.mountain_id = mc.mountain_id 
join countries c on mc.country_code = c.country_code 
where p.elevation > 2835 and c.country_name = 'Bulgaria'
order by elevation desc;

--13
select mc.country_code, count(m.mountain_range) as mountaines_count 
from mountains m 
join mountainscountries mc on m.id = mc.mountain_id 
join countries c on mc.country_code = c.country_code 
where c.country_name in ('United States', 'Russia', 'Bulgaria')
group by mc.country_code 
order by mountaines_count desc;

--14
select c.country_name, r.river_name 
from countries c 
join continents con on c.continent_code = con.continent_code 
left outer join countriesrivers cr on c.country_code = cr.country_code 
left outer join  rivers r on cr.river_id = r.id 
where con.continent_name = 'Africa'
order by c.country_name asc
limit 5;

--15
select c.continent_code, c.currency_code, count(*) as currency_usage
from countries c 
join currencies cc on c.currency_code = cc.currency_code 
group by c.continent_code, c.currency_code
having count(*) > 1
order by c.continent_code;

--16
select count(c.continent_code) as country_code
FROM countries c
left join mountainscountries mc on c.country_code = mc.country_code
where mc.country_code is null;

--17
select c.country_name, max(p.elevation) as highest_peak_elevation, max(r.length) as longest_river_lenght
from countries c 
left outer join countriesrivers cr on c.country_code = cr.country_code 
left outer join rivers r on cr.river_id = r.id 
left outer join mountainscountries mc on c.country_code = mc.country_code 
left outer join mountains m on mc.mountain_id = m.id
left outer join peaks p on m.id = p.mountain_id 
group by c.country_name
order by highest_peak_elevation desc nulls last, longest_river_lenght desc nulls last
limit 5;

--18
select c.country_name,
		coalesce(p.peak_name, '(no highest peak)') as highest_peak_name,
		coalesce(p.elevation, 0) as highest_peak_elevation,
		coalesce(m.mountain_range , '(no mountains)') as mountain_name 
from countries c 
left outer join mountainscountries mc on c.country_code = mc.country_code 
left outer join mountains m on mc.mountain_id = m.id
left outer join peaks p on m.id = p.mountain_id 
where p.elevation = (
	select max(p2.elevation)
	from mountainscountries m2 
	join mountains m3 on m2.mountain_id  = m3.id  
	join peaks p2 on m3.id = p2.mountain_id 
	where m2.country_code = c.country_code  
) or p.elevation is null
order by c.country_name asc, highest_peak_name asc