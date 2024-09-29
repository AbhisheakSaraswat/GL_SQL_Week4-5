/* SQL Analytical Function or Ranking Function */

Select * From EmployeeDB;

Select Occupation, sum(Sales) as totalSales from EmployeeDB
group by Occupation order by Occupation;

Select Distinct Occupation, 
sum(Sales) over (partition by Occupation Order by Occupation)
as totalSales from EmployeeDB;

Select * from 
(
Select FirstName, Education, Occupation, Sales, 
row_number() over () as row_num from EmployeeDB
) as T
Where row_num % 3 = 0;


Select FirstName, Education, Occupation, Sales, 
row_number() over () as row_num from EmployeeDB
having row_number() over () % 3 = 0; -- Invalid query




With TestingTable
As
(
Select FirstName, Education, Occupation, Sales, 
row_number() over () as row_num from EmployeeDB
)
Select * from TestingTable Where row_num % 3 = 0;

Select * from EmployeeDB;

Select FirstName, Occupation, Grade, YearlyIncome,
Rank() over (partition by Occupation Order by YearlyIncome) as NormalRank,
Dense_Rank() Over (partition by Occupation Order by YearlyIncome) as DenseRank
From EmployeeDB;

-- Moving Average and Sum of Specific Row

Select * from superstore limit 5;

Select Category, Sales,
Round(Avg(Sales) Over ( Order by Category Rows Between 2 preceding and current row),2) as MovingAvg
From Superstore;

Select Category, Sales,
Round(Avg(Sales) Over ( Order by Category Rows Between 1 preceding and current row),2) as MovingAvg
From Superstore;

Select Category, Sales,
Round(Avg(Sales) Over ( Order by Category Rows Between current row and 2 Following),2) as MovingAvg
From Superstore;

Select Category, Sales,
sum(Sales) Over ( Order by Category Rows Between current row and 2 Following) as MovingAvg
From Superstore;

Employee_ID  varchar(10)

Employee_id bigint

Select * from Table_1
Inner Join Table_2
Cast(Table_1.Employee_ID as BigInt) = Table_2.Emp_ID

Alter Table dataanalyst2024.Superstore
Change Column `Product Name` ProductName varchar(255);

-- Your InClass Solution

Exists
Not Exists
use hr_database;
Select * from employees;

select * from departments d where exists 
(select department_id from employees e
where e.department_id = d.department_id);

Select column_list from YourTable Where Exists (Select Salary from YourTable2 Where Somecondition);

Select Name from Employees E
Where Exists (select 1 from departments d where d.manager_id = e.employee_id)

Select columns_list from YourTableName Where Column in (Select Salary from YourTable2 Where Somecondition);

Select Name from Employees
Where Department_id in  (select Deparment_id from departments Where location = "New Delhi")

/* Diff b/w In and Exists */

In : This clause will check if a value is equal to any value returned by the subquery
Exists: This clause will checks for the existance of any rows returned by the subquery.

Performance: In is slower when your subquery is returning large number of rows

Null Handling : In: if the subquery return Null, the outer query may behave unexpectedly (e.g returning no rows)

Exist: It will give any issue when you are encounter the null, it only check if rows are present regardless of their content.


-- 10 Rows: Exists : 2

select * from departments d where not exists 
(select department_id from employees e
where e.department_id = d.department_id);

select * from departments d where not exists 
(select department_id from employees e);


Select Name, Salary from employees
where Salary > all (Select distinct Salary from Employees where Department_Id = 10) - 10: Analytical

If the subquery returns the salary like : 5000,6000,8000
/*
> All means that the employee's salary must be greater than every salary returned by te suquery
*/

Select Name, Salary from employees
where Salary = all (Select Salary from Employees where Department_Id = 10);

-- Today : 500, yesterday: 450
-- Today : 600, Yesterday : 750

Select * from EmployeeDB;

With LeadTable
AS
(
Select EmpID, FirstName, Sales,
Lead(Sales, 1) Over (Order by Sales) as Next_Sales
From EmployeeDB
) Select *, Sales - Next_Sales as Result
From LeadTable;

-- Lead and Lag -> When you have some period information: DateColumn (Week, Day, Qtr, yearly)
/* Home Task : Can you find out Quarter wise Comparision based on each year */
Select `Order ID` as OrderID, `Order Date` as OrderDate, Region, Sales
From superstore;
-- I have to share the data as well.
/* Date Set:
https://community.tableau.com/s/question/0D54T00000CWeX8SAL/sample-superstore-sales-excelxls
*/





