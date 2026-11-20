USE sales;

-- QUESTION 1: Achieving First Normal Form (1NF)

DROP TABLE IF EXISTS ProductDetail_1NF;

CREATE TABLE ProductDetail_1NF (
    OrderID      INT          NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product      VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

-- Insert the normalized records (one product per row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe',    'Laptop'),
(101, 'John Doe',    'Mouse'),
(102, 'Jane Smith',  'Tablet'),
(102, 'Jane Smith',  'Keyboard'),
(102, 'Jane Smith',  'Mouse'),
(103, 'Emily Clark', 'Phone');

SELECT * FROM ProductDetail_1NF;

-- Question 2: Achieving Second Normal Form (2NF)

DROP TABLE IF EXISTS orderdetails;
DROP TABLE IF EXISTS orders;

CREATE TABLE Orders (
    OrderID      INT          NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE OrderItems (
    OrderID  INT          NOT NULL,
    Product  VARCHAR(100) NOT NULL,
    Quantity INT          NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop',   2),
(101, 'Mouse',    1),
(102, 'Tablet',   3),
(102, 'Keyboard', 1),
(102, 'Mouse',    2),
(103, 'Phone',    1);

SELECT * FROM Orders;
SELECT * FROM OrderItems;

SELECT o.OrderID, o.CustomerName, oi.Product, oi.Quantity
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
ORDER BY o.OrderID, oi.Product;
