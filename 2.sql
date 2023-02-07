CREATE TABLE salesman (
    salesman_id NUMBER(4) PRIMARY KEY,
    name        VARCHAR2(20),
    city        VARCHAR2(20),
    commission  VARCHAR2(20)
);

CREATE TABLE customer (
    customer_id NUMBER(4) PRIMARY KEY,
    cust_name   VARCHAR2(20),
    city        VARCHAR2(20),
    grade       NUMBER(3),
    salesman_id REFERENCES salesman(salesman_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    ord_no       NUMBER(5) PRIMARY KEY,
    purchase_amt NUMBER(10, 2),
    ord_date     DATE,
    customer_id  REFERENCES customer(customer_id) ON DELETE CASCADE,
    salesman_id  REFERENCES salesman(salesman_id) ON DELETE CASCADE
);

INSERT INTO salesman VALUES ( 1000, 'John',   'Bangalore', '25%' );
INSERT INTO salesman VALUES ( 2000, 'Ravi',   'Bangalore', '20%' );
INSERT INTO salesman VALUES ( 3000, 'Kumar',  'Mysore',    '15%' );
INSERT INTO salesman VALUES ( 4000, 'Smith',  'Delhi',     '30%' );
INSERT INTO salesman VALUES ( 5000, 'Harsha', 'Hyderabad', '15%' );

INSERT INTO customer VALUES ( 10, 'Preethi', 'Bangalore', 100, 1000 );
INSERT INTO customer VALUES ( 11, 'Vivek',   'Mangalore', 300, 1000 );
INSERT INTO customer VALUES ( 12, 'Bhaskar', 'Chennai',   400, 2000 );
INSERT INTO customer VALUES ( 13, 'Chethan', 'Bangalore', 200, 2000 );
INSERT INTO customer VALUES ( 14, 'Mamatha', 'Bangalore', 400, 3000 );

INSERT INTO orders VALUES ( 50, 5000, '04-May-17', 10, 1000 );
INSERT INTO orders VALUES ( 51,  450, '20-Jan-17', 10, 2000 );
INSERT INTO orders VALUES ( 52, 1000, '24-Feb-17', 11, 2000 );
INSERT INTO orders VALUES ( 53, 3500, '13-Apr-17', 13, 3000 );
INSERT INTO orders VALUES ( 54,  550, '09-Mar-17', 14, 2000 );

-- Count the customers with grades above Bangalore's average.

  SELECT grade, COUNT(DISTINCT customer_id)
    FROM customer
GROUP BY grade
  HAVING grade > (
        SELECT AVG(grade)
          FROM customer
         WHERE city = 'Bangalore'
);

-- +=======+============================+
-- | GRADE | COUNT(DISTINCTCUSTOMER_ID) |
-- +=======+============================+
-- | 400   | 2                          |
-- +-------+----------------------------+

-- Find the name and numbers of all salesmen who had more than one customer.

SELECT salesman_id, name
  FROM salesman a
 WHERE 1 < (
        SELECT COUNT(*)
          FROM customer
         WHERE salesman_id = a.salesman_id
);

-- +=============+======+
-- | SALESMAN_ID | NAME |
-- +=============+======+
-- | 1000        | John |
-- | 2000        | Ravi |
-- +-------------+------+

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

-- +=============+========+===========+
-- | SALESMAN_ID | NAME   | CUST_NAME |
-- +=============+========+===========+
-- | 1000        | John   | Preethi   |
-- | 2000        | Ravi   | Preethi   |
-- | 1000        | John   | Chethan   |
-- | 2000        | Ravi   | Chethan   |
-- | 1000        | John   | Mamtha    |
-- | 2000        | Ravi   | Mamtha    |
-- | 5000        | Harsha | NO MATCH  |
-- | 4000        | Smith  | NO MATCH  |
-- | 3000        | Kumar  | NO MATCH  |
-- +-------------+--------+-----------+

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

-- +===========+=============+=======+
-- | ORD_DATE  | SALESMAN_ID | NAME  |
-- +===========+=============+=======+
-- | 04-MAY-17 | 1000        | John  |
-- | 20-JAN-17 | 2000        | Ravi  |
-- | 24-FEB-17 | 2000        | Ravi  |
-- | 13-APR-17 | 3000        | Kumar |
-- | 09-MAR-17 | 2000        | Ravi  |
-- +-----------+-------------+-------+

-- Demonstrate the DELETE operation by removing salesman with id 1000.

DELETE FROM salesman WHERE salesman_id = 1000;

SELECT * FROM salesman;

-- +=============+========+===========+============+
-- | SALESMAN_ID | NAME   | CITY      | COMMISSION |
-- +=============+========+===========+============+
-- | 2000        | Ravi   | Bangalore | 20%        |
-- | 3000        | Kumar  | Mysore    | 15%        |
-- | 4000        | Smith  | Delhi     | 30%        |
-- | 5000        | Harsha | Hyderabad | 15%        |
-- +-------------+--------+-----------+------------+