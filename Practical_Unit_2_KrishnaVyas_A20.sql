DROP TABLE IF EXISTS CourseInstructors;
DROP TABLE IF EXISTS StudentCourses;
DROP TABLE IF EXISTS StudentCoursesWithInstructor;
DROP TABLE IF EXISTS Orders3NF;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Orders2NF_Transitive;
DROP TABLE IF EXISTS Orders2NF;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders1NF;
DROP TABLE IF EXISTS CustomerProducts;
DROP TABLE IF EXISTS Purchases;

CREATE TABLE Purchases (
    CustomerID INT,
    CustomerName VARCHAR(100),
    PurchasedProducts VARCHAR(255)
);

INSERT INTO Purchases (CustomerID, CustomerName, PurchasedProducts) VALUES
    (101, 'John Doe', 'Laptop, Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (103, 'Alice Brown', 'Keyboard, Monitor, Pen');

CREATE TABLE CustomerProducts (
    CustomerID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO CustomerProducts (CustomerID, CustomerName, Product) VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (103, 'Alice Brown', 'Keyboard'),
    (103, 'Alice Brown', 'Monitor'),
    (103, 'Alice Brown', 'Pen');

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Alice Brown');

CREATE TABLE Orders2NF (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders2NF (OrderID, CustomerID, Product) VALUES
    (201, 101, 'Laptop'),
    (202, 101, 'Mouse'),
    (203, 102, 'Tablet'),
    (204, 103, 'Keyboard');

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100)
);

INSERT INTO Suppliers (SupplierID, SupplierName) VALUES
    (401, 'HP'),
    (402, 'Logitech'),
    (403, 'Apple'),
    (404, 'Dell');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

INSERT INTO Products (ProductID, ProductName, SupplierID) VALUES
    (301, 'Laptop', 401),
    (302, 'Mouse', 402),
    (303, 'Tablet', 403),
    (304, 'Keyboard', 404);

CREATE TABLE Orders3NF (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders3NF (OrderID, CustomerID, ProductID) VALUES
    (201, 101, 301),
    (202, 101, 302),
    (203, 102, 303),
    (204, 103, 304);

CREATE TABLE StudentCourses (
    StudentID INT,
    Course VARCHAR(100),
    PRIMARY KEY (StudentID, Course)
);

CREATE TABLE CourseInstructors (
    Course VARCHAR(100) PRIMARY KEY,
    Instructor VARCHAR(100)
);

INSERT INTO StudentCourses (StudentID, Course) VALUES
    (1, 'Math'),
    (2, 'Math'),
    (3, 'History'),
    (4, 'History');

INSERT INTO CourseInstructors (Course, Instructor) VALUES
    ('Math', 'Dr. Smith'),
    ('History', 'Dr. Jones');
