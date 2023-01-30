CREATE TABLE salesman (
    salesman_id NUMBER(4) PRIMARY KEY,
    name VARCHAR2(20),
    city VARCHAR2(20),
    commission VARCHAR2(20)
);

CREATE TABLE customer (
    customer_id NUMBER(4) PRIMARY KEY,
    cust_name VARCHAR2(20),
    city VARCHAR2(20),
    grade NUMBER(3),
    salesman_id REFERENCES salesman(salesman_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    ord_no NUMBER(5) PRIMARY KEY,
    purchase_amt NUMBER(10, 2),
    ord_date DATE,
    customer_id REFERENCES customer(customer_id) ON DELETE CASCADE,
    salesman_id REFERENCES salesman(salesman_id) ON DELETE CASCADE
);

-- Count the customers with grades above Bangalore's average.

  SELECT grade, COUNT(DISTINCT customer_id)
    FROM customer
GROUP BY grade
  HAVING grade > (
        SELECT AVG(grade)
          FROM customer
         WHERE city = 'bangalore'
);

-- Find the name and numbers of all salesmen who had more than one customer.

SELECT salesman_id, name
  FROM salesman a
 WHERE 1 < (
        SELECT COUNT(*)
          FROM customer
         WHERE salesman_id = a.salesman_id
);

-- List all salesmen and indicate those who have and don’t have customers
-- in their cities (Use UNION operation.)

SELECT s.salesman_id, name, cust_name
  FROM salesman s, customer c
 WHERE s.city = c.city
 UNION
SELECT salesman_id, name, 'NO MATCH'
  FROM salesman
 WHERE city
NOT IN (
    SELECT city FROM customer
);

-- Create a view that finds the salesman who has the customer with the
-- highest order of a day.

CREATE VIEW elitsalesman AS
SELECT b.ord_date, a.salesman_id, a.name
  FROM salesman a, orders b
 WHERE a.salesman_id = b.salesman_id
   AND b.purchase_amt = (
        SELECT MAX(purchase_amt)
          FROM orders c
         WHERE c.ord_date = b.ord_date
);

SELECT * FROM elitsalesman;

-- Demonstrate the DELETE operation by removing salesman with id 1000.

DELETE FROM salesman WHERE salesman_id = 1000;

SELECT * FROM salesman;