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

USE DBTest;

CREATE TABLE Professor (
	professor_id	char(7)		NOT NULL	PRIMARY KEY,
	LName			varchar(25)	NOT NULL,
	FName			varchar(25)	NOT NULL,
	Email			varchar(25)	NOT NULL,
	Phone			char(12)	NULL
);

CREATE TABLE Student (
	Student_id		char(11)	NOT NULL	PRIMARY KEY,
	LName			varchar(25)	NOT NULL,
	FName			varchar(25)	NOT NULL,
	Email			varchar(25)	NOT NULL
);

CREATE TABLE Class (
	course_no		char(6)		NOT NULL	PRIMARY KEY,
	class_name		varchar(25)	NOT NULL,
	Student_id      char(11)	NOT NULL
);

CREATE TABLE Class_Details (
	class_name		varchar(25)	NOT NULL	PRIMARY KEY,
	professor_id	char(7)		NOT NULL,
	class_time		varchar(15)	NOT NULL,
	location		varchar(15)	NOT NULL
);

ALTER TABLE Class
ADD CONSTRAINT FK_StudentAttending
FOREIGN KEY (student_id) REFERENCES Student(student_id);

ALTER TABLE Class_Details
ADD CONSTRAINT FK_ProfessorTeaching
FOREIGN KEY (professor_id) REFERENCES Professor(professor_id);

ALTER TABLE Class
ADD CONSTRAINT FK_Class
FOREIGN KEY (class_name) REFERENCES Class_Details(class_name);