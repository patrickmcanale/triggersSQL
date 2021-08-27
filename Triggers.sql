USE KinetEcoTRG;
GO

--create table

CREATE TABLE dbo.Products (
    ProductID int PRIMARY KEY,
    ProductName nvarchar(50)
);
GO

--insert into table

INSERT INTO dbo.Products
VALUES
   (5, 'D Battery'), (6, 'AA Rechargeable Battery');
GO

--create trigger 

CREATE TRIGGER dbo.ProductMessage
ON kinetecotrg.dbo.Products
AFTER INSERT
AS
PRINT 'New product data has been inserted.'
;
GO

SELECT * FROM dbo.Products;

--drop trigger

DROP TRIGGER IF EXISTS dbo.ProductMessage;

--create new table

CREATE TABLE dbo.Customers (
    CustomerID int PRIMARY KEY,
    CustomerName nvarchar(50),
    LastModified datetime2
);
GO

--create trigger fetch date from temporary table "inserted"

CREATE OR ALTER TRIGGER dbo.CustomersModified
ON dbo.Customers
AFTER INSERT, UPDATE
AS
UPDATE dbo.Customers
  SET LastModified = GETDATE()
  FROM Inserted
  WHERE dbo.Customers.CustomerID = Inserted.CustomerID
;
GO

--new row

INSERT INTO dbo.Customers (CustomerID, CustomerName)
VALUES
   (1, 'Adam')
;
GO

SELECT * FROM dbo.Customers;

--using update

UPDATE dbo.Customers
SET CustomerName = 'Alan'
WHERE CustomerID = 1
;
GO

--using multiple values

INSERT INTO dbo.Customers (CustomerID, CustomerName)
VALUES
   (2, 'Chandra'), (3, 'Madelynn');
GO

--new table

CREATE TABLE dbo.AccountsPayable (
    AccountID int PRIMARY KEY,
    AccountNumber nvarchar(20)
);
GO

--insert values
INSERT INTO dbo.AccountsPayable VALUES
    (1, '98016'), (2, '32408'), (3, '32984')
;
GO

SELECT * FROM dbo.AccountsPayable;
GO

--create trigger when delete command is fired

CREATE OR ALTER TRIGGER dbo.AccountsDelete
ON dbo.AccountsPayable
INSTEAD OF DELETE
AS
--PRINT "can say something here"
ROLLBACK
;
GO

DELETE FROM dbo.AccountsPayable
WHERE AccountID = 1;
GO


