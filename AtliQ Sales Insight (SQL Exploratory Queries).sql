
/*1) First and Foremost we wanted to know how many transcations took place - Like In Total - so we can use the .count()*/
select count(sales_qty) as "Total Transactions"
from sales.transactions;

/*Or could have even simply done THIS:*/

select count(*) as "Total Transactions"
from sales.transactions;
/*So from either one of our query (whichever one we want to use) we can conclude |Total Transactions were = 150283| */



/*2) No. of Total Records from the Customers Table:  */

select count(*) as "Number of Total Records (Customers)"
from sales.customers;
/*OR*/
select count(customer_code) as "Number of Total Records (Customers)"
from sales.customers;
/*So we can see that the Total Number of Customers in record = 38 */

/*3) We want to see Transactions only from Chennai*/

select* from sales.markets; /*Running this query must give us details about the Markets - Areas of Business*/
/*So we know now that markets_name - Chennai is associated with markets_code = Mark001 */
select* from sales.transactions;

/*So lets run our Analysis Query to find more about the transactions in Chennai*/
select*
from sales.transactions as T
join sales.markets as M on T.market_code = M.markets_code
where markets_code = 'Mark001';

/*OR could have simply done - no need for a join - but using a join gives us more info from both transactions and Markets*/
select*
from sales.transactions
where market_code = "Mark001";

/*If we wanted the total number Transactions in chennai then this we do this: */

select count(*) as "Total Transactions in Chennai"
from sales.transactions
where market_code = 'Mark001';





/*4) Now we want to know within the transactions - How many transactions have happened using USD currency*/
select*
from sales.transactions 
where currency = "USD";
/*So we know the details of the 2 transactions that took place in USD currency*/
/*AND if we strictly are looking for only the count - as in how many in total then we simply do this: */
select count(*) as "Total Number of Transactions using USD currency"
from sales.transactions
where currency = "USD";




/*5) Show Transactions only in 2020 joined with the date table*/

select* from sales.date; select* from sales.transactions;

select*
from sales.transactions as T
inner join sales.date as D on D.date = T.order_date
where D.year = 2020;

/*AND if we only want a count of how many total transactions took place only in the year 2020*/

select count(*) as "Total Transactions in Year 2020"
from sales.transactions as T 
inner join sales.date as D on D.date = T.order_date
where D.year = 2020;
/*SO WE can see that total of '21550' transactions have took place in the year of 2020*/

select*
from sales.products;

select*
from sales.markets;

select*
from sales.transactions
order by order_date desc;

/*6) We want to know total Revenue Generated in 2020 as of June*/

select sum(T.sales_amount) as "Revenue up till June 2020"
from sales.transactions as T
inner join sales.date as D on D.date = T.order_date
where D.year = 2020 and T.currency = "INR";

/*SO we know now that Total Revenue genereated in the year 2020 is = '142235559' INR - in Indian Rupees*/

/*Also the same thing we can do for the year 2019 or 2018*/
select sum(T.sales_amount) as "Total Revenue 2019"
from sales.transactions as T
inner join sales.date as D on D.date = T.order_date
where D.year = 2019 and T.currency = "INR";

select sum(T.sales_amount) as "Total Revenue 2018"
from sales.transactions as T
inner join sales.date as D on D.date = T.order_date
where D.year = 2018 and T.currency = "INR";

select sum(T.sales_amount) as "Total Revenue 2017"
from sales.transactions as T
inner join sales.date as D on D.date = T.order_date
where D.year = 2017 and T.currency = "INR";

/*SO we can see that Total Revenue (sales) have dropped from the year 2018 = '621 779' INR to 2019 = '433 012' INR */


/* 7) We want to know the Total Revenue Generated only from/in Chennai in the year 2020 */

select sum(T.sales_amount) as "Total Revenue - Chennai (2020)"
from sales.transactions as T
join sales.markets as M on M.markets_code = T.market_code
join sales.date as D on D.date = T.order_date 
where markets_code = 'Mark001' and year = 2020;

/* Total Transactions - Chennai (2020) = '2463024' */



/*8) Distinct Products sold in Chennai and we want it to be by most sold product to least sold*/

select P.product_code, M.markets_code, M.markets_name, P.product_type, sum(T.sales_amount) as "Total Sales"
from sales.transactions as T
join sales.products as P on P.product_code = T.product_code
join sales.markets as M on M.markets_code = T.market_code
where M.markets_code = "Mark001" 
group by P.product_code, P.product_type, M.markets_code
order by sum(T.sales_amount) desc;





/* 9) Finding our top 5 most Profitable Markets*/
select* from sales.customers; select* from sales.date; select* from sales.markets; select* from sales.products; select* from sales.transactions;

select  markets_name, sum(sales_amount) as "Total Sales"
from sales.transactions as T
join sales.markets as M on T.market_code = M.markets_code
group by T.market_code 
order by sum(sales_qty) desc
limit 5;


/*So our Top 5 Most Profitable Markets (in INR Currency) are: 
markets_name Total Sales
Delhi NCR	520721134
Mumbai	150180636
Nagpur	55026321
Kochi	18813466
Ahmedabad	132526737
*/


/*10) 5 of The Least Profitable Markets (in INR)*/
select M.markets_name, sum(T.sales_amount) as "Total Sales"
from sales.transactions as T
join sales.markets as M on M.markets_code = T.market_code
group by T.market_code 
order by sum(T.sales_amount) asc
limit 5;

/* 5 of The Least Profitable Markets (in INR) are: 
markets_name Total Sales
Bengaluru	373115
Bhubaneshwar	893857
Surat	2605796
Lucknow	3094007
Patna	4428393
*/





/*Knowing more about our Data before Filtering and Cleaning*/
select*
from sales.markets;

select*
from sales.transactions
where sales_amount <= 0;

select distinct currency
from sales.transactions;

/*So when we selected DISTINCT currency - rather than actually getting 1 of each distinct currencies - we have INR and USD both twice*/
/*So the result had 2 of both but when we did copy paste row then these were the results below and not INR INR or USD USD */
/*
'INR'
'INR\r'
'USD'
'USD\r'
*/
/*So this is what was creating the problem*/


/*Also when we looked at the 4 transactions that happened using USD - 2 of them were just duplicates of the 2 other previous ones.
- So really only just 2 original records using USD*/
select*
from transactions 
where currency = "USD" or currency = "USD\r";


/*Now lets count how many transactions using 'INR' or 'INR\r'*/
select count(currency = 'INR')
from transactions 
where currency = 'INR';

select count(currency = 'INR\r')
from transactions 
where currency = 'INR\r';

/*SO we can see that the transactions using USD and USD\r  are just duplicate records*/
select*
from transactions 
where currency = "USD" or currency = "USD\r";


/*So it would be beneficial/logical to keep both INR\r and USD\r currency values in our dashboard built in Power BI 
INR\r and USD\r currency values correspond to (are the same as) == [currency] = "INR#(cr)" or [currency] = "USD#(cr)" in Power BI