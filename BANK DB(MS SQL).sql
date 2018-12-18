CREATE DATABASE bankDB;
USE bankDB;
CREATE TABLE bank(
	name VARCHAR(50) NOT NULL,
    BCode INT PRIMARY KEY IDENTITY,
    Address VARCHAR(50) NOT NULL,
    UNIQUE(name, Address)
);
INSERT INTO bank(Name, Address) VALUES ('BANK MISR', '23 Talat Harb ST.');

CREATE TABLE bank_branch(
	BranchNo INT PRIMARY KEY IDENTITY,
    BranchAddress VARCHAR(50) NOT NULL,
    BCode INT NOT NULL,
    FOREIGN KEY(BCode) REFERENCES bank(BCode)
    ON UPDATE CASCADE
);
INSERT INTO bank_branch(BranchAddress, BCode) VALUES 
('Qism El-Salam', '1'),
('Qism El-Nozha', '1'),
('Al Khankah', '1'),
('Shibin Al Qanater', '1');

CREATE TABLE loan(
	LoanID INT PRIMARY KEY IDENTITY,
	Type VARCHAR(50) NOT NULL,
    Amount INT NOT NULL,
    Date DATE NOT NULL,
    BranchNo INT,
    FOREIGN KEY(BranchNo) REFERENCES bank_branch(BranchNo)
);
INSERT INTO loan(Type, Amount, Date, BranchNo) VALUES 
('The Mortgage Loan', '1000', '2015-05-12', 1),
('Auto Loan', '2000', '2017-03-19', 2),
('Durable Good Loans', '3000', '2018-12-20', 3),
('Personal Loan', '4000', '2013-04-11', 4),
('Tourism loans', '5000', '2018-02-16', 2),
('Hajj and Umrah loan', '6000', '2012-06-12', 3),
('Education Loan', '7000', '2015-08-16', 1);

CREATE TABLE employee(
	EmpID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(7) NOT NULL,
    EmpAddress VARCHAR(50) NOT NULL,
    BCode INT NOT NULL,
    FOREIGN KEY(BCode) REFERENCES bank(BCode)
    ON UPDATE CASCADE,
    BranchNo INT,
    FOREIGN KEY(BranchNo) REFERENCES bank_branch(BranchNo),
    MgrID INT,
    FOREIGN KEY(MgrID) REFERENCES employee(EmpID)
);
INSERT INTO employee(FirstName, LastName, Gender, EmpAddress, BCode, BranchNo, MgrID) VALUES 
('Shehab', 'Nagy', 'Male', 'Cairo', 1, 1, NULL),
('Shorouk', 'Gamal', 'Female', 'Marsa Matrouh', 1, 2, 1),
('Saad', 'Tarek', 'Male', 'Cairo', 1, 3, 1),
('Amr', 'Mohamed', 'Male', 'Banhaa', 1, 2, 1),
('Asmaa', 'Ahmed', 'Female', 'Al-Sharqya', 1, 3, 1),
('Lojuin', 'El-Saied', 'Female', 'Cairo', 1, 3, 1);

CREATE TABLE client(
	CID DECIMAL(14, 0) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(7) NOT NULL,
    OpenBalance DECIMAL(10,2) NOT NULL,
    Balance DECIMAL(10,2) NOT NULL,
    MonthlyPay DECIMAL(10,2) NOT NULL,
    DOB DATE NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Status VARCHAR(15) NOT NULL,
    Job VARCHAR(50) NOT NULL,
    Phone DECIMAL(14, 0) NOT NULL
);
INSERT INTO client(CID, FirstName, LastName, Gender, OpenBalance, Balance, MonthlyPay, DOB, Country, Status, Job, Phone) VALUES 
(12345678932145, 'Ahmed', 'Mohamed', 'Male', 1000, 1000, 2000, '1998-5-4', 'Egypt', 'Married', 'Engineer', 01064264908),
(13245679456987, 'Mohamed', 'Saber', 'Male', 1000, 1000, 1000, '1956-2-3', 'Egypt', 'Married', 'Engineer', 01064224940),
(65465468798798, 'Bassel', 'Nagy', 'Male',  3000, 3000, 5000, '1948-5-1', 'Egypt', 'Single', 'Doctor', 01064223408),
(65489486458489, 'Adam', 'Mohamed', 'Male', 1000, 1000, 2000, '1957-5-2', 'USA', 'Married', 'Student', 01064556508),
(65465487987884, 'Shams', 'Ahmed', 'Female', 3000, 3000, 2000, '1963-5-20', 'USA', 'Divorced', 'Student', 01064123908);


CREATE TABLE borrow(
	LoanID INT,
    CID DECIMAL(14, 0),
    FOREIGN KEY(LoanID) REFERENCES loan(LoanID)
    ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY(CID) REFERENCES client(CID)
    ON UPDATE CASCADE ON DELETE SET NULL
);
INSERT INTO borrow(CID, LoanID) VALUES 
(12345678932145,1),
(13245679456987,2),
(13245679456987,3),
(65465468798798,4),
(65465468798798,5),
(65465468798798,6),
(65465487987884,7);