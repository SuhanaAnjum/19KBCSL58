CREATE TABLE department (
    dno VARCHAR2(20) PRIMARY KEY,
    dname VARCHAR2(20),
    mgrstartdate DATE
);

CREATE TABLE employee (
    ssn VARCHAR2(20) PRIMARY KEY,
    fname VARCHAR2(20),
    lname VARCHAR2(20),
    address VARCHAR2(20),
    sex CHAR(1),
    salary INTEGER,
    superssn REFERENCES employee(ssn),
    dno REFERENCES department(dno)
);

ALTER TABLE department
ADD mgrssn REFERENCES employee(ssn);

CREATE TABLE dlocation (
    dloc VARCHAR2(20) PRIMARY KEY,
    dno REFERENCES department(dno)
);

CREATE TABLE project (
    pno INTEGER PRIMARY KEY,
    pname VARCHAR2(20),
    plocation VARCHAR2(20),
    dno REFERENCES department(dno)
);

CREATE TABLE works_on (
    hours NUMBER(2),
    ssn REFERENCES employee(ssn),
    pno REFERENCES project(pno)
);

-- Make a list of all project numbers for projects that involve an employee
-- whose last name is 'Scott', either as a worker or as a manager of the
-- department that controls the project.

(SELECT DISTINCT(p.pno)
   FROM project p, department d, employee e
  WHERE e.dno    = d.dno
    AND d.mgrssn = e.ssn
    AND e.lname  = 'scott')
UNION
(SELECT DISTINCT p1.pno
   FROM project p1, works_on w, employee e1
  WHERE p1.pno   = w.pno
    AND e1.ssn   = w.ssn
    AND e1.lname = 'scott'
);

-- Show the resulting salaries if every employee working on the ‘IoT’
-- project is given a 10 percent raise.

SELECT e.fname, e.lname, 1.1 * e.salary as incr_sal
  FROM employee e, works_on w, project p
 WHERE e.ssn   = w.ssn
   AND w.pno   = p.pno
   AND p.pname = 'iot';

-- Find the sum of the salaries of all employees of the ‘Accounts’
-- department, as well as the maximum salary, the minimum salary,
-- and the average salary in this department

SELECT SUM(e.salary), MAX(e.salary), MIN(e.salary), AVG(e.salary)
  FROM employee e, department d
 WHERE e.dno = d.dno
   AND d.dname = 'accounts';

-- Retrieve the name of each employee who works on all the projects
-- Controlled by department number 5 (use NOT EXISTS operator).

SELECT e.fname, e.lname
  FROM employee e
 WHERE NOT EXISTS (
    (SELECT pno
       FROM project
      WHERE dno = '5')
MINUS
    (SELECT pno
       FROM works_on
      WHERE e.ssn = ssn)
);

-- For each department that has more than five employees, retrieve
-- the department number and the number of its employees who are
-- making more than Rs. 6,00,000.

SELECT d.dno, COUNT(*)
  FROM department d, employee e
 WHERE d.dno = e.dno
   AND e.salary > 600000
   AND d.dno
    IN (
        SELECT e1.dno
          FROM employee e1
      GROUP BY e1.dno
        HAVING COUNT(*) > 5)
GROUP BY d.dno;