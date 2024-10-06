Create database Sql2Inclass3;
use Sql2Inclass3;
-- ------------------------------------------------------------------------------------------

/* 1. Create a table Airline_Details. Follow the instructions given below: 
	Q1. Values in the columns Flight_ID should not be null and Integer type.
	Q2. Each name of the airline should be unique.
	Q3. No country other than United Kingdom, USA, India, Canada and Singapore should beaccepted
	Q4. Assign primary key to Flight_ID
*/

Create Table If Not Exists AirLine_Details
(
	Flight_ID Int Not null,
	Airline Varchar(20) Unique,
    Country Varchar(50) Null Check(Country in ('United Kingdom', 'USA', 'India', 'Canada','Singapore')),
    Primary Key (Flight_ID)
);

Select * from AirLine_Details;
Insert into AirLine_Details(Flight_id, AirLine, Country)
VAlues 
(1,'Indigo','India'),
(2,'AirIndia','USA');

Insert into AirLine_Details(Flight_id, AirLine, Country)
VAlues 
(3,'Gulf Air AirLines','UAE'); -- Invalid record due to Check Constraint

Insert into AirLine_Details(Flight_id, AirLine, Country)
VAlues 
(3,'Gulf Air AirLines',Null); -- Invalid record due to Check Constraint

Describe AirLine_Details;

Select Constraint_Name, Check_Clause
From Information_Schema.Check_Constraints;



-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Name of the passenger should be not null
-- -- Q3. Only passengers having age greater than 18 are allowed.
-- -- Q4. Assign primary key to Traveller_ID
-- -- Q5. Flight_ID integer type and not null
-- -- Q6. Ticket_Price integer type and not null
Create Table If Not Exists Passengers
(
	Traveller_ID varchar(10) Not null,
    PNR varchar(10) not null,
    NameOfPassenger varchar(50) not null,
    Flight_ID Int Not null,
    Ticket_Price Int not null,
    Age Int Check (Age > 18),
    Primary Key (Traveller_ID)
    );
Describe Passengers;

Alter Table Passengers Modify PNR Char(10) Unique Not null;
-- ----------------------------------------------------------------------------------
-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique as well  .
-- ---------------------------------------------------------------------------------- 
/* Q4. Create a table Senior_Citizen_Details. Follow the instructions given below: 
Q1. Assign a foreign key constraint on Traveller_ID such that if any row from the Passengers table is updated,
the corresponding Traveller_ID in the referencing table adheres to the update (CASCADE), 
and if any row from the Passengers table is deleted, the referencing table restricts the 
deletion based on the foreign key relationship (RESTRICT). Provide the SQL statement for creating this foreign key constraint."
Q2. Table is updated, then the Senior_Citizen_Details table should also get updated.
Q3. Also deletion of any row from passenger table should not be allowed.
Q4. Create Discounted_Price column of varchar type 20 size with not null property. 
*/
 Create Table Senior_Citizen_Details
 (
	Traveller_ID Varchar(10),
    Discounted_Price Varchar(20) not null,
    Foreign key (Traveller_ID) References Passengers (Traveller_ID)
    On UpDate Cascade On Delete Restrict
 );
 
 Select * from Senior_Citizen_Details;
  
/* Q5. Create a table books. Follow the instructions given below: 
	Columns: books_no, description, author_name, cost
	Q1. The cost should not be less than or equal to 0.
	Q2. The cost column should not be null.
	Q3. Assign a primary key to the column books_no.
*/
Create Table Books
(
	books_no varchar(10),
    Description_bk varchar(20) unique,
    autor_name varchar(20),
    cost decimal(10,2) not null check (cost > 0),
    primary key (books_no)
);
Alter Table Books Add Mydescription varchar(20) unique,
Add Author varchar(20) unique;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
# Q6. Update the table 'books' to add columns 'description' and 'author' and must be unique
# of varchar type.

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q7. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
Create Table bike_sales
(
	id int primary key auto_increment,
    product varchar(10) not null,
    quantity int not null,
    release_year int not null,
    release_month int not null,
    Check (release_month >= 1 and release_month <= 12),
    check (release_year >= 2000 and release_year <= 2010),
    check (Quantity > 0)
);




