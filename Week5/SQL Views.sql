Select * from EmployeeDB;

Select * from EmployeeDB Where Grade = 'C';

Create View Employee_view
AS
Select FirstName, LastName, Occupation, Grade, Sales from EmployeeDb where Sales > 3000;

Select * from Employee_View;
-- 		Shirley	Chavez	Clerical	C	5000

-- I want to update Sales Where I have Grade = C
Update Employee_view Set Sales = 10000 where Grade = 'C';

Delete From Employee_View Where Grade = 'C';

/*
A normal state (no join, no subquery, no sql agg etc) is written on the above view and I have updated
the sale or an emaployee, those change refelected successfully in your view or in main table.
*/

Create View MyView_EmployeeSummary
AS
Select Education, Occupation, Grade, sum(yearlyIncome) as TotalIncome,
Sum(Sales) as TotalSales from EmployeeDb
Group by  Education, Occupation, Grade;

Select * from MyView_EmployeeSummary;
Update MyView_EmployeeSummary set TotalSales = 100 where Grade = 'A';

Delete from MyView_EmployeeSummary;
Delete from Employee_View;

Select * from EmployeeDB;
With CTE As
(
Select * from MyView_EmployeeSummary
)
Select * from CTE;

Delete from Employee Where EmpID in (Select EmpID from CTE)



