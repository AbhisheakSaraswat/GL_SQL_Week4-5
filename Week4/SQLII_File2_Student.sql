Create database Sql2Inclass2;
use Sql2Inclass2;
-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------
/* Q1. Use aggregate window functions to find the average of points for each row within
  its partition (country) and also arrange the final result in the descending order by country.
 print country,province,winery,variety
*/
Select Distinct Country, 
avg(points) over (partition by country) as AvgPointsByCountry
From Wine Order by Country desc;

# Dataset Used: students.csv
-- --------------------------------------------------------------
# Q2. Provide the new roll numbers to the students on the basis of their names alphabetically.
Select *, row_number()
Over (order by `Name`)  as Roll_Number  from Students;

-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
# Q3. Display the difference in ad_clicks between the current day and the next day for 
# the website 'Olympus'
Select * from website_stats;

Select Day, ad_clicks from website_stats;

Select Day, ad_clicks, website_id,
lead(ad_clicks) over (Order by day) as ad_clicks_nextDay,
ad_clicks - lead(ad_clicks) over (Order by day) as Clicks_Difference
From website_stats
Where Website_id = (select ID from web where Name = 'Olympus');

# Q4. Write a query that displays the statistics for website_id = 3 such that for each row,
# show the day, the number of users and the smallest number of users ever.
Select Day, no_users,
first_value(no_users) over (order by no_users) smallesNumberofUsers
From Website_stats
Where website_id = 3;

with Test As
(

Select day, no_users, dense_rank() over(order by no_users) as DRank
from website_stats
where website_id = 3
)
Select  day, no_users,
min(no_users) over () as SallestNumberofUsers
From Test
Where Drank = 1;


# Dataset Used: play_store.csv and sale.csv
-- ---------------------------------------------------------------

# Q5. Write a query thats orders games in the play store into three buckets as 
#per editor ratings received from higher to lowest

Select * from Play_store;
Select Name, genre, editor_rating, ntile(3) over (Order by editor_rating) as Bucket
from Play_store;

# Q6. Write a query that displays the name of the game, the price, the sale date and 
#the 4th column should display # the sales consecutive number i.e. ranking of game as 
#per the sale took place, so that the latest game sold gets number 1. 
#Order the result by editor's rating of the game

Select * from sale;
Select ps.name, s.price, s.date,
row_number() over (order by date desc) as latestgamesoldRank
from play_store ps, sale s
where s.game_id = ps.id
order by editor_rating;
/*
Note: In MySQL In over clause Order by clause is not mandatory when you are suing 
row_number, rank, dense_rank, where as In MS SQL, order by clause is mandatory for row_number, rank, dense_rank
*/

-----------------------------------------------------------------
# Dataset Used: movies.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q7. Write a query that displays basic movie informations as well as the previous rating 
#provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.
Select * from Movies;
Select * from Ratings;
-- Try to solve it by own : let me in next session if you are not able to do it?

# Q8. For each movie, show the following information: title, genre, average user rating for 
#that movie  and its rank in the respective genre based on that average rating in descending 
#order (so that the best movies will be shown first).

With SubQuery As
(
Select m.Title, m.Genre, Avg(r.Rating) as AvgRating
From Ratings r, Movies m
Where r.Movie_id = m.Id
Group by m.Genre, m.Title
)
Select Title,Genre, AvgRating, Rank() over (partition by Genre Order by AvgRating Desc) as nRank
From SubQuery;


# Q9. For each rental date, show the rental_date, the sum of payment amounts 
#(column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between 
#these two values. -- you can solve using Lag function


Select * from EmployeeDB;
Select Occupation, Grade, sum(Sales) as TotalSales From EmployeeDB
Group by Occupation, Grade;

Select Occupation, Grade, sum(Sales) as TotalSales,
avg(Sales) as AvgSales,
max(Sales) as MaxSales,
min(Sales) as MinSales From EmployeeDB
Group by Grade, Occupation
-- all the non-aggregate columns should be part of group by clause if you are using agg funcs
