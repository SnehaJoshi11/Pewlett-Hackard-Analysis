# Pewlett-Hackard-Analysis

## Project Overview

## Purpose
PH has decided to offer retirement packages and find out which position need to fill in the future.
But PH itself is fallen behind to maintain the database.

With the help of SQL tools (PostgreSQL and PgAdmin4), Company wants to maintain a data and prepare company with
several thousand employees for the upcoming "Silver Tsunami".
	
As per the dataset, lot of employees are going to be retired in the future and company needs to prepare with retirement packages, 
open positions and employee training.

## Requirements:
 1. Identify the retiring employees by their title.
 2. Determine the sum of retiring employees grouped by title.
 3. Identify the employees eligible for participation in the mentorship program.
 4. Determine the number of roles-to-fill grouped by title and department.
 5. Determine the number of qualified, retirement-ready employees to mentor the next generation grouped by title and department.



## Resources
- **Data Source:**
  - [Six csv files](Data_Source/)
    - The data is gathered in six CSV files and the analysis is performed using relational databases.

- **QuickDBD** - To create quick database design for better visualization.
- **PostgreSQL** - A database system to load, build and host company’s data.
- **pgAdmin** - A GUI, using SQL Language to explore, manipulate and extract the data.

## ERD and Schema
 
ERD An entity-relationship diagram (ERD) is crucial to creating a good database design.
   - It is used as a high-level logical data model, which is useful in developing a conceptual design for databases.
 

<p align="center">  
<img src="Queries/ERD_EmployeeDB.png" width="50%" height="50%">
</p>
<p align="center">  
<i>Figure 1: ERD</i>
</p>
      
## Schema:

- [Schema](Queries/schema.sql) A schema is a collection of database objects like tables, triggers, stored procedures, etc.
- Database may have one or more schema. 
- Schemas are important for designing database management systems (DBMS) or relational database management systems (RDBMS).
- Schema is of three types: Physical schema, logical schema and view schema.


## Results


**1.	The list of retiring employees**

-	The table includes employee number, first name, last name, title, from-date and to-date.
-	The query returns 133,776 rows. 
-	The table displays mixed data of employees who is going to retire in the next few years and who left the jobs.
-	The list is long and extensive and includes duplicate data like some employees appear more than once due to change of title during their career at Pewlett-Hackard.
<p align="center">  
<img src="PNGs/RetiringEmpTitles_duplicates.png" width="50%" height="50%">
</p>
<p align="center">  
<i>Figure 2: Table with the employee’s data that are retirement-ready</i>
</p>

<p>
	
To retrieve the data we need to join/merge two tables.`'employee as e and title as ti'`.
- Based on `e.emp_no,e.first_name,e.last_name,ti.title,ti.from_date,ti.to_date`.
- We use `INNER JOIN title as ti`, `ON(e.emp_no=ti.emp_no)` and filtered with 'birth_date', to find out who is going to retire in few years.
- With where clause`(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')`.
	
 </p>

## 
  
**2.	The list of retiring employees without duplicates**
-	The table includes employee number, first_name, last_name, title, from_date and to_date.
-	The query returns 72,458 rows. 
- 	The table displays a list of employees who are going to retire in the next few years.
-	In the table each employee is listed only once, by her or his most recent title.
<p align="center">  
<img src="PNGs/unique_retiring_titles_72458.png" width="50%" height="50%">
</p>
<p align="center">  
<i>Figure 3: Table with the employee’s data that are retirement-ready without duplicates</i>
</p>

<p>
	
To retrieve the unique Retiring employees,
- We need to use `'DISTINCT' clause 'ON'` retiring_emp table with where clause on date `(rt.to_date='9999-01-01')` to get only retiring employees not the employees who left the company.
- `ORDER By clause ON 'emp_no' and 'to_date'` to sort the data by descending order.
	
	
</p>	 

##

**3.	The number of retiring employees (72458) grouped by title**

-	The table includes employees titles and their sum. 
-	The query returns a cohesive table with 7 rows.
-	From this table we can quickly see how many employees with certain title will retire in the next few years.

<p align="center">  
<img src="PNGs/retirement_titles-72458.png" width="30%" height="30%">
</p>
<p align="center">  
<i>Figure 4: Table with the employee grouped by title</i>
</p>

<p>
	
	
To find out retiring employee count, 
- We will use `GROUP BY` clause to group titles from unique title table and sort it for most recent values with `ORDER BY count DESC`.


</p>

##

**4.	The employees eligible for the mentorship program**

-	The table contains employee number, first name, last name, birth_date, from_date to_date and title. 
-	The query returns 1,549 rows.
- 	The table displays a list of employees who is eligible for the mentorship program.
<p align="center">  
<img src="PNGs/mentorship_eligibility.png" width="50%" height="50%">
</p>
<p align="center">  
<i>Figure 5: Table with the employee grouped by title</i>
</p>

<p>
	
	
To retrieve this data 3 tables needs to be mearged together 'employee,titles,dept_emp',title with 'INNER JOIN'.
- Then query filters by `birth_date betwwen ('1965-01-01' AND '1965-12-31')` and `to_date` to include only current values.
- It is unique data because we used `DISTINCT ON(emp_no)`.	
- To ensure most recent valuse we will use `ORDER BY e.emp_no,ti.from_date DESC`.


</p>


## Summary


As the company is preparing for the upcoming "silver tsunami" , A good planning is very important, especially when too many employees are involved.

Reports above give a good insight about the number of the employees that are about to retire and hold specific title. 

Now we need to concentrate on staff and their respective departments,So that headquarters can see what to expect in each department separately. 


<p align="center">  
<img src="/PNGs/ExtraRollsPer_Staff_and_Department.png" width="60%" height="60%">
</p>
<p align="center">  
<i>Figure 6: Table with retirement-ready employee’s data with added department name</i>
</p>


<p>
	
- To retrieve department name information, we can merge additional table `departments` into existing table `retirement_titles` with the `inner join`.
- After removing the duplicates, with `DISTINCT ON` command, the table was ready to be used for additional queries.

	
</p>

##

***How many roles will need to be filled as the "silver tsunami" begins to make an impact?*** <br>

Here we can have additional query that breaks down how many staff will retire per department. Since every department will be affected in some way this query gives more precise numbers what each department can expect and how many roles will need to be filled.

<p align="center">  
<img src="/PNGs/ExtraRollsPer_Title_and_Department.png" width="40%" height="40%">
</p>
<p align="center">  
<i>Figure 7: Sum of retirement-ready employees’ group by title and department. </i> 
</p>


<p>
	
	
- With the help of group by dept_name and title we can find out number of rolls need to fill per title and department.
	
</p>

##

***Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett-Hackard employees?*** <br>


To make sure that, there are enough qualified staff for training at Pewlett-Hackard we will run another query with additional filter, that returns only employees on higher positions, assuming that those are qualified as mentors.

The result includes only staff on higher positions.

<p align="center">  
<img src="PNGs/ExtraQualified_staff_mentors.png" width="40%" height="40%">
</p>
<p align="center">  
<i>Figure 8: Sum of qualified, retirement-ready employees’ group by title and department</i>
</p>


<p>
	
	
- We can find out who is qualified and ready to give training for upcoming candidates.
- We can retrieve dept_name and count(title) from unique_titles_departments and put condition `WHERE ut.titles IN("Senior_staff","Senior Engineer","Technology Leader","Manager")` and `GROUP BY (dept_name and title)` with descending order.
 
</p>
