CREATE TABLE bank(
	code INT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    PRIMARY KEY(code),
    UNIQUE(name, address)
);


CREATE TABLE bank_branch(
	branch_no INT NOT NULL,
    address VARCHAR(50) NOT NULL,
    bank_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(branch_no, bank_name),
    UNIQUE(branch_no, address),
    FOREIGN KEY(bank_name) REFERENCES bank(name)
    ON UPDATE CASCADE
);

