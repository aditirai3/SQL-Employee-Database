select * from salaries
select * from employees
select * from titles;
select titles.title, round(AVG(salary),2)
from employees
join salaries on
salaries.emp_no = employees.emp_no
join titles on
employees.emp_title_id = titles.title_id
group by titles.title_id;
