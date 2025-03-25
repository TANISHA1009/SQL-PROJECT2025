--create database
CREATE DATABASE OnlineBookstores;

--create Tables
Create Table Books(
Book_ID	SERIAL PRIMARY KEY, 
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(100),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);

CREATE TABLE Customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone INT,
City VARCHAR(100),
Country VARCHAR(100)
);

CREATE TABLE ORDERS(
Order_ID SERIAL PRIMARY KEY,
Customer_ID	INT REFERENCES Customers(Customer_ID),
Book_ID	INT REFERENCES Books(Book_ID),
Order_Date Date,
Quantity INT,
Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM ORDERS;

--IMPORT DATA FROM INTO BOOKS TABLE
--RIGHT CLICK ON TABLE<IMPORT DATA<SELECT FILE<OK<RUN COMMAND SELECT *FROM BOOKS AND DATA WILL BE IMPORTED

--IMPORT DATA INTO CUSTOMERS TABLE
--RIGHT CLICK ON TABLE<IMPORT DATA<SELECT FILE<OK<RUN COMMAND SELECT *FROM CUSTOMERS AND DATA WILL BE IMPORTED

--IMPORT DATA INTO ORDERS TABLE
--RIGHT CLICK ON TABLE<IMPORT DATA<SELECT FILE<OK<RUN COMMAND SELECT *FROM BOOKS AND DATA WILL BE IMPORTED

--(1) Retrive all books in the "fiction" genre.
select * from books
where genre='Fiction';

--(2) find books published after the year 1950.
select * from books
where published_year>1950;

--(3)list all the customers from canada.
select * from Customers
where country='Canada';

--(4)show orders placed in November 2023.
select * from ORDERS
where order_date between '2023-11-01' and '2023-11-30';

--(5)Retrive the total stock of books available.
SELECT SUM(stock) as total_stock
from Books;

--(6) fins the details of the most expensive book.
select * from books
order by price desc limit 1;

--(7) show all the customers who ordered more than 1 quantity of book.
select * from ORDERS
WHERE quantity>1;

--(8) Retrive all orders where the total amount exceeds $20;
select * from ORDERS
WHERE total_amount>20;

--(9)list all genres available in the books table.
select distinct genre from books;

--(10) find the book with the lowest stock.
select * from Books order by stock;

--(11)calculate the total revenue generated from all orders.
select sum(total_amount) as total_revenue
from ORDERS;


--(12) RETRIVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE.
select * from orders;
select * from books;

select b.genre,sum(o.quantity) as total_book_sold
from ORDERS o
join
Books b on o.book_id=b.book_id
group by b.genre;

--(13) find average price of books in the 'Fantasy' genre.
select avg(price) as average_price
from Books
where genre='Fantasy';

--(14) list customers who have placed at least 2 orders.
select o.customer_id,c.name,count(o.order_id) as order_count
from ORDERS o
join Customers c on c.customer_id=o.customer_id
group by o.customer_id,c.name
having count(order_id)>=2;

--(15) find the most frequently ordered book.
select o.book_id,b.title,count(o.order_id) as order_count
from ORDERS o
join
Books b on o.book_id=b.book_id
GROUP BY o.book_id,b.title
order by order_count desc;


--(16) show top 3 most expensive books of 'Fantasy' genre.
select * from books
where genre='Fantasy'
order by price desc limit 3;

--(17) Retrieve the total quantity of books sold by each author.
select b.author,sum(o.quantity) as total_books_sold
from ORDERS o
join Books b on b.book_id=o.book_id
group by b.author;

--(18) list the cities where customers who spent over $30 are located.
select distinct c.city,o.total_amount
from ORDERS o
join Customers c on c.customer_id=o.customer_id
where o.total_amount>=30;

--(19)find the customers who spent the most on orders.
select c.customer_id,c.name,sum(o.total_amount) as total_spent
from ORDERS o
JOIN Customers c on c.customer_id=o.customer_id
group by c.customer_id,c.name
order by total_spent desc limit 1;

--(20) calculate the stock remaining after fufilling all orders.
select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as order_quantity,
b.stock-coalesce(sum(o.quantity),0) as remaining_quantity
from Books b
left join orders o on b.book_id=o.book_id
group by b.book_id order by b.book_id;










