create database Berealty;
use Berealty;

CREATE TABLE Agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
	city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20),
    type_purpose ENUM('Residential', 'Commercial') NOT NULL,
    type_property ENUM('House', 'Apartment') NOT NULL,
    price_sell DECIMAL(12, 2) NOT NULL,
    price_rent DECIMAL(12, 2) NOT NULL,
    status ENUM('Available', 'Sold', 'Rented') DEFAULT 'Available',
    listed_date DATE,
    agent_id INT,
    FOREIGN KEY (agent_id) REFERENCES Agents(agent_id) ON DELETE SET NULL
);

CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
	phone_number VARCHAR(20),
    email VARCHAR(150),
    client_type ENUM('Buyer', 'Seller', 'Tenant', 'Landlord') NOT NULL
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    client_id INT,
    agent_id INT,
    transaction_date DATE,
    transaction_amount DECIMAL(10, 2),
    transaction_type ENUM('Sale', 'Rent'),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (agent_id) REFERENCES Agents(agent_id)
);


INSERT INTO Agents (name, phone_number, email) VALUES
('Jack Collins', '555-2120', 'jack.collins@berealty.com'),
('Jack Underkofler', '555-2335', 'jack.underkofler@berealty.com'),
('Will Goodroad', '555-6120', 'will.goodroad@berealty.com'),
('Dylan Brenner', '555-9124', 'dylan.brenner@berealty.com'),
('Johnny Stevens', '555-1144', 'johnny.stevens@berealty.com'),
('Matt Kofos', '555-1113', 'matt.kofos@berealty.com');

INSERT INTO Properties (address, city, zip_code, type_purpose, type_property, price_sell, price_rent, status, listed_date, agent_id)
VALUES

('456 Barbarossa St', 'Berlin', '10180', 'Commercial', 'House', 900000.00, 31000.00, 'Sold', '2023-06-15', 1),
('123 Leipziger St', 'Berlin', '10115', 'Residential','Apartment', 550000.00, 16000.00, 'Available', '2023-09-01', 3),
('456 Eisenacher St', 'Berlin', '10779', 'Residential', 'House', 800000.00, 24000.00, 'Rented', '2023-07-11', 2),
('123 Martin Luther St', 'Berlin', '10779', 'Commercial', 'Apartment', 640000.00, 18000.00, 'Available', '2024-05-07', 5),
('456 Engeldamm St', 'Berlin', '10779', 'Residential', 'House', 880000.00, 26000.00, 'Sold', '2023-02-14', 6),
('123 Oranien St', 'Berlin', '10779', 'Commercial', 'Apartment', 720000.00, 22000.00, 'Available', '2023-05-07', 4);

drop table properties;
drop table transactions;
delete from properties;

select * from properties;

INSERT INTO Clients (name, phone_number, email, client_type)
VALUES
('Grian Chatten', '555-9876', 'grian.chatten@gmail.com', 'Buyer'),
('Conor Corley', '555-1376', 'conor.corley@gmail.com', 'Buyer'),
('Tom Coll', '555-8765', 'tom.coll@gmail.com', 'Tenant'),
('Carlos Connell', '555-9842', 'carlos.connell@gmail.com', 'Seller'),
('Jacob Charlton', '555-0693', 'jacob.charlton@gmail.com', 'Tenant'),
('Ethan McCann', '555-4820', 'ethan.mccan@gmail.com', 'Landlord'),
('Ben Maida', '555-3363', 'ben.maida@gmail.com', 'Buyer'),
('Nick Sjogren', '555-2043', 'nick.sjogren@gmail.com', 'Seller'),
('Matt Duppen', '555-6028', 'matt.duppen@gmail.com', 'Landlord'),
('Ethan McCann', '555-2992', 'ethan.mccann@gmail.com', 'Landlord'),
('Conor Mason', '555-4592', 'conor.mason@gmail.com', 'Buyer'),
('Philip Blake', '555-3952', 'philip.blake@gmail.com', 'Seller');

select * from clients;
select * from properties;
select * from agents;
select * from transactions;

INSERT INTO Transactions (property_id, agent_id, client_id, transaction_type, transaction_amount, transaction_date)
VALUES
(1, 2, 22, 'Sale', 900000.00, '2024-05-22'),
(2, 1, 23, 'Sale', 550000.00, '2024-09-15'),
(3, 4, 24, 'Rent', 24000.00, '2024-10-11'),
(4, 6, 26, 'Rent', 18000.00, '2024-04-16'),
(5, 5, 28, 'Sale', 880000.00, '2024-08-12'),
(6, 3, 35, 'Sale', 720000.00, '2024-06-21');

-- analyze

SELECT address, city, zip_code, type_purpose, type_property, price_sell, price_rent, status 
FROM Properties 
WHERE status = 'Available';

SELECT 
    p.address,
    p.city,
    p.zip_code,
    p.type_purpose,
    p.type_property,
    p.price_sell,
    p.price_rent,
    p.status,
    a.name AS agent_name,
    t.transaction_type,
    t.transaction_amount,
    t.transaction_date
FROM 
    Properties p
INNER JOIN 
    Agents a ON p.agent_id = a.agent_id
LEFT JOIN 
    Transactions t ON p.property_id = t.property_id
WHERE 
    p.status = 'Available';
    
SELECT 
    c.name AS client_name,
    c.phone_number,
    c.email,
    c.client_type,
    t.transaction_type,
    t.transaction_amount,
    t.transaction_date
FROM 
    Clients c
LEFT JOIN 
    Transactions t ON c.client_id = t.client_id;
    
    SELECT 
    a.name AS agent_name,
    p.address,
    p.city,
    p.price_sell,
    p.price_rent,
    p.status
FROM 
    Agents a
RIGHT JOIN 
    Properties p ON a.agent_id = p.agent_id;

SELECT 
    c.name AS client_name,
    p.address AS property_address,
    p.type_property,
    p.price_sell,
    p.price_rent
FROM 
    Clients c
CROSS JOIN 
    Properties p;
    
    SELECT 
    a.name AS agent_name,
    MONTH(t.transaction_date) AS month,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.transaction_amount) AS total_amount
FROM 
    Transactions t
JOIN 
    Agents a ON t.agent_id = a.agent_id
GROUP BY 
    a.name, MONTH(t.transaction_date)
ORDER BY 
    month;
    
    
    
    
    
DELIMITER //
CREATE TRIGGER update_property_status AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'Sale' THEN
        UPDATE Properties 
        SET status = 'Sold' 
        WHERE property_id = NEW.property_id;
    ELSEIF NEW.transaction_type = 'Rent' THEN
        UPDATE Properties 
        SET status = 'Rented' 
        WHERE property_id = NEW.property_id;
    END IF;
END;
//
DELIMITER ;




	INSERT INTO Transactions (property_id, agent_id, client_id, transaction_type, transaction_amount, transaction_date)
	VALUES (7, 3, 36, 'Sale', 950000.00, '2024-11-01');
    
    select * from Transactions;


SELECT property_id, status FROM Properties;

select * from Properties;

INSERT INTO Transactions (property_id, agent_id, client_id, transaction_type, transaction_amount, transaction_date)
VALUES (1, 1, 31, 'Sale', 900000.00, '2024-10-28');

INSERT INTO Properties (address, city, zip_code, type_purpose, type_property, price_sell, price_rent, status, listed_date, agent_id)
VALUES
('789 Alexanderplatz', 'Berlin', '10178', 'Residential', 'Apartment', 600000.00, 20000.00, 'Available', '2024-10-18', 2);

select * from Properties;
