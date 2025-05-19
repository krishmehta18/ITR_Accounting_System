CREATE DATABASE ITR_Accounting_System;
SHOW DATABASES;
USE ITR_Accounting_System;

CREATE TABLE Bank(Bank_Name varchar(25), Bank_ID int primary key, Number_of_branches int, Total_acc_holders int);

CREATE TABLE Documents (
    Pan_number varchar(20) primary key,
    Passport_number varchar(20),
    Aadhar_Number varchar(20)
);

CREATE TABLE Customers (
    User_name varchar(20),
    User_ID varchar(20) primary key,
    Nationality varchar(20),
    Income int,
    Pan_number varchar(20),
    foreign key (Pan_number) references Documents(Pan_number)
);

CREATE TABLE Branch (
    Address varchar(60),
    Accs_opened int,
    Assets_managed int,
    Bank_ID int,
    IFSC_code varchar(20) primary key,
    foreign key (Bank_ID) references Bank(Bank_ID)
);

CREATE TABLE Accounts (
    Account_type varchar(20),
    Accs_ID int primary key,
    Pan_number varchar(20),
    Acc_holder_type varchar(20),
    Alternate_ID varchar(20),
    Balance int,
    passcode varchar(20),
    IFSC_code varchar(20),
    foreign key (IFSC_code) references Branch(IFSC_code),
    foreign key (Pan_number) references Documents(Pan_number)
);

CREATE TABLE Transactions (
	Transaction_ID varchar(20) primary key,
    Creditor int,
    Debitor int,
    Mode_of_Payment varchar(20),
    dot date not null,
    time_of_payment time not null,
    Purpose varchar(30),
    Pan_number varchar(20),
    foreign key (Creditor) references Accounts(Accs_ID),
    foreign key (Debitor) references Accounts(Accs_ID),
    foreign key (Pan_number) references Documents(Pan_number)
);

CREATE TABLE Investments(
    User_ID varchar(20),
    Amount int,
    Period_of_maturity date not null,
    dot date not null,
    Company varchar(10),
    IFSC_code varchar(20),
    Transaction_ID varchar(20),
	Category varchar(10),
    Number_of_shares int,
    Pan_number varchar(20),
    foreign key (IFSC_code) references Branch(IFSC_code),
    foreign key (Transaction_ID) references Transactions(Transaction_ID),
    foreign key (Pan_number) references Documents(Pan_number),
    foreign key (User_ID) references Customers(User_ID)
);

CREATE TABLE Assets (
    Pan_number varchar(20),
    IFSC_code varchar(20),
    Transaction_ID varchar(20),
    Asset_Type varchar(20),
    Balance int,
    foreign key (IFSC_code) references Branch(IFSC_code),
    foreign key (Transaction_ID) references Transactions(Transaction_ID),
    foreign key (Pan_number) references Documents(Pan_number)
);

CREATE TABLE Insurance (
    Pan_number varchar(20),
    IFSC_code varchar(20),
    Insurance_Type varchar(20),
    Amount int,
    Duration int,
    Compensation int,
    Return_value int,
    date_of_maturity date not null,
    Claimed boolean,
    foreign key (IFSC_code) references Branch(IFSC_code),
    foreign key (Pan_number) references Documents(Pan_number)
);

CREATE TABLE Loans (
    Accs_ID int,
    Loan_Type varchar(20),
    Duration date not null,
    Interest int,
    Amt_Due int,
    Loan_ID varchar(20) primary key,
    EMIs_Failed varchar(20),
    Principle_amt int,
    blacklisted boolean
);
Alter table loans add Foreign key (Accs_ID) references Accounts(Accs_ID);

CREATE TABLE Saving (
    Amount int,
    Savings_Type varchar(20),
    Certificate_of_Deposit varchar(20),
    Accs_ID int
);
Alter table Saving add Foreign key (Accs_ID) references Accounts(Accs_ID);

insert into Bank values
( 'Bank of Baroda', 001, 10, 50000),
( 'Bank of India', 002, 15, 75000),
( 'Bank of Maharashtra', 003, 8, 30000),
( 'Canara Bank', 004, 12, 60000),
( 'Central Bank of India', 005, 20, 100000),
( 'Indian Bank', 006, 5, 25000),
( 'Indian Overseas Bank', 007, 18, 90000),
( 'Punjab and Sindh Bank', 008, 7, 35000),	
( 'Punjab National Bank', 009, 14, 70000),
( 'State Bank of India', 010, 25, 120000),
( 'UCO Bank', 011, 3, 15000),
( 'Union Bank of India', 012, 22, 11000),
('Kotak Mahindra Bank' , 013, 21, 1000),
('Axis Bank Ltd', 014, 8, 150000),
('DCB Bank Ltd', 015, 16, 7000),
('HDFC Bank Ltd', 016, 26, 13000),
('ICICI Bank', 017, 17, 110000),
('RBL Bank Ltd', 018, 5, 1000),
('Yes Bank Ltd', 019, 1, 150),
('IDFC First Bank Ltd', 020, 11, 15000);

insert into documents values
('ABC1234567', 'AB123456', '1234-5678-9876'),
('XYZ7654321', 'XY987654', '5678-1234-8765'),
('PQR4567890', 'PQ345678', '9876-5432-7654'),
('LMN0987654', 'LM567890', '8765-4321-6543'),
('DEF2345678', 'DE345678', '2345-6789-7654'),
('GHI7890123', 'GH901234', '5432-1098-8765'),
('JKL3456789', 'JK567890', '3210-9876-6543'),
('MNO5678901', 'MN678901', '4321-8901-7654'),
('QRS6789012', 'QR890123', '6543-2109-8765'),
('UVW8901234', 'UV901234', '7654-3210-5432'),
('STU0123456', 'ST234567', '8765-4321-1098'),
('WXY1234567', 'WX123456', '9876-5432-2109'),
('ZAB2345678', 'ZA345678', '8765-4321-9876'),
('BCD3456789', 'BC567890', '7654-3210-4321'),
('EFG4567890', 'EF567890', '5432-1098-8765'),
('HIJ5678901', 'HI678901', '6543-2109-4321'),
('KLM6789012', 'KL890123', '7654-3210-5432'),
('NOP7890123', 'NO901234', '8765-4321-6543'),
('TUV8901234', 'TU901234', '4321-1098-7654'),
('RST0123456', 'RS234567', '5432-2109-8765');

insert into Customers values
('Aarav Sharma', 'AS001', 'India', 80000, 'ABC1234567'),
('Aanya Patel', 'AP002', 'Canada', 75000, 'XYZ7654321'),
('Bhavin Kumar', 'AK003', 'India', 60000, 'PQR4567890'),
('Aarav Agarwaal', 'AB004', 'India', 90000, 'LMN0987654'),
('Rinku Singh', 'AS005', 'India', 120000, 'DEF2345678'),
('Cameron White', 'AW006', 'Australia', 100000, 'GHI7890123'),
('Aanya Gupta', 'AG007', 'India', 85000, 'JKL3456789'),
('Shrey Jain', 'AR008', 'India', 70000, 'MNO5678901'),
('Rupal Mehta', 'AS009', 'India', 110000, 'QRS6789012'),
('Hardik Shah', 'AC010', 'Australia', 95000, 'UVW8901234'),
('Pavinder Raut', 'AW011', 'India', 80000, 'STU0123456'),
('Jenil Makwana', 'AT012', 'USA', 75000, 'WXY1234567'),
('Mukesh Sharma', 'AP013', 'India', 60000, 'ZAB2345678'),
('Jil Shah', 'AM014', 'Canada', 90000, 'BCD3456789'),
('Yashvi Sankalpura', 'AS015', 'India', 120000, 'EFG4567890'),
('Vandan Soni', 'AJ016', 'India', 100000, 'HIJ5678901'),
('Kartik Rajesh', 'AK017', 'India', 85000, 'KLM6789012'),
('Krish Mehta', 'AK018', 'Canada', 70000, 'NOP7890123'),
('Harsh Tulsian', 'AW019', 'India', 110000, 'TUV8901234'),
('Iftiqar Ahmed', 'AM020', 'USA', 95000, 'RST0123456');
accounts
insert into Branch values
('Branch of Bank of Baroda, Mumbai', 500, 5000000, 001, 'BOB001'),
('Branch of Bank of India, Delhi', 750, 7000000, 002, 'BOI002'),
('Branch of Bank of Maharashtra, Pune', 300, 3000000, 003, 'BOM003'),
('Branch of Canara Bank, Bangalore', 600, 6000000, 004, 'CAB004'),
('Branch of Central Bank of India, Mumbai', 1000, 10000000, 005, 'CBI005'),
('Branch of Indian Bank, Chennai', 250, 2500000, 006, 'IB006'),
('Branch of Indian Overseas Bank, Kolkata', 900, 9000000, 007, 'IOB007'),
('Branch of Punjab and Sindh Bank, Chandigarh', 350, 3500000, 008, 'PSB008'),
('Branch of Punjab National Bank, New Delhi', 700, 7000000, 009, 'PNB009'),
('Branch of State Bank of India, Mumbai', 1200, 12000000, 010, 'SBI010'),
('Branch of UCO Bank, Kolkata', 150, 1500000, 011, 'UCB011'),
('Branch of Union Bank of India, Mumbai', 1100, 11000000, 012, 'UBI012'),
('Branch of Kotak Mahindra Bank, Mumbai', 100, 1000000, 013, 'KMB013'),
('Branch of Axis Bank Ltd, Mumbai', 1500, 15000000, 014, 'AXB014'),
('Branch of DCB Bank Ltd, Mumbai', 70, 700000, 015, 'DCB015'),
('Branch of HDFC Bank Ltd, Mumbai', 1300, 13000000, 016, 'HDF016'),
('Branch of ICICI Bank, Mumbai', 1100, 11000000, 017, 'ICI017'),
('Branch of RBL Bank Ltd, Mumbai', 100, 1000000, 018, 'RBL018'),
('Branch of Yes Bank Ltd, Mumbai', 15, 150000, 019, 'YES019'),
('Branch of IDFC First Bank Ltd, Mumbai', 1500, 15000000, 020, 'IDB020');

insert into accounts values
('Savings', 10, 'ABC1234567', 'Individual', 'ACC001', 50000, '1234', 'BOB001'),
('Current', 20, 'XYZ7654321', 'Joint', 'ACC002', 75000, '5678', 'BOI002'),
('Fixed Deposit', 30, 'PQR4567890', 'Individual', 'ACC003', 30000, '9012', 'BOM003'),
('Savings', 40, 'LMN0987654', 'Individual', 'ACC004', 60000, '3456', 'CAB004'),
('Current', 50, 'DEF2345678', 'Joint', 'ACC005', 100000, '7890', 'CBI005'),
('Savings', 60, 'GHI7890123', 'Individual', 'ACC006', 25000, '2345', 'IB006'),
('Fixed Deposit', 70, 'JKL3456789', 'Individual', 'ACC007', 90000, '6789', 'IOB007'),
('Current', 80, 'MNO5678901', 'Joint', 'ACC008', 35000, '0123', 'PSB008'),
('Savings', 90, 'QRS6789012', 'Individual', 'ACC009', 70000, '4567', 'PNB009'),
('Fixed Deposit', 100, 'UVW8901234', 'Individual', 'ACC010', 120000, '8901', 'SBI010'),
('Savings', 110, 'STU0123456', 'Individual', 'ACC011', 15000, '2345', 'UCB011'),
('Current', 120, 'WXY1234567', 'Joint', 'ACC012', 11000, '6789', 'UBI012'),
('Savings', 130, 'ZAB2345678', 'Individual', 'ACC013', 1000, '0123', 'KMB013'),
('Fixed Deposit', 140, 'BCD3456789', 'Individual', 'ACC014', 150000, '4567', 'AXB014'),
('Current', 150, 'EFG4567890', 'Joint', 'ACC015', 7000, '8901', 'DCB015'),
('Savings', 160, 'HIJ5678901', 'Individual', 'ACC016', 13000, '2345', 'HDF016'),
('Fixed Deposit', 170, 'KLM6789012', 'Individual', 'ACC017', 110000, '6789', 'ICI017'),
('Current', 180, 'NOP7890123', 'Joint', 'ACC018', 1000, '0123', 'RBL018'),
('Savings', 190, 'TUV8901234', 'Individual', 'ACC019', 150, '4567', 'YES019'),
('Fixed Deposit', 200, 'RST0123456', 'Individual', 'ACC020', 15000, '8901', 'IDB020');

insert into transactions values
('TRX001', 10, 20, 'Online Transfer', '2024-02-01', '09:15:00', 'Loan Payment', 'ABC1234567'),
('TRX002', 30, 40, 'Cheque', '2024-02-02', '10:30:00', 'Rent Payment', 'XYZ7654321'),
('TRX003', 50, 60, 'NEFT', '2024-02-03', '11:45:00', 'Utility Bill', 'PQR4567890'),
('TRX004', 70, 80, 'Cash', '2024-02-04', '12:00:00', 'Grocery Shopping', 'LMN0987654'),
('TRX005', 90, 100, 'Online Transfer', '2024-02-05', '13:15:00', 'Salary Deposit', 'DEF2345678'),
('TRX006', 110, 120, 'NEFT', '2024-02-06', '14:30:00', 'Loan Payment', 'GHI7890123'),
('TRX007', 130, 140, 'Online Transfer', '2024-02-07', '15:45:00', 'Insurance Premium', 'JKL3456789'),
('TRX008', 150, 160, 'Cheque', '2024-02-08', '16:00:00', 'Rent Payment', 'MNO5678901'),
('TRX009', 170, 180, 'Cash', '2024-02-09', '17:15:00', 'Electricity Bill', 'QRS6789012'),
('TRX010', 190, 200, 'NEFT', '2024-02-10', '18:30:00', 'Credit Card Payment', 'UVW8901234'),
('TRX011', 10, 30, 'Online Transfer', '2024-02-11', '19:45:00', 'Loan Payment', 'STU0123456'),
('TRX012', 20, 40, 'Cash', '2024-02-12', '20:00:00', 'Rent Payment', 'WXY1234567'),
('TRX013', 50, 70, 'NEFT', '2024-02-13', '21:15:00', 'Utility Bill', 'ZAB2345678'),
('TRX014', 60, 80, 'Cheque', '2024-02-14', '22:30:00', 'Grocery Shopping', 'BCD3456789'),
('TRX015', 90, 110, 'Online Transfer', '2024-02-15', '23:45:00', 'Salary Deposit', 'EFG4567890'),
('TRX016', 100, 120, 'NEFT', '2024-02-16', '00:00:00', 'Loan Payment', 'HIJ5678901'),
('TRX017', 130, 150, 'Cash', '2024-02-17', '01:15:00', 'Insurance Premium', 'KLM6789012'),
('TRX018', 140, 160, 'Online Transfer', '2024-02-18', '02:30:00', 'Rent Payment', 'NOP7890123'),
('TRX019', 170, 180, 'Cheque', '2024-02-19', '03:45:00', 'Electricity Bill', 'TUV8901234'),
('TRX020', 190, 200, 'NEFT', '2024-02-20', '04:00:00', 'Credit Card Payment', 'RST0123456');

insert into Investments values
('AS001', 5000, '2024-05-01', '2024-02-01', 'ABC Ltd', 'BOB001', 'TRX001', 'Stock', 100, 'ABC1234567'),
('AP002', 10000, '2024-06-01', '2024-02-02', 'XYZ Corp', 'BOI002', 'TRX002', 'Bond', 50, 'XYZ7654321'),
('AK003', 7500, '2024-07-01', '2024-02-03', 'PQR Inc', 'BOM003', 'TRX003', 'Stock', 75, 'PQR4567890'),
('AB004', 3000, '2024-08-01', '2024-02-04', 'LMN Ltd', 'CAB004', 'TRX004', 'Bond', 30, 'LMN0987654'),
('AS005', 12000, '2024-09-01', '2024-02-05', 'DEF Corp', 'CBI005', 'TRX005', 'Stock', 150, 'DEF2345678'),
('AW006', 9000, '2024-10-01', '2024-02-06', 'GHI Ltd', 'IB006', 'TRX006', 'Bond', 90, 'GHI7890123'),
('AG007', 15000, '2024-11-01', '2024-02-07', 'JKL Inc', 'IOB007', 'TRX007', 'Stock', 200, 'JKL3456789'),
('AR008', 7000, '2024-12-01', '2024-02-08', 'MNO Ltd', 'PSB008', 'TRX008', 'Bond', 70, 'MNO5678901'),
('AS009', 11000, '2025-01-01', '2024-02-09', 'QRS Corp', 'PNB009', 'TRX009', 'Stock', 120, 'QRS6789012'),
('AC010', 9500, '2025-02-01', '2024-02-10', 'UVW Ltd', 'SBI010', 'TRX010', 'Bond', 95, 'UVW8901234'),
('AW011', 8000, '2025-03-01', '2024-02-11', 'STU Corp', 'UCB011', 'TRX011', 'Stock', 80, 'STU0123456'),
('AT012', 7500, '2025-04-01', '2024-02-12', 'WXY Ltd', 'UBI012', 'TRX012', 'Bond', 75, 'WXY1234567'),
('AP013', 6000, '2025-05-01', '2024-02-13', 'ZAB Corp', 'KMB013', 'TRX013', 'Stock', 60, 'ZAB2345678'),
('AM014', 9000, '2025-06-01', '2024-02-14', 'BCD Ltd', 'AXB014', 'TRX014', 'Bond', 90, 'BCD3456789'),
('AS015', 12000, '2025-07-01', '2024-02-15', 'EFG Corp', 'DCB015', 'TRX015', 'Stock', 150, 'EFG4567890'),
('AJ016', 8500, '2025-08-01', '2024-02-16', 'HIJ Ltd', 'HDF016', 'TRX016', 'Bond', 85, 'HIJ5678901'),
('AK017', 7000, '2025-09-01', '2024-02-17', 'KLM Corp', 'ICI017', 'TRX017', 'Stock', 70, 'KLM6789012'),
('AK018', 11000, '2025-10-01', '2024-02-18', 'NOP Ltd', 'RBL018', 'TRX018', 'Bond', 110, 'NOP7890123'),
('AW019', 9500, '2025-11-01', '2024-02-19', 'TUV Corp', 'YES019', 'TRX019', 'Stock', 95, 'TUV8901234'),
('AM020', 8000, '2025-12-01', '2024-02-20', 'RST Ltd', 'IDB020', 'TRX020', 'Bond', 80, 'RST0123456');

insert into assets values
('ABC1234567', 'BOB001', 'TRX001', 'Savings', 5000),
('XYZ7654321', 'BOI002', 'TRX002', 'Fixed Deposit', 10000),
('PQR4567890', 'BOM003', 'TRX003', 'Mutual Fund', 7500),
('LMN0987654', 'CAB004', 'TRX004', 'Stocks', 3000),
('DEF2345678', 'CBI005', 'TRX005', 'Savings', 12000),
('GHI7890123', 'IB006', 'TRX006', 'Fixed Deposit', 9000),
('JKL3456789', 'IOB007', 'TRX007', 'Mutual Fund', 15000),
('MNO5678901', 'PSB008', 'TRX008', 'Stocks', 7000),
('QRS6789012', 'PNB009', 'TRX009', 'Savings', 11000),
('UVW8901234', 'SBI010', 'TRX010', 'Fixed Deposit', 9500),
('STU0123456', 'UCB011', 'TRX011', 'Mutual Fund', 8000),
('WXY1234567', 'UBI012', 'TRX012', 'Stocks', 7500),
('ZAB2345678', 'KMB013', 'TRX013', 'Savings', 6000),
('BCD3456789', 'AXB014', 'TRX014', 'Fixed Deposit', 9000),
('EFG4567890', 'DCB015', 'TRX015', 'Mutual Fund', 12000),
('HIJ5678901', 'HDF016', 'TRX016', 'Stocks', 8500),
('KLM6789012', 'ICI017', 'TRX017', 'Savings', 7000),
('NOP7890123', 'RBL018', 'TRX018', 'Fixed Deposit', 11000),
('TUV8901234', 'YES019', 'TRX019', 'Mutual Fund', 9500),
('RST0123456', 'IDB020', 'TRX020', 'Stocks', 8000);

insert into insurance values
('ABC1234567', 'BOB001', 'Life', 500000, 10, 250000, 750000, '2034-05-01', false),
('XYZ7654321', 'BOI002', 'Health', 100000, 5, 50000, 150000, '2035-06-01', false),
('PQR4567890', 'BOM003', 'Vehicle', 75000, 3, 30000, 90000, '2036-07-01', false),
('LMN0987654', 'CAB004', 'Property', 300000, 15, 150000, 450000, '2037-08-01', false),
('DEF2345678', 'CBI005', 'Travel', 120000, 7, 60000, 180000, '2038-09-01', false),
('GHI7890123', 'IB006', 'Life', 900000, 20, 450000, 1350000, '2039-10-01', false),
('JKL3456789', 'IOB007', 'Health', 150000, 10, 75000, 225000, '2040-11-01', false),
('MNO5678901', 'PSB008', 'Vehicle', 70000, 5, 35000, 105000, '2041-12-01', false),
('QRS6789012', 'PNB009', 'Property', 110000, 15, 55000, 165000, '2042-01-01', false),
('UVW8901234', 'SBI010', 'Travel', 95000, 8, 47500, 142500, '2043-02-01', false),
('STU0123456', 'UCB011', 'Life', 800000, 18, 400000, 1200000, '2044-03-01', false),
('WXY1234567', 'UBI012', 'Health', 75000, 12, 37500, 112500, '2045-04-01', false),
('ZAB2345678', 'KMB013', 'Vehicle', 60000, 6, 30000, 90000, '2046-05-01', false),
('BCD3456789', 'AXB014', 'Property', 90000, 10, 45000, 135000, '2047-06-01', false),
('EFG4567890', 'DCB015', 'Travel', 120000, 15, 60000, 180000, '2048-07-01', false),
('HIJ5678901', 'HDF016', 'Life', 850000, 20, 425000, 1275000, '2049-08-01', false),
('KLM6789012', 'ICI017', 'Health', 70000, 8, 35000, 105000, '2050-09-01', false),
('NOP7890123', 'RBL018', 'Vehicle', 110000, 5, 55000, 165000, '2051-10-01', false),
('TUV8901234', 'YES019', 'Property', 95000, 12, 47500, 142500, '2052-11-01', false),
('RST0123456', 'IDB020', 'Travel', 80000, 10, 40000, 120000, '2053-12-01', false);

insert into Loans values
(10, 'Home Loan', '2034-05-01', 5, 500000, 'L001', '2', 450000, false),
(20, 'Car Loan', '2035-06-01', 8, 100000, 'L002', '0', 90000, false),
(30, 'Personal Loan', '2036-07-01', 10, 75000, 'L003', '1', 70000, false),
(40, 'Education Loan', '2037-08-01', 7, 30000, 'L004', '3', 25000, true),
(50, 'Business Loan', '2038-09-01', 6, 100000, 'L005', '0', 90000, false),
(60, 'Home Loan', '2039-10-01', 5, 25000, 'L006', '2', 20000, false),
(70, 'Car Loan', '2040-11-01', 8, 90000, 'L007', '0', 85000, false),
(80, 'Personal Loan', '2041-12-01', 10, 35000, 'L008', '5', 30000, true),
(90, 'Education Loan', '2042-01-01', 7, 70000, 'L009', '3', 65000, true),
(100, 'Business Loan', '2043-02-01', 6, 120000, 'L010', '0', 115000, false),
(110, 'Home Loan', '2044-03-01', 5, 15000, 'L011', '2', 10000, false),
(120, 'Car Loan', '2045-04-01', 8, 11000, 'L012', '0', 8000, false),
(130, 'Personal Loan', '2046-05-01', 10, 1000, 'L013', '1', 500, false),
(140, 'Education Loan', '2047-06-01', 7, 150000, 'L014', '3', 145000, true),
(150, 'Business Loan', '2048-07-01', 6, 7000, 'L015', '0', 6500, false),
(160, 'Home Loan', '2049-08-01', 5, 13000, 'L016', '2', 12000, false),
(170, 'Car Loan', '2050-09-01', 8, 110000, 'L017', '4', 105000, true),
(180, 'Personal Loan', '2051-10-01', 10, 1000, 'L018', '1', 500, false),
(190, 'Education Loan', '2052-11-01', 7, 150, 'L019', '0', 100, false),
(200, 'Business Loan', '2053-12-01', 6, 15000, 'L020', '0', 14500, false);

insert into saving values
(50000, 'Savings', 'ACC001', 10),
(75000, 'Current', 'ACC002', 20),
(30000, 'Fixed Deposit', 'ACC003', 30),
(60000, 'Savings', 'ACC004', 40),
(100000, 'Current', 'ACC005', 50),
(25000, 'Savings', 'ACC006', 60),
(90000, 'Fixed Deposit', 'ACC007', 70),
(35000, 'Current', 'ACC008', 80),
(70000, 'Savings', 'ACC009', 90),
(120000, 'Fixed Deposit', 'ACC010', 100),
(15000, 'Savings', 'ACC011', 110),
(11000, 'Current', 'ACC012', 120),
(1000, 'Savings', 'ACC013', 130),
(150000, 'Fixed Deposit', 'ACC014', 140),
(7000, 'Current', 'ACC015', 150),
(13000, 'Savings', 'ACC016', 160),
(110000, 'Fixed Deposit', 'ACC017', 170),
(1000, 'Current', 'ACC018', 180),
(150, 'Savings', 'ACC019', 190),
(15000, 'Fixed Deposit', 'ACC020', 200);

-- Joining the Customers and Documents tables to get the customer name and their associated document numbers:
SELECT Customers.User_name, Documents.Pan_number, Documents.Passport_number, Documents.Aadhar_Number
FROM Customers
INNER JOIN Documents
ON Customers.Pan_number = Documents.Pan_number;

-- Getting the total number of accounts opened by each bank:
SELECT Bank.Bank_Name, COUNT(Accounts.Accs_ID) as Total_Accounts
FROM Bank
INNER JOIN Branch
ON Bank.Bank_ID = Branch.Bank_ID
INNER JOIN Accounts
ON Branch.IFSC_code = Accounts.IFSC_code
GROUP BY Bank.Bank_Name;

-- Joining Accounts with Branches to get details of all accounts along with their branch information:
SELECT * 
FROM Accounts a
JOIN Branch b ON a.IFSC_code = b.IFSC_code;

-- Joining Transactions with Accounts to get details of all transactions along with the involved accounts:
SELECT DISTINCT t.Transaction_ID,t.Creditor, t.Debitor, t.Mode_of_payment, t.dot, t.time_of_payment, t.purpose,t.pan_number,
                a.Accs_ID, a.Balance, a.Account_Type, a.passcode, a.IFSC_code
FROM Transactions t
JOIN Accounts a ON t.Creditor = a.Accs_ID OR t.Debitor = a.Accs_ID;

-- Joining Investments with Customers to get details of all investments along with the customer information:
SELECT i.User_ID, i.amount, i.period_of_maturity, i.dot, i.company, i.IFSC_code, i.transaction_ID, i.Category, i.number_of_shares, c.User_name, c.Nationality, c.Income, c.pan_number
FROM Investments i
JOIN Customers c ON i.User_ID = c.User_ID;

-- Joining Insurance with Customers to get details of all insurance policies along with the customer information:
SELECT c.user_name,c.user_ID, ins.pan_number, ins.IFSC_code, ins.Insurance_type, ins.amount, ins.duration, ins.compensation, ins.return_value, ins.date_of_maturity, ins.claimed, c.nationality, c.income
FROM Insurance ins
JOIN Customers c ON ins.Pan_number = c.Pan_number;

-- Joining Loans with Accounts to get details of all loans along with the associated accounts:
SELECT a.pan_number, a.Accs_ID, a.alternate_ID, a.IFSC_code, l.loan_id, l.loan_Type, l.duration, l.interest, l.amt_due, l.EMIs_failed, l.principle_amt, l.blacklisted, a.account_type, a.acc_holder_type, a.balance, a.passcode
FROM Loans l
JOIN Accounts a ON l.Accs_ID = a.Accs_ID;

-- Joining Savings with Accounts to get details of all savings accounts along with the associated accounts:
SELECT a.accs_id, a.pan_number, a.alternate_id, a.IFSC_code, a.account_type, s.certificate_of_deposit, s.savings_type, s.amount, a.acc_holder_type, a.balance, a.passcode
FROM Saving s
JOIN Accounts a ON s.Accs_ID = a.Accs_ID
where a.account_type = 'Savings';

-- Joining Assets with Accounts to get details of all assets along with the associated accounts:
SELECT ast.pan_number, ast.IFSC_code, a.accs_id, ast.transaction_id,  ast.asset_type, ast.balance, a.alternate_id, a.account_type, a.acc_holder_type, a.balance, a.passcode
FROM Assets ast
JOIN Accounts a ON ast.Pan_number = a.Pan_number;

-- Joining Branches with Bank to get details of all branches along with the associated bank information:
SELECT b.address, b.IFSC_code, b.bank_id, b.accs_opened, b.assets_managed, bk.bank_name, bk.number_of_branches, bk.total_acc_holders
FROM Branch b
JOIN Bank bk ON b.Bank_ID = bk.Bank_ID;

-- Getting the total balance of all savings accounts
SELECT SUM(Accounts.Balance) as Total_Savings_Balance
FROM Accounts
WHERE Accounts.Account_type = 'Savings';

-- Getting the details of all transactions made by a particular customer:
SELECT Transactions.Transaction_ID, Transactions.Creditor, Transactions.Debitor, Transactions.Mode_of_Payment, Transactions.dot, Transactions.time_of_payment, Transactions.Purpose, Accounts.Account_type, Accounts.Balance
FROM Customers
INNER JOIN Accounts
ON Customers.Pan_number = Accounts.Pan_number
INNER JOIN Transactions
ON Accounts.Accs_ID = Transactions.Creditor OR Accounts.Accs_ID = Transactions.Debitor
WHERE Customers.User_name = 'Krish Mehta';

-- Getting the details of all investments made by a particular customer:
SELECT Investments.pan_number, Investments.User_ID, Investments.Amount, Investments.Period_of_maturity, Investments.dot, Investments.Company, Investments.IFSC_code, Investments.Transaction_ID, Investments.Category, Investments.Number_of_shares
FROM Customers
INNER JOIN Investments
ON Customers.User_ID = Investments.User_ID
where investments.user_id = 'AS005';

-- Find the total amount of investments made by customers from a particular country (e.g., India) in a specific investment category.
SELECT SUM(Investments.Amount) AS Total_Investment_Amount
FROM Investments
INNER JOIN Customers ON Investments.User_ID = Customers.User_ID
WHERE Customers.Nationality = 'India' AND Investments.Category = 'Stock';

-- Retrieve the details of customers who have availed loans but have defaulted on their EMI payments.
SELECT c.pan_number, c.User_name, c.Nationality, c.Income, l.Loan_ID, l.Loan_Type, l.EMIs_Failed
FROM Customers c
INNER JOIN Accounts a ON c.pan_number = a.pan_number
INNER JOIN Loans l ON a.Accs_ID = l.Accs_ID
WHERE l.EMIs_Failed > 0;

-- Find the total assets managed by each bank, including the sum of account balances, investment amounts, and asset values.
SELECT b.Bank_Name, SUM(a.Balance) AS Total_Account_Balance,
       SUM(i.Amount) AS Total_Investment_Amount,
       SUM(ast.Balance) AS Total_Asset_Value,
       (SUM(a.Balance) + SUM(i.Amount) + SUM(ast.Balance)) AS Total_Assets_Managed
FROM Bank b
LEFT JOIN Branch br ON b.Bank_ID = br.Bank_ID
LEFT JOIN Accounts a ON br.IFSC_code = a.IFSC_code
LEFT JOIN Investments i ON a.IFSC_code = i.IFSC_code
LEFT JOIN Assets ast ON a.IFSC_code = ast.IFSC_code
GROUP BY b.Bank_Name;

-- Retrieve the details of customers who have made transactions using multiple payment modes (e.g., Online Transfer, NEFT, Cash) within a specific date range.
SELECT c.User_name, c.Nationality, c.Income, t.Mode_of_Payment, t.dot, t.time_of_payment
FROM Customers c
INNER JOIN Accounts a ON c.Pan_number = a.Pan_number
INNER JOIN Transactions t ON a.Accs_ID = t.Creditor OR a.Accs_ID = t.Debitor
WHERE t.dot BETWEEN '2024-02-01' AND '2024-02-28'
GROUP BY c.User_name, c.Nationality, c.Income, t.Mode_of_Payment, t.dot, t.time_of_payment
HAVING COUNT(DISTINCT t.Mode_of_Payment) >= 1;

-- Find the customers who have both a savings account and a fixed deposit account, and retrieve their account details along with the customer information.
SELECT c.User_name, c.Nationality, c.Income,
       a1.Accs_ID AS Savings_Account, a1.Balance AS Savings_Balance, a1.IFSC_code AS Savings_IFSC,
       a2.Accs_ID AS Fixed_Deposit_Account, a2.Balance AS Fixed_Deposit_Balance, a2.IFSC_code AS Fixed_Deposit_IFSC
FROM Customers c
INNER JOIN Accounts a1 ON c.Pan_number = a1.Pan_number AND a1.Account_type = 'Savings'
INNER JOIN Accounts a2 ON c.Pan_number = a2.Pan_number AND a2.Account_type = 'Fixed Deposit';

-- Calculate the total interest due for each loan type, grouped by the loan type, and display the loan type and the corresponding total interest amount.
SELECT Loan_Type, SUM(Interest) AS Total_Interest_Due
FROM Loans
GROUP BY Loan_Type;

-- Retrieve the details of customers who have made transactions above a certain amount (e.g., 50,000) within a specific date range, along with the transaction details.
SELECT c.User_name, c.Nationality, c.Income,
       t.Transaction_ID, t.Mode_of_Payment, t.dot, t.time_of_payment, t.Purpose,
       a.Accs_ID, a.Account_type, a.Balance
FROM Customers c
INNER JOIN Accounts a ON c.Pan_number = a.Pan_number
INNER JOIN Transactions t ON a.Accs_ID = t.Creditor OR a.Accs_ID = t.Debitor
WHERE t.dot BETWEEN '2024-02-01' AND '2024-02-28'
  AND (t.Creditor IN (SELECT Accs_ID FROM Accounts WHERE Balance >= 50000)
       OR t.Debitor IN (SELECT Accs_ID FROM Accounts WHERE Balance >= 50000));

-- Find the branches that have opened the highest number of accounts for each bank, and display the bank name, branch address, and the number of accounts opened
SELECT b.Bank_Name, br.Address, br.Accs_opened
FROM Bank b
INNER JOIN (
    SELECT Bank_ID, Address, Accs_opened
    FROM Branch
    WHERE (Bank_ID, Accs_opened) IN (
        SELECT Bank_ID, MAX(Accs_opened)
        FROM Branch
        GROUP BY Bank_ID
    )
) br ON b.Bank_ID = br.Bank_ID;

-- Retrieve the customers who have invested in both stocks and bonds, and display their investment details along with their income and nationality.
SELECT c.User_name, c.Nationality, c.Income,
       i.Amount, i.Period_of_maturity, i.dot, i.Company, i.Category, i.Number_of_shares
FROM Customers c
INNER JOIN Investments i ON c.User_ID = i.User_ID
WHERE i.Category IN ('Stock', 'Bond')
GROUP BY c.User_name, c.Nationality, c.Income, i.Amount, i.Period_of_maturity, i.dot, i.Company, i.Category, i.Number_of_shares
HAVING COUNT(DISTINCT i.Category) > 1;

-- Find the customers who have availed loans but have not made any investments, and display their loan details and income.
SELECT c.User_name, c.Income, l.Loan_ID, l.Loan_Type, l.Duration, l.Interest, l.Amt_Due
FROM Customers c
INNER JOIN Accounts a ON c.Pan_number = a.Pan_number
INNER JOIN Loans l ON a.Accs_ID = l.Accs_ID
LEFT JOIN Investments i ON c.User_ID = i.User_ID
WHERE i.User_ID IS NULL;

-- Retrieve the branches that have managed assets above a certain threshold (e.g., 5,000,000), and display the branch details along with the bank name and the total assets managed.
SELECT b.Bank_Name, br.Address, br.IFSC_code, br.Assets_managed
FROM Bank b
INNER JOIN Branch br ON b.Bank_ID = br.Bank_ID
WHERE br.Assets_managed > 5000000;

-- Calculate the average balance of savings accounts for each bank, and display the bank name and the corresponding average balance.
SELECT b.Bank_Name, AVG(a.Balance) AS Average_Savings_Balance
FROM Bank b
INNER JOIN Branch br ON b.Bank_ID = br.Bank_ID
INNER JOIN Accounts a ON br.IFSC_code = a.IFSC_code
WHERE a.Account_type = 'Savings'
GROUP BY b.Bank_Name;

-- Find the customers who have made transactions involving both credit and debit operations within a specific date range, and display their transaction details along with their account information.

SELECT c.User_name, c.Nationality, c.Income,
       t.Transaction_ID, t.Creditor, t.Debitor, t.Mode_of_Payment, t.dot, t.time_of_payment, t.Purpose,
       a.Accs_ID, a.Account_type, a.Balance
FROM Customers c
INNER JOIN Accounts a ON c.Pan_number = a.Pan_number
INNER JOIN Transactions t ON a.Accs_ID = t.Creditor OR a.Accs_ID = t.Debitor
WHERE t.dot BETWEEN '2024-02-01' AND '2024-02-28'
GROUP BY c.User_name, c.Nationality, c.Income, t.Transaction_ID, t.Creditor, t.Debitor, t.Mode_of_Payment, t.dot, t.time_of_payment, t.Purpose, a.Accs_ID, a.Account_type, a.Balance
HAVING COUNT(DISTINCT CASE WHEN a.Accs_ID = t.Creditor THEN 1 ELSE 0 END) > 0
   AND COUNT(DISTINCT CASE WHEN a.Accs_ID = t.Debitor THEN 1 ELSE 0 END) > 0;

Select c.User_name, c.Nationality, i.pan_number, i.amount from customers c JOIN  investments i ON c.pan_number = i.pan_number where (i.category = 'Stock' and i.amount > 2500);




select count(User_name) from customers inner join insurance on customers.Pan_number = insurance.Pan_number group by (Insurance_Type) having customers.User_name = ("Aarav Agarwaal", "Rupal Mehta", "Jenil Makwana", "Kartik Rajesh");
(select User_name from customers inner join transactions on customers.Pan_number = transactions.Pan_number where transactions.Mode_of_Payment = "Cash");


select count(User_name) from customers inner join insurance on customers.Pan_number = insurance.Pan_number group by (Insurance_Type);

select count(User_name) from customers inner join Accounts on customers.Pan_number = Accounts.Pan_number where (Acc_holder_type = "Savings" and Acc_holder_type = "Current" and Acc_holder_type = "Fixed Deposit") and Accounts inner join Branch on IFSC_code.branch = IFSC_code.Accounts where Bank_Id > 10;