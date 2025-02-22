CREATE DATABASE DBTest
ON 
(NAME='DBTest',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER2012\MSSQL\Data\DBTest.mdf',
SIZE=12,
MAXSIZE=50,
FILEGROWTH=2)
LOG ON
(NAME='DBTestLog',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER2012\MSSQL\Data\DBTest.idf',
SIZE=6MB,
MAXSIZE=30MB,
FILEGROWTH=5MB);

Use DBTest;

CREATE TABLE DBTestTable (
TestID		int		IDENTITY	NOT NULL,
TestName	varchar(25)			NOT NULL	
);

ALTER TABLE DBTestTable
ADD
TestDate	datetime	NOT NULL default 2007-01-01;