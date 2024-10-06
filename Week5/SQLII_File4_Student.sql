create database SQL2Inclass4;
use SQL2Inclass4;

DROP TABLE IF EXISTS `account_details`;
CREATE TABLE IF NOT EXISTS `account_details` (
  `acc_id` int(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `ssn` char(10) NOT NULL,
  `acc_holder_id` int(10) NOT NULL,
  `balance` decimal(20,4) DEFAULT '0.0000',
  PRIMARY KEY (`acc_id`));
  
INSERT INTO `account_details` (`acc_id`, `acc_holder_id`, `balance`, `first_name`, `last_name`, `ssn`) VALUES
	(1, 100, 132.1020, 'Joseph', 'Cane', '098765432'),
	(2, 300, 4435.2030, 'Kim', 'Karry', '087654321'),
	(3, 120, 2345223.6600, 'Jim', 'Anderson', '123456780'),
	(4, 90, 98763.2300, 'Jessie', 'Thomson', '765432109'),
	(5, 110, 34221.1000, 'Palak', 'Patel', '654321890'),
	(6, 80, 7634.8000, 'Max', 'Jerrard', '456789012'),
	(7, 10, 876964.7000, 'Peter', 'Koshnov', '512345670'),
	(8, 110, 299876.6000, 'Monica', 'Irodov', '120088551'),
	(9, 100, 7659809.5300, 'Petro', 'Jenkins Jr', '123456789'),
	(10, 200, 111.1200, 'Jeff', 'Joshua', '765432189' );
    
select * from account_details;
# Q.1 Write a tansactional query that transfers 1000 dollars from Monica's account to 
#Joseph's account and save the transaction. 
# Solution:
Set sql_safe_updates=0;
Start Transaction;
Update account_details Set balance = balance - 1000 Where First_name = 'Monica';
Update account_details Set balance = balance + 1000 Where First_name = 'Joseph'; -- 1132.1020

Select First_Name, Balance from account_details Where First_Name In ('Joseph','Monica');
-- Saving the tranc
Commit;

# Q.2 Transfer 1000 dollars from Monica's to Peter's account and discard all the changes
# and end the transaction
Start Transaction;
Update account_details set balance = balance - 1000 where First_Name = 'Monica';
Update account_details set balance = balance + 1000 where First_Name = 'Peter';

Select First_Name, Balance from account_details Where First_Name In ('Joseph','Peter','Monica');
Rollback;

####################################################################################
# Datasets Used: employee_details.csv and department_details.csv
-- ----------------------------------------------------
# Q.3 Create a view "details" that contains the columns employee_id, first_name,
# last_name and the salary from the table "employee_details".
#Solution:
 
 Create View Details As
 Select employee_id, first_name,last_name,salary
 From employee_details;
 
 Select * from Details;
# Q.4 Update the view "details" such that it contains the records from the columns 
# employee_id, first_name, last_name, salary, hire_date and job_id where job_id is ‘IT_PROG’.
#Solution:

Alter View Details As
Select employee_id, first_name,last_name,salary,hire_date,job_id
From employee_details Where Job_Id ='IT_PROG';

 Select * from Details;

/* Q.5 Create a view "check_salary" that contains the records from the columns 
employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
where the salary should be greater than 50000. */
#Solution:
Create View Check_Salary As
Select employee_id, first_name, last_name, job_id,salary 
from employee_details where Salary > 50000;

Select * from Check_Salary;

# Q.6 Create a view "salary_range" such that it contains the records from the columns 
#employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary is in the range (30000 to 50000).
#Solution:

Create view salary_range As
Select employee_id, first_name, last_name, job_id,salary 
from employee_details 
Where Salary Between 30000 and 50000;

Select * from salary_range;


# Q.7 Create a view "location_details" that contains the records from the
# columns department_name, manager_id and the location_id from the table "department_details" 
-- --  where the department_name is ‘Shipping’.
#Solution:
 Create View location_details As
 Select department_name, manager_id, location_id from department_details 
 where Department_name='Shipping';
 
# Q.8 Create a view "pattern_matching" such that it contains the records from the columns 
#employee_id, first_name, job_id and salary from the table name "employee_details" 
-- --  where first_name ends with "l".
#Solution:
Create view pattern_matching As
Select employee_id, first_name, job_id,salary from employee_details 
Where First_name like '%l';


# Q.9 Drop multiple existing views "pattern_matching", "salary" and "location_details".
#Solution:
 
Drop View pattern_matching,check_salary,location_details;


# Q.10 Create a view "employee_department" that contains the common
# records from the tables "employee_details" and "department_table".
#Solution:
Create view employee_department
As
Select emp.Employee_id, emp.First_Name,emp.Salary, emp.Job_id,
dept.department_name from employee_details as emp
Inner Join Department_Details as Dept
on emp.employee_id = Dept.Employee_id;

Select * from department_details;
Select * from employee_department;



