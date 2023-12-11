CREATE DATABASE Library

GO

USE Library

CREATE TABLE Books (
  ID INT IDENTITY PRIMARY KEY,
  Name VARCHAR(100) CHECK (LEN(Name) >= 2 AND LEN(Name) <= 100) NOT NULL,
  PageCount INT CHECK (PageCount>=10) NOT NULL
);

CREATE TABLE Authors(
  ID int IDENTITY PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Surname VARCHAR(255)NOT NULL
);

CREATE TABLE BooksAndAuthors (
  ID INT IDENTITY PRIMARY KEY,
  BookID INT FOREIGN KEY REFERENCES BOOKS(ID),
  AuthorID INT FOREIGN KEY REFERENCES AUTHORS(ID)
);


INSERT INTO Books (Name, PageCount) VALUES
('Book1', 150),
('Book2', 120),
('Book3', 80),
('Book4', 200),
('Book5', 95),
('Book6', 110),
('Book7', 130),
('Book8', 70),
('Book9', 180),
('Book10', 105),
('Book11', 200);


INSERT INTO Authors (Name, Surname) VALUES
('Author1', 'Surname1'),
('Author2', 'Surname2'),
('Author3', 'Surname3'),
('Author4', 'Surname4'),
('Author5', 'Surname5'),
('Author6', 'Surname6'),
('Author7', 'Surname7'),
('Author8', 'Surname8'),
('Author9', 'Surname9'),
('Author10', 'Surname10');

INSERT INTO BooksAndAuthors (BookID, AuthorID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11,4);

GO

CREATE VIEW Books_view AS
select
b.ID,
b.Name AS BookName,
b.PageCount,
a.Name+' '+a.Surname  AS AuthorFullName
from Books as b
JOIN
    BooksAndAuthors AS ba ON b.ID = ba.BookID
JOIN
    Authors AS a ON ba.AuthorID = a.ID;

GO

--select * from Books_view

GO

CREATE PROCEDURE SelectAuthor @AuthorName nvarchar(255)
AS
SELECT * FROM Books_view WHERE AuthorFullName LIKE @AuthorName + '%';

GO

--SelectAuthor @AuthorName = 'Author2';

Go

CREATE PROCEDURE InsertAuthor
@Name NVARCHAR(255),
@Surname NVARCHAR(255)
AS
BEGIN
INSERT  Authors (Name, Surname)
VALUES (@Name, @Surname);
END;

GO

CREATE PROCEDURE UpdateAuthor
@AuthorID INT,
@Name NVARCHAR(255),
@Surname NVARCHAR(255)
AS
BEGIN
UPDATE Authors
SET Name = @Name,
Surname = @Surname
WHERE ID = @AuthorID;
END;

GO

CREATE PROCEDURE DeleteAuthor
@AuthorID INT
AS
BEGIN
DELETE FROM Authors
WHERE ID = @AuthorID;
END;

GO

CREATE VIEW Authors_view AS
SELECT 
a.ID AS AuthorID,
a.Name+' '+a.Surname  AS AuthorFullName,
COUNT(bv.ID) AS BooksCount,
SUM(bv.PageCount) AS OverallPageCount
from Authors as a 
JOIN
BooksAndAuthors AS ba ON a.ID = ba.AuthorID
JOIN
Books_view AS bv ON ba.BookID = bv.ID
GROUP BY
a.ID, a.Name, a.Surname;

GO

--select * from Authors_view
