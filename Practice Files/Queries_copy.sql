--Creating table for "PH-EmployeesDB"
create table departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY(dept_no),
	UNIQUE(dept_name)
);
create table employees(
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no,title,from_date)
);

CREATE TABLE dept_emp (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

select * from departments;
select * from employees;
select * from dept_manager;
select * from salaries;
select * from titles;
select * from dept_emp;
drop table dept_manager CASCADE;
drop table dept_emp CASCADE;


CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
drop table dept_emp CASCADE;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--skill drill--
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';



-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

drop table retirement_info;


-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;



-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info	
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

--create ne table which holds retired emp with fname,lname n to date
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

select * from current_emp;
-- Employee count by department number
--Skill drill to create table and export esv 
create table empCount_By_dept_no as
(SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no);

select * from empCount_By_dept_no;

SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- SELECT emp_no, first_name, last_name,gender
-- INTO emp_info
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
drop table emp_info cascade;
-- List 1: Employee Information
-- List of Emplyoees
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
	 
select * from emp_info;	 

-- List 2: Management
-- List of managers per department
select  dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no=d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no=ce.emp_no);
		
SELECT * FROM manager_info;

-- List 3: Department Retirees
-- Department Retirees
SELECT  ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no);

select * from dept_info;


-- List of Retire Employee for deparmants

select  ri.emp_no,
		ri.first_name,
		ri.last_name,
		d.dept_name
INTO Dept_retirement_info
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON(ri.emp_no=de.emp_no)
INNER JOIN departments as d
ON(de.dept_no=d.dept_no);

select *from Dept_retirement_info;


-- Tailored List
-- Sales Dept Retiring Employees
--Sales Department Retiring Employees
select * 
INTO sales_info
from Dept_retirement_info
where  dept_name = 'Sales';

select * from sales_info;

--Sales Department Retiring Employees
SELECT *
--INTO sales_info
FROM dept_retirement_info
WHERE dept_name IN ('Sales');

select * from sales_info;

--Sales and Development teams:

select * 
INTO teams_info
from Dept_retirement_info
where  dept_name IN ('Sales','Development');
select * from teams_info;
select * from employees;
select * from titles;
-- The list of retiring employees with duplicates
-- Join employee as e and title as ti tables to create new table "retirement_titles"
SELECT  e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
INTO retirement_titles		
FROM employees as e
INNER JOIN titles as ti
ON(e.emp_no = ti.emp_no)
WHERE(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- The list of retiring employees without duplicates
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
		rt.emp_no,
		rt.first_name,
		rt.last_name,
		rt.title
-- INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date='9999-01-01'
ORDER BY rt.emp_no,rt.to_date DESC;

select * from unique_titles;
Drop table unique_titles CASCADE;

SELECT DISTINCT ON (rt.emp_no)
		rt.emp_no,
		rt.first_name,
		rt.last_name,
		rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date='9999-01-01'
ORDER BY rt.emp_no,rt.to_date DESC;


Drop table unique_titles CASCADE;

select * from unique_titles;

create table empCount_By_dept_no as
(SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no);

-- The number of retiring employees grouped by title 
-- The number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.title),ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

select * from retiring_titles;
SELECT ut.emp_no,
		ut.first_name,
		ut.last_name,
		ut.title
INTO unique_retiring_titles
FROM unique_titles as ut
-- GROUP BY ut.emp_no, ut.title
ORDER BY ut.emp_no,ut.title desc ;

select * from unique_retiring_titles;

Drop table unique_retiring_titles1 cascade;
Drop table retiring_titles cascade;

select * from retiring_titles;

-- The Employees Eligible for the Mentorship Program 
SELECT DISTINCT ON(e.emp_no)
				e.emp_no,
				e.first_name,
				e.last_name,
				e.birth_date,
				de.from_date,
				de.to_date,
				ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON(e.emp_no=de.emp_no)
INNER JOIN titles as ti
ON(e.emp_no=ti.emp_no)
WHERE(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND(de.to_date='9999-01-01')
ORDER BY e.emp_no,ti.from_date DESC;



SELECT * FROM mentorship_eligibilty;
select * from retirement_titles;

-- How many roles will need to be filled as the "silver tsunami" begins to make an impact?
--Roles per Staff and Departament: 

SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	d.dept_name
INTO unique_titles_department
FROM retirement_titles as rt
INNER JOIN dept_emp as de
ON (rt.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)
ORDER BY rt.emp_no, rt.to_date DESC;


SELECT * FROM unique_titles_department;

-- Tried for 72458 retiring employees
SELECT DISTINCT ON(urt.emp_no)
			urt.emp_no,
			urt.first_name,
			urt.last_name,
			urt.title,
			d.dept_name
INTO unique_titles_departments			
FROM unique_retiring_titles as urt
INNER JOIN dept_emp as de
ON(urt.emp_no=de.emp_no)
INNER JOIN departments as d
ON(d.dept_no=de.dept_no)
ORDER BY urt.emp_no,de.to_date DESC;

select * from unique_retiring_titles;
select * from unique_titles_departments;
Drop table unique_titles_departments cascade;

SELECT * FROM unique_titles_departments;

-- How many roles will need to be fill per title and department?

SELECT ut.dept_name, ut.title, COUNT(ut.title) 
INTO rolls_to_fill_T_D
FROM (SELECT title, dept_name from unique_titles_department) as ut
GROUP BY ut.dept_name, ut.title
ORDER BY ut.dept_name DESC;

select * from rolls_to_fill_T_D;

-- Tried for 72458 retiring employees
SELECT utd.dept_name,utd.title,COUNT(utd.title)
INTO rolls_to_fill
FROM(SELECT title, dept_name FROM unique_titles_departments) as utd
GROUP BY utd.dept_name,utd.title
ORDER BY utd.dept_name DESC;

drop table rolls_to_fill;
SELECT * FROM rolls_to_fill;

-- Qualified staff, retirement-ready to mentor next generation.
SELECT ut.dept_name, ut.title, COUNT(ut.title) 
INTO qualified_staff_mentors
FROM (SELECT title, dept_name from unique_titles_department) as ut
WHERE ut.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')
GROUP BY ut.dept_name, ut.title
ORDER BY ut.dept_name DESC;

select * from qualified_staff_mentors;


-- Tried for 72458 retiring employees
SELECT utd.dept_name,utd.title,Count(utd.title)
INTO qualified_staff
FROM (select dept_name,title from unique_titles_departments) as utd
WHERE utd.title IN('Senior Staff','Senior Engineer','Technique Leader','Manager')
GROUP BY utd.dept_name,utd.title
ORDER BY utd.dept_name DESC;

drop table qualified_staff;
SELECT * FROM qualified_staff;

select * from dept_emp

where to_date=('9999-01-01');



select * from retirement_titles;

select * from current_emp;
