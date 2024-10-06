Create Table Department
(
	DeptID Int primary key,
    DeptName varchar(50) not null
);

Create Table Employee_Table
(
	EmpID Int Primary key,
    EmpName varchar(50) not null,
    Department_ID Int,
    FOREIGN KEY (Department_ID) REFERENCES Department(DeptID)
);

Insert into Department (DeptID, DeptName)
Values (1,'Human Resources'),(2,'IT'),(3,'Finance');

Insert into Employee_Table(EmpID,EmpName,Department_ID)
Values (101,'Karan',2);

Delete from Department Where DeptID = 2;

/* Referential Actions in MYSQL
On Delete, On Update
*/
Create Table Employee_Table1
(
	EmpID Int Primary key,
    EmpName varchar(50) not null,
    Department_ID Int,
    FOREIGN KEY (Department_ID) REFERENCES Department(DeptID)
    On Delete Cascade -- On Delete Set null -- On Delete Restrict -- On Delete No Action
    On Update Cascade -- On Update Set Null -- On Update Restrict -- On Update No Action
);
/*
On Delete Cascade -- Automatically delete employees if their department is deleted
On Update Cascase -- Automatically update employees' depatID if the department's id is updated.
*/

Insert into Employee_Table1(EmpID,EmpName,Department_ID)
Values (101,'Karan',2);


Select * from Employee_Table1;

Delete From Department Where DeptID = 2;
Select * from department;

Create Table EmployeeTest
(

	EmployeeID int primary key,
    FirstName varchar(50),
    LastName varchar(50),
    email varchar(100),
    phonenumber char(10),
    hire_date date,
	manager_id int default 111,
    foreign key (manager_id) references EmployeeTest(EmployeeID)
);

Create Table Testing
(
	MobileNumber varchar(10) unique

);

Insert into Testing(MobileNumber)
values ('9999999999');

Insert into Testing(MobileNumber)
values (Null);

/* Unique key constraint:
	We can insert only unique item in a unique constraint column, A unique key column
	can accept null value in SSMS and MYSQL. Where In MYSQL the unique key column can accept multiple
	null value as duplicate whereas in MSSQL only single null value you can insert.
*/

Select * from Testing;




