-- Drop tables if they already exist
--DROP TABLE IF EXISTS Accounts;
--DROP TABLE IF EXISTS AccountHolders;

-- Create AccountHolders table
CREATE TABLE AccountHolders
(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    ssn VARCHAR(10) NOT NULL
);

-- Create Accounts table
CREATE TABLE Accounts
(
    id SERIAL PRIMARY KEY,
    account_holder_id INT NOT NULL,
    balance NUMERIC(13, 2) DEFAULT 0,
    CONSTRAINT FK_Accounts_AccountHolders FOREIGN KEY (account_holder_id)
        REFERENCES AccountHolders (id)
);

-- Insert data into AccountHolders
INSERT INTO AccountHolders (id, first_name, last_name, ssn) VALUES
(1, 'Susan', 'Cane', '1234567890'),
(2, 'Kim', 'Novac', '1234567890'),
(3, 'Jimmy', 'Henderson', '1234567890'),
(4, 'Steve', 'Stevenson', '1234567890'),
(5, 'Bjorn', 'Sweden', '1234567890'),
(6, 'Kiril', 'Petrov', '1234567890'),
(7, 'Petar', 'Kirilov', '1234567890'),
(8, 'Michka', 'Tsekova', '1234567890'),
(9, 'Zlatina', 'Pateva', '1234567890'),
(10, 'Monika', 'Miteva', '1234567890'),
(11, 'Zlatko', 'Zlatyov', '1234567890'),
(12, 'Petko', 'Petkov Junior', '1234567890');

-- Insert data into Accounts
INSERT INTO Accounts (id, account_holder_id, balance) VALUES
(1, 1, 123.12),
(2, 3, 4354.23),
(3, 12, 6546543.23),
(4, 9, 15345.64),
(5, 11, 36521.20),
(6, 8, 5436.34),
(7, 10, 565649.20),
(8, 11, 999453.50),
(9, 1, 5349758.23),
(10, 2, 543.30),
(11, 3, 10.20),
(12, 7, 245656.23),
(13, 5, 5435.32),
(14, 4, 1.23),
(15, 6, 0.19),
(16, 2, 5345.34),
(17, 11, 76653.20),
(18, 1, 235469.89);
