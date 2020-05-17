CREATE DATABASE Accounting
ON 
(NAME='Accounting',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER2012\MSSQL\Data\Accounting.mdf',
SIZE=12,
MAXSIZE=50,
FILEGROWTH=2)
LOG ON
(NAME='AccountingLog',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER2012\MSSQL\Data\Accounting.idf',
SIZE=6MB,
MAXSIZE=30MB,
FILEGROWTH=5MB);

Use Accounting;

CREATE TABLE Customers (
CustomerNo		int	IDENTITY	NOT NULL PRIMARY KEY,
CustomerName	varchar(30)		NOT NULL,
Address1		varchar(30)		NOT NULL,
Address2		varchar(30)		NOT NULL,
City			varchar(20)		NOT NULL,
State			char(2)			NOT NULL,
Zip				varchar(10)		NOT NULL,
Contact			varchar(25)		NOT NULL,
Phone			char(15)		NOT NULL,
FedIDNo			varchar(9)		NOT NULL,
DateInSystem	smalldatetime	NOT NULL
);

CREATE TABLE Orders (
OrderID		int	IDENTITY	NOT NULL PRIMARY KEY,
CustomerNo	int				NOT NULL FOREIGN KEY REFERENCES Customers(CustomerNo),
OrderDate	smalldatetime	NOT NULL,
EmployeeID	int				NOT NULL
);

CREATE TABLE Employees (
EmployeeID		int IDENTITY NOT NULL,
FirstName		varchar(25) NOT NULL,
MiddleInitial	char(1) NULL,
LastName		varchar(25) NOT NULL,
Title			varchar(25) NOT NULL,
SSN				varchar(11) NOT NULL,
Salary			money NOT NULL,
PriorSalary		money NOT NULL,
LastRaise as Salary - PriorSalary,
HireDate		date NOT NULL,
TerminationDate date NULL,
ManagerEmpID	int NOT NULL,
Department	varchar(25) NOT NULL
);

ALTER TABLE Employees
ADD CONSTRAINT PK_EmployeeID 
PRIMARY KEY (EmployeeID);

ALTER TABLE Orders
ADD CONSTRAINT FK_EmployeeCreatesOrder
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

INSERT INTO Employees
(FirstName, LastName, Title, SSN, Salary, PriorSalary,HireDate, ManagerEmpID, Department)
VALUES(
'Billy Bob',
'Boson',
'Head Cook & Bottle Washer',
'123-45-6789',
100000,
80000,
'1990-01-01',
1,
'Cooking & Bottling');

ALTER TABLE Employees
ADD CONSTRAINT FK_EmployeeHasManager
FOREIGN KEY (ManagerEmpID) REFERENCES Employees(EmployeeID);

CREATE TABLE OrderDetails (
OrderID		int			NOT NULL,
PartNo		varchar(10)	NOT NULL,
Description	varchar(25)	NOT NULL,
UnitPrice	money		NOT NULL,
Qty			int			NOT NULL,
CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, PartNo),
CONSTRAINT FK_OrderContainsDetails FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
ON UPDATE NO ACTION
ON DELETE CASCADE
);

INSERT INTO Customers VALUES (
'Billy Bob''s Shoes',
'123 Main St.',
' ',
'Vancouver',
'WA',
'98685',
'Billy Bob',
'(360)555-1234',
'931234567',
GETDATE()
);

INSERT INTO Orders
(CustomerNo, OrderDate, EmployeeID)
VALUES
(1, GETDATE(), 1);

INSERT INTO OrderDetails 
VALUES (1, '4X4525', 'This is a part', 25.00, 2);
INSERT INTO OrderDetails 
VALUES (1, '0R2400', 'This is another part', 50.00, 2);

CREATE TABLE Shippers (
ShipperID	int	IDENTITY	NOT NULL PRIMARY KEY,
ShipperName	varchar(30)		NOT NULL,
Address		varchar(30)		NOT NULL,
City		varchar(25)		NOT NULL,
State		char(2)			NOT NULL,
Zip			varchar(10)		NOT NULL,
PhoneNo		varchar(14)		NOT NULL UNIQUE
);

/* Adding a UNIQUE KEY Constraint */
ALTER TABLE Employees ADD CONSTRAINT AK_EmployeeSSN UNIQUE (SSN)

/* Adding a CHECK Constraint */
ALTER TABLE Customers
ADD CONSTRAINT
CN_CustomerDateInSystem CHECK (DateInSystem <= GETDATE());

/* Adding a CHECK Constraint and ignoring BAD DATA */
ALTER TABLE Customers
WITH NO CHECK
ADD CONSTRAINT
CN_CustomerDateInSystem CHECK (DateInSystem <= GETDATE());