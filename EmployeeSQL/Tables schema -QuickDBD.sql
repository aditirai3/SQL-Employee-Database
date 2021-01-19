-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/3dEKEm
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(20)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "sex" VARCHAR(2)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(20)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(20)   NOT NULL,
    "title" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
select * from dept_emp
--select * from employees, departments, dept_emp, dept_manager, salaries, titles
-- List employee number, last name, first name, sex, and salary for each employee
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM salaries
INNER JOIN employees on
employees.emp_no = salaries.emp_no;
--List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date from employees
WHERE hire_date >= '1986-01-01' and hire_date <= '1986-12-31'
--List the manager of each department: dep no., dep name, the manager's employee no., last name, first name
SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments ON
departments.dept_no = dept_manager.dept_no;
--List the department of each employee: employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees on employees.emp_no = dept_emp.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no;
--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name LIKE 'B%';
--List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees on dept_emp.emp_no = employees.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees on dept_emp.emp_no = employees.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no
WHERE dept_name in ('Sales', 'Development');
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(last_name) as "Last name frequency" from employees
group by last_name
order by count(last_name) DESC;
