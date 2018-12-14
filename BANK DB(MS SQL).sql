CREATE DATABASE bankDB;
use bankDB;
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
    Gender CHAR(1) NOT NULL,
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
('Shehab', 'Nagy', 'M', 'Cairo', 1, 1, NULL),
('Shorouk', 'Gamal', 'F', 'Marsa Matrouh', 1, 2, 1),
('Saad', 'Tarek', 'M', 'Cairo', 1, 3, 1),
('Amr', 'Mohamed', 'M', 'Banhaa', 1, 2, 1),
('Asmaa', 'Ahmed', 'F', 'Al-Sharqya', 1, 3, 1),
('Lojuin', 'El-Saied', 'F', 'Cairo', 1, 3, 1);

CREATE TABLE client(
	CID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    OpenBalance DECIMAL(10,2) NOT NULL,
    MonthlyPay DECIMAL(10,2) NOT NULL
);
INSERT INTO client(FirstName, LastName, Gender, OpenBalance, MonthlyPay) VALUES 
('Ahmed', 'Mohamed', 'M', 1000, 2000),
('Mohamed', 'Saber', 'M', 1000, 1000),
('Bassel', 'Nagy', 'M', 3000, 5000),
('Adam', 'Mohamed', 'M', 1000, 2000),
('Shams', 'Ahmed', 'F', 3000, 2000);

CREATE TABLE account(
	AccountNo INT PRIMARY KEY IDENTITY,
    AccountPassword VARCHAR(50) NOT NULL,
	Type VARCHAR(50) NOT NULL,
    Balance DECIMAL(10,2) NOT NULL,
    BranchNo INT,
    FOREIGN KEY(BranchNo) REFERENCES bank_branch(BranchNo)
);
INSERT INTO account(AccountPassword, Type, Balance, BranchNo) VALUES 
('08F49E3F08D', 'Current Account', 1000, 1),
('E32B6232095', 'Current Account', 4000, 3),
('95BA5CF608D', 'Saving Account', 2000, 2),
('65A6D06208F', 'Saving Account', 1000, 4),
('9185C4B40E8', 'Deposit Account', 3000, 3),
('2B9990470DC', 'Deposit Account', 8000, 2),
('A669C79B0BA', 'Certifi​cates​', 10000, 2);

CREATE TABLE has(
	CID INT NOT NULL,
    AccountNo INT NOT NULL,
    PRIMARY KEY(CID, AccountNo),
    FOREIGN KEY(CID) REFERENCES client(CID)
    ON UPDATE CASCADE,
    FOREIGN KEY(AccountNo) REFERENCES account(AccountNo)
    ON UPDATE CASCADE
);
INSERT INTO has(CID, AccountNo) VALUES 
(1,1),
(2,2),
(2,3),
(3,4),
(3,5),
(3,6),
(4,7);

CREATE TABLE borrow(
	LoanID INT,
    CID INT,
    FOREIGN KEY(LoanID) REFERENCES loan(LoanID)
    ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY(CID) REFERENCES client(CID)
    ON UPDATE CASCADE ON DELETE SET NULL
);
INSERT INTO borrow(CID, LoanID) VALUES 
(1,1),
(2,2),
(2,3),
(3,4),
(3,5),
(3,6),
(4,7);