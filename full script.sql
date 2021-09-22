DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Components;

CREATE TABLE Customers (
Customer_ID VARCHAR(10),
FName VARCHAR(20),
LName VARCHAR(20) NOT NULL,
City VARCHAR(20) NOT NULL,
CONSTRAINT PK_Customers PRIMARY KEY(Customer_ID)
);

CREATE TABLE Orders (
Order_ID VARCHAR(10),
Customer_ID VARCHAR(10),
Order_Date DATE NOT NULL,
Shipped_Date DATE NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(Order_ID),
CONSTRAINT FK_Orders FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Components (
SKU_ID VARCHAR(10),
Quantity INT NOT NULL,
Price_per_unit FLOAT NOT NULL,
Purchase_Date DATE NOT NULL,
CONSTRAINT PK_Components PRIMARY KEY(SKU_ID)
);

CREATE TABLE Products (
SKU_ID VARCHAR(10),
Product_ID VARCHAR(10) UNIQUE,
Name VARCHAR(30),
Color VARCHAR(10),
Price FLOAT NOT NULL,	
CONSTRAINT PK_Products PRIMARY KEY(Product_ID, SKU_ID),
CONSTRAINT FK_Products FOREIGN KEY(SKU_ID) REFERENCES Components(SKU_ID)
);

CREATE TABLE Order_Details (
Order_ID VARCHAR(10),
Product_ID VARCHAR(10),
Quantity INT NOT NULL,
Invoice_value FLOAT NOT NULL,	
CONSTRAINT PK_OrderDetails PRIMARY KEY(Order_ID, Product_ID),
CONSTRAINT FK_OrderDetails1 FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID),
CONSTRAINT FK_OrderDetails2 FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID)	
);

INSERT INTO Customers VALUES ('A1109', 'Adam', 'Silva', 'Ottawa');
INSERT INTO Customers VALUES ('A1110', 'Paul', 'Hing', 'Toronto');
INSERT INTO Customers VALUES ('A1111', 'Jake', 'Swon', 'Montreal');
INSERT INTO Customers VALUES ('A1112', 'Liz', 'Liean', 'Vancouver');
INSERT INTO Customers VALUES ('A1113', 'Jomo', 'Jisla', 'Nepean');

INSERT INTO Orders VALUES ('13A76', 'A1109', '2021-01-11', '2021-01-16');
INSERT INTO Orders VALUES ('13A77', 'A1110', '2021-02-04', '2021-02-08');
INSERT INTO Orders VALUES ('13A78', 'A1111', '2021-02-11', '2021-02-15');
INSERT INTO Orders VALUES ('13A79', 'A1112', '2021-03-02', '2021-03-16');
INSERT INTO Orders VALUES ('13A89', 'A1113', '2021-01-18', '2021-01-22');

INSERT INTO components VALUES ('1Z4HR', '135', '5.99', '2018-01-16');
INSERT INTO components VALUES ('1X6IK', '55', '18.41', '2019-07-12');
INSERT INTO components VALUES ('5G7JJ', '31', '9.99', '2019-02-22');
INSERT INTO components VALUES ('66G7TY', '18', '17.49', '2020-02-16');
INSERT INTO components VALUES ('22S4RR', '4', '1.88', '2018-12-18');

INSERT INTO products VALUES ('1Z4HR', '988231', 'PinkHuzaah', 'Pink', 299.99);
INSERT INTO products VALUES ('1X6IK', '388723', 'BlueChill', 'Blue', 99.99);
INSERT INTO products VALUES ('5G7JJ', '488772', 'RedCherries', 'Red', 134.99);
INSERT INTO products VALUES ('66G7TY', '299338', 'GreenGoblin', 'Green', 75.99);
INSERT INTO products VALUES ('22S4RR', '488299', 'RedRum', 'Red', 99.99);

INSERT INTO order_details VALUES ('13A76', '988231', 3, 899.97);
INSERT INTO order_details VALUES ('13A77', '388723', 11, 1099.89);
INSERT INTO order_details VALUES ('13A78', '488772', 2, 269.98);
INSERT INTO order_details VALUES ('13A79', '299338', 1, 75.99);
INSERT INTO order_details VALUES ('13A89', '488299', 1, 99.99);

SELECT * FROM products;

SELECT * FROM components;

SELECT * FROM Orders;
SELECT * FROM orders where customer_id = 'A1112';

SELECT * FROM customers;
SELECT * FROM customers where city = 'Ottawa';

SELECT * FROM components;
SELECT * FROM components where sku_id = '1Z4HR';

SELECT product_id FROM products
UNION
SELECT product_ID FROM order_details;

-- Find shipments made in February 2021
CREATE VIEW Feb21Shipments AS
SELECT order_id, customer_id, shipped_date
FROM orders
WHERE shipped_date between '2021-02-01' AND '2021-02-28';

SELECT * from Feb21Shipments;

--customers who have placed orders. All registered customers have placed orders for the period under review, so should generate full list.
SELECT customers.customer_id, customers.fname
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;

--what products have I sold. All individual products have registered a sale for the period under review, so should generate full list.
SELECT order_details.product_ID
FROM order_details
RIGHT JOIN products
ON order_details.product_ID = products.product_ID;

