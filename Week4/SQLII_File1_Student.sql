# Dataset used: titanic_ds.csv
# Use subqueries for every question
Create database SQL2Inclass1;
use SQL2Inclass1;

/*Q1. Display the first_name,sex, age, fare and deck_number of the passenger 
equals to passenger number 7 but exclude passenger number 7. (4 Rows)
*/

SELECT 
    First_Name, Sex, Age, Fare, deck_number, passenger_no
FROM
    titanic_ds
WHERE
    Deck_Number IN (SELECT 
            Deck_number
        FROM
            titanic_ds
        WHERE
            passenger_no = 7)
        AND passenger_no <> 7;

/* Q2. Display first_name,embark_town where deck is equals to the deck of embark
 town ends with word 'town' (7 Rows)
*/


Select first_name, embark_town from titanic_ds
Where deck in (Select deck from titanic_ds where embark_town like '%town');
/*
_, % in : MYSQL
?, * in : MS Excel
*/

-- Dataset used: youtube_11.csv
/*Q3. Write a query to print video_id and channel_title where trending_date is equals to 
 the trending_date of category_id 1 (5 Rows)
*/
Select video_id, channel_title from youtube_11
Where Trending_date in (Select trending_date from youtube_11 where category_id = 1);

/*Q4. Write a query to display the channel_title, publish_date and the trending_date 
 having category id in between 9 to Maximum category id .
 Do not use Max function and Use Subquery (3 Rows)
*/
Select Channel_Title, Publish_Date, Trending_date , Category_id from youtube_11
Where Category_id between 9 and (Select Category_id from youtube_11 Order by Category_id Desc Limit 1);

Select Channel_Title, Publish_Date, Trending_date , Category_id from youtube_11
Where Category_id between 9 and (Select max(Category_id) from youtube_11);

# Database used: db1 (db1.sql file provided)
use inclass;

/* Q5. Get product name , product line , product vendor of products that got cancelled.
(We can utilize the table products and orders) (53 Rows) */
 
Select * from products;
Select ProductName, ProductLine, ProductVendor From Products
Where ProductCode = Any(
Select ProductCode From Orderdetails Where OrderNumber =
Any (Select orderNumber From Orders Where Status = 'Cancelled'));

Select Distinct p.ProductName, P.ProductLine, P.ProductVendor
from Products P
Join OrderDetails od 
on P.productcode = od.productcode
Join Orders O 
On od.OrderNumber = o.OrderNumber
Where O.status = 'Cancelled';


Select  Distinct p.ProductName, P.ProductLine, P.ProductVendor
from Products P
Join OrderDetails od 
on P.productcode = od.productcode
Join Orders O 
On od.OrderNumber = o.OrderNumber
Where O.status = 'Cancelled';


#Q6. Display those customers who ordered product of price greater than average price(buyPrice)
#of all products (98 Rows)

Select * from Customers;

Select * from Customers where CustomerNumber in 
(
Select CustomerNumber from orders where OrderNumber in 
(
Select OrderNumber from orderDetails where ProductCode in 
(Select ProductCode from Products where buyprice >
(Select avg(buyPrice) from products))));

With AvgPriceProduct as
(
	Select ProductCode from Products
    Where Buyprice > (Select avg(buyPrice) from products)
),
ProductOrders as
(
	Select OrderNumber from Orderdetails
    Where ProductCode in (Select ProductCode from AvgPriceProduct)
),
CustomerOrders As
(
	Select CustomerNumber from orders
    Where OrderNumber in (Select OrderNumber from ProductOrders)
)
Select * from Customers where CustomerNumber in (Select CustomerNumber from CustomerOrders);

