CREATE DATABASE Market;
GO

USE Market;

CREATE TABLE Brands (
    ID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Laptops (
    ID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255),
    Price MONEY,
    BrandsID INT,
    FOREIGN KEY (BrandsID) REFERENCES Brands(ID)
);

CREATE TABLE Phones (
    ID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255),
    Price MONEY,
    BrandsID INT,
    FOREIGN KEY (BrandsID) REFERENCES Brands(ID)
);


INSERT INTO Brands (Name) VALUES
('Apple'),
('Honor'),
('Redmi'),
('Hp'),
('Samsung'),
('Brand6'),
('Brand7'),
('Brand8'),
('Brand9'),
('Brands');


INSERT INTO Laptops (Name, Price, BrandsID) VALUES
('MacBook', 999.99, 1),
('Honor', 1299.99, 2),
('Laptop3', 899.99, 3),
('HpBook', 1499.99, 4),
('Laptop5', 1099.99, 5),
('MacBook Pro Max', 799.99, 1),
('Laptop7', 1599.99, 7),
('SmartBook', 11199.99, 10),
('Laptop9', 699.99, 9),
('MacBook Pro', 1799.99, 1);


INSERT INTO Phones (Name, Price, BrandsID) VALUES
('Iphone', 519.99, 1),
('Phone2', 792.99, 2),
('Honor', 4299.99, 2),
('Phone4', 899.99, 2),
('Phone5', 699.99, 5),
('Phone6', 399.99, 6),
('Phone7', 999.99, 7),
('Phone8', 749.99, 8),
('Phone9', 349.99, 9),
('Phone10', 1099.99, 10);


SELECT 
l.Name,
b.Name AS 'BrandName',
l.Price
FROM Laptops AS l
JOIN 
Brands AS b ON l.BrandsID=b.ID 


SELECT 
p.Name,
b.Name AS 'BrandName',
p.Price
FROM Phones AS p
JOIN 
Brands AS b ON p.BrandsID=b.ID 


SELECT 
l.Name,
b.Name AS 'BrandName',
l.Price
FROM 
Laptops AS l
JOIN 
Brands AS b ON l.BrandsID=b.ID 
WHERE
b.Name LIKE '%s'

SELECT 
l.Name,
b.Name AS 'BrandName',
l.Price
FROM 
Laptops AS l
JOIN 
Brands AS b ON l.BrandsID=b.ID 
WHERE
l.price BETWEEN 2000 AND 5000 OR
l.Price >=5000

SELECT 
p.Name,
b.Name AS 'BrandName',
p.Price
FROM Phones AS p
JOIN 
Brands AS b ON p.BrandsID=b.ID 
WHERE 
p.price BETWEEN 1000 AND 1500 OR
p.Price >=1500


SELECT 
b.name,
COUNT(l.name) as 'Count'
FROM Brands as b
JOIN 
Laptops as l ON b.ID=l.BrandsID
GROUP BY
b.ID, b.Name


SELECT 
b.name as 'Brand Name ',
COUNT(p.name) as 'Count'
FROM Brands as b
JOIN 
Phones as p ON b.ID=p.BrandsID
GROUP BY
b.ID, b.Name


SELECT 
l.Name as ' Name',
p.BrandsID as 'ID'
FROM Laptops AS l
JOIN 
Phones as p on l.name =p.Name and l.BrandsID=p.BrandsID



SELECT
    b.Name AS BrandName,
    SUM(p.Price) AS TotalPrice,
    COUNT(p.ID) AS ProductCount
FROM Brands b
JOIN Phones p ON b.ID = p.BrandsID
GROUP BY b.ID, b.Name;



SELECT
    b.Name AS BrandName,
    SUM(l.Price) AS TotalPrice,
    COUNT(l.ID) AS ProductCount
FROM Brands b
JOIN Laptops l ON b.ID = l.BrandsID
GROUP BY b.ID, b.Name
HAVING COUNT(l.ID) >= 3;



SELECT
    p.ID,
    p.Name,
    p.Price,
    Brands.Name AS 'BrandName'
FROM
    Phones as p
JOIN
    Brands ON p.BrandsID = Brands.ID
WHERE
    Price > 1000
UNION ALL
SELECT
    l.ID,
    l.Name,
    l.Price,
    Brands.Name AS 'BrandName'
FROM
    Laptops AS l
JOIN
    Brands ON l.BrandsID = Brands.ID
WHERE
    Price > 1000;


SELECT
p.ID,
p.Name,
p.Price,
Brands.Name AS 'BrandName'
FROM
Phones as p
JOIN
Brands ON p.BrandsID = Brands.ID
UNION ALL
SELECT
l.ID,
l.Name,
l.Price,
Brands.Name AS 'BrandName'
FROM
Laptops AS l
JOIN
Brands ON l.BrandsID = Brands.ID



SELECT
ID,
Name,
Price,
BrandsID
FROM
Phones

UNION ALL
SELECT
ID,
Name,
Price,
BrandsID
FROM
Laptops;


