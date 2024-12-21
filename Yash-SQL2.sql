
##Que 1. Create a table called employees with the following structure?

#Ans .-- create database office;
create table employees  (emp_id char (30) primary key , 
emp_name varchar (30) not null, 
age int CHECK (Age>=18) ,
email varchar(30) unique
, salary varchar(30) default("30.000")) ;
select *from employees;   ##If you run this query you can see the table with this constraints but the vlaues are null

#Que 2 Explain the purpose of constraints and how they help maintain data integrity in a database. Provide eamples of common types of constraints.
#Ans. #Purpose of Constraints in a Database:
#Constraints in a database are rules enforced on the data in tables to ensure the accuracy, validity, and integrity of the data. By restricting
#the type of data that can be stored or the relationships
# between tables, constraints help maintain the consistency and reliability of the database. They prevent invalid data entry, ensure relationships between data are meaningful, and facilitate efficient
#query execution.

#Types of constraints with thier examples are 

#1. CHECK Constraint: CHECK Constraint: Ensures the condition specified within the parentheses is met for the column.
#olumn-level CHECK: You can also define the CHECK constraint directly within the column definition:

#Example 
CREATE TABLE Persons (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT chk_age CHECK (age >= 18)
);   ##This is will make sure that every peroson age in the data base is alteast greater than or equat to 18

#2. NOT NULL Constraint: Ensures that a column cannot have a NULL value.

CREATE TABLE Employees (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL
); ## It Ensures every employee has an ID and name.

#3. UNIQUE Constraint: Ensures that all values in a column or a combination of columns are unique.

CREATE TABLE Users (
    email VARCHAR(255) UNIQUE,
    username VARCHAR(50) UNIQUE
); #It will make sure that Prevents duplicate email addresses or usernames.

#4 .PRIMARY KEY Constraint: Combines the NOT NULL and UNIQUE constraints to uniquely identify a row in a table.


-- Create a table with a Primary Key constraint
CREATE TABLE Customers (
    CustomerID INT NOT NULL PRIMARY KEY,  -- Primary Key Constraint
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100)
);

#5 Default Constraint

#Assigns a default value to a column if no value is provided during an insert operation.
#Example: A Status column in a Tasks table with a default value of 'Pending'.

-- Create a table with a DEFAULT constraint
-- Create a table with a DEFAULT constraint
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,                 -- Primary Key
    TaskName NVARCHAR(100) NOT NULL,        -- Task Name (mandatory)
    Status NVARCHAR(20) DEFAULT 'Pending',  -- Default value is 'Pending'
    CreatedDate DATE DEFAULT GETDATE()      -- Default value is the current date
);

-- Insert data without specifying the Status and CreatedDate
INSERT INTO Tasks (TaskID, TaskName)
VALUES (1, 'Complete project documentation');

-- Insert data by overriding the default values
INSERT INTO Tasks (TaskID, TaskName, Status, CreatedDate)
VALUES (2, 'Review code', 'In Progress', '2024-12-15');

-- Select data to see the effect of the DEFAULT constraint
SELECT * FROM Tasks;

# 6. Foreign Key Constraint

#Ensures that values in one table correspond to valid entries in another table, maintaining referential integrity.
#Example: A ProductID in an Orders table must match a valid ProductID in the Products table.

-- Create Customers Table (Parent Table)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Primary Key
    CustomerName VARCHAR(100) NOT NULL
);

-- Create Orders Table (Child Table)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,         -- Primary Key
    OrderDate DATE NOT NULL,
    CustomerID INT,                  -- Foreign Key Column
    FOREIGN KEY (CustomerID)         -- Define Foreign Key
        REFERENCES Customers(CustomerID) -- Link to Customers Table
        ON DELETE CASCADE             -- Delete orders if the customer is deleted
        ON UPDATE CASCADE             -- Update CustomerID in Orders if changed in Customers
);

#Que 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
#your answer ?

#Ans. The NOT NULL constraint is applied to a column to ensure that it cannot contain NULL (empty or undefined) values. This constraint is essential in cases where data is mandatory and the absence of a value would be illogical or lead to incomplete information.

#Reasons to Use NOT NULL
#Data Integrity: Ensures critical fields always have valid data.

#Example: A username column in a Users table should never be left empty.
#Logical Consistency: Prevents invalid scenarios due to missing values.

#Example: A price column in a Products table must always have a valid value.
#Query Optimization: Indexing and performance may improve because the database doesn't need to account for NULL values in the column.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL
);
#In this example, the FirstName, LastName, and HireDate columns cannot have empty values.


#No, a primary key cannot contain NULL values.

#Justification
#Definition of a Primary Key:

#A primary key is used to uniquely identify each row in a table.
#For a row to be uniquely identifiable, the primary key value must exist and be distinct.
#Behavior of NULL:

#NULL represents an unknown or undefined value, which violates the principle of uniqueness and consistency required by a primary key.
#Database Enforcement:

#Most database systems enforce the NOT NULL constraint automatically on columns designated as primary keys.

#Que 4 Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
#example for both adding and removing a constraint.?

#Ans . Steps to Add or Remove Constraints on an Existing Table
#1. Adding Constraints
#To add a constraint to an existing table, use the ALTER TABLE statement with the appropriate ADD CONSTRAINT clause.

Steps
#1. the table and column where the constraint needs to be added.
#2. Use the ALTER TABLE statement to define and add the constraint.
#3. Specify the type of constraint (NOT NULL, UNIQUE, CHECK, FOREIGN KEY, etc.) and its definition.
#Example: Adding a Foreign Key Constraint
-- Step 1: Create the parent table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 2: Create the child table without the foreign key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT
);

-- Step 3: Add the foreign key constraint to link Orders with Customers
ALTER TABLE Orders
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

#2. Removing Constraints
#To remove a constraint, use the ALTER TABLE statement with the DROP CONSTRAINT clause. Note that the exact syntax may vary slightly depending on the database system.

#Steps
#Identify the table and constraint to be removed.
#Use the ALTER TABLE statement with the DROP CONSTRAINT clause, specifying the constraint name.
#Example: Removing a Foreign Key Constraint
-- Step 1: Drop the foreign key constraint
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomerID;

-- Step 2: Verify that the constraint is removed
DESCRIBE Orders; -- Check the schema of the table (specific command depends on the database system)

#Que 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
#Provide an example of an error message that might occur when violating a constraint.

#Ans. Consequences of Violating Constraints in a Database
#When attempting to insert, update, or delete data in a way that violates constraints, the database management system (DBMS) enforces the 
#rules set by the constraints and generates an error. This prevents the operation from completing, ensuring that data integrity is maintained.

#Types of Violations and Their Consequences
#1. Violating a NOT NULL Constraint
#Cause: Attempting to insert or update a NULL value into a column with a NOT NULL constraint.
#Consequence: The database rejects the operation, as a mandatory field cannot be left empty.
#Example:
INSERT INTO Employees (EmployeeID, LastName)
VALUES (1, NULL);
ERROR: Column 'LastName' cannot be null

#2.Violating a UNIQUE Constraint
#Cause: Attempting to insert or update a value that duplicates an existing value in a column with a UNIQUE constraint.
#Consequence: The database rejects the operation, preventing duplicate data.
#Example INSERT INTO Users (UserID, Email)
VALUES (101, 'user@example.com');  -- First insertion is successful

INSERT INTO Users (UserID, Email)
VALUES (102, 'user@example.com');  -- Duplicate email violates UNIQUE constraint

ERROR: Duplicate entry 'user@example.com' for key 'Users.Email'

#3. . Violating a FOREIGN KEY Constraint
#Cause: Attempting to insert or update a foreign key value that does not match a primary key in the referenced table, or deleting a referenced primary key.
#Consequence: The database rejects the operation, ensuring referential integrity.

INSERT INTO Orders (OrderID, CustomerID)
VALUES (1, 999);  -- CustomerID 999 does not exist in the Customers table


ERROR: Foreign key constraint failed

#4.  Violating a CHECK Constraint
#Cause: Inserting or updating a value that fails to satisfy a condition defined by a CHECK constraint.
#Consequence: The database rejects the operation to prevent invalid data entry.
#Example:

INSERT INTO Products (ProductID, Price)
VALUES (101, -50);  -- Negative price violates CHECK constraint


ERROR: CHECK constraint failed: Products.Price > 0

#5 .Violating a PRIMARY KEY Constraint
#Cause: Inserting duplicate values or NULL into a column defined as a primary key.
#Consequence: The database rejects the operation because primary keys must be unique and not null.
#Example

INSERT INTO Orders (OrderID, OrderDate)
VALUES (1, '2024-12-01');  -- First insertion

INSERT INTO Orders (OrderID, OrderDate)
VALUES (1, '2024-12-02');  -- Duplicate OrderID

#ERROR: Duplicate entry '1' for key 'Orders.PRIMARY'

#Key Takeaways
#Purpose of Errors: These errors serve to uphold the rules defined by constraints, ensuring the database remains consistent and reliable.
#Action Required: When an error occurs, the user must correct the operation to align with the constraints (e.g., fixing invalid data or
#updating related records).

#6. You created a products table without constraints as follows:

#CREATE TABLE products (

    #product_id INT,

    #product_name VARCHAR(50),

    #price DECIMAL(10, 2));  
#Now, you realise that?
#: The product_id should be a primary keyQ
#: The price should have a default value of 50.00

	
create database product;
create table products (product__id int , product_name varchar(50),
price_of_product decimal (10,2));

#Now we adding the constraints 

alter table products 
add primary key(product__id);

alter table products
alter column  price_of_product set default ("50.00");

#Que 7. You have two tables?

#Ans
create database school;
create table students
(student_id char (30), student_name varchar(50) ,class_id int );

insert into students (student_id , student_name ,class_id)
 values ("1" ,"Alice" ,"101"),
("2","Bob","102"),
("3","chalrie","101");
select*from students;

create table classes
(class_id char (30) , class_name varchar(30));

insert into classes (class_id, class_name)
values ("101" ,"maths") ,
("102","science"), 
("103","history");

select student_name, student_id from students inner join classes 
on students.class_id = classes.class_id;

#Que 8 .Consider the following three tables:

drop database xyz_manf;

create database xyz_manf;    #crate table order 
CREATE TABLE Orders_1 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);

INSERT INTO Orders_1 (order_id, order_date, customer_id)
VALUES (1, '2024-01-01', 101),
       (2, '2024-01-03', 102);
       
#2. Create Customers Table and Insert Data

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO Customers ( customer_id, customer_name)
VALUES (101, 'Alice'),
       (102, 'Bob');
       
#3. Create Products Table and Insert Data

CREATE TABLE Products_1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    order_id INT NULL
);

INSERT INTO Products_1 (product_id, product_name, order_id)
VALUES (1, 'Laptop', 1),
       (2, 'Phone', NULL);
       
select*from orders_1;
select*from Customers;
select*from products_1;

select order_id,customer_name from  orders_1 inner join 
Customers on orders_1.customer_id = Customers.customer_id;

#Que 9. Given the following tables:

#Ans. 

create database laptop_shope;
CREATE TABLE Sales_1 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10, 2)
);

INSERT INTO Sales_1 (sale_id, product_id, amount)
VALUES 
    (1, 101, 500),
    (2, 102, 300),
    (3, 101, 700);
    
CREATE TABLE Products_500 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

INSERT INTO Products_500 (product_id, product_name)
VALUES 
    (101, 'Laptop'),
    (102, 'Phone');
    
select sum(amount) as Sum_of_amount,product_name from Sales_1 inner join
Products_500 on Products_500.product_id = Sales_1.product_id
group by product_name;

#Que 10 . You are given three tables:?

#Ans. 

create database Que_10l;
create table order_10 (order_id int primary key , 
order_date char (30) , cx_id varchar (30) );

insert into order_10 values ("1" , "2024-01-02", "1"),
("2" , "2024-01-05", "2");

CREATE TABLE Customers_10 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO Customers_10 (customer_id, customer_name)
VALUES 
    (1, 'Alice'),
    (2, 'Bob');
    
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO Order_Details (order_id, product_id, quantity)
VALUES 
    (1, 101, 2),
    (1, 102, 1),
    (2, 101, 3);

select order_id,customer_name,sum(quantity) as Each_cm from order_10
inner join
Customers_10 on order_10.customer_id = Customers_10.customer_id
inner join 
Order_Details on Order_Details.order_id = order_10.order_id
group by
order_id, customer_name;	


    




 
       

       


       












       
	



















