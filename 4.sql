CREATE TABLE student (
    usn     VARCHAR2(10) PRIMARY KEY,
    sname   VARCHAR2(25),
    address VARCHAR2(25),
    phone   NUMBER(10),
    gender  CHAR(1)
);

CREATE TABLE semsec (
    ssid VARCHAR2(5) PRIMARY KEY,
    sem  NUMBER(2),
    sec  CHAR(1)
);

CREATE TABLE class (
    usn VARCHAR2(10) REFERENCES student(usn),
    ssid REFERENCES semsec(ssid)
);

CREATE TABLE subject (
    subcode VARCHAR2(8) PRIMARY KEY,
    title VARCHAR2(20),
    sem NUMBER(2),
    credits NUMBER(2)
);

CREATE TABLE iamarks (
    usn REFERENCES student(usn),
    subcode REFERENCES subject(subcode),
    ssid REFERENCES semsec(ssid),
    test1 NUMBER(2),
    test2 NUMBER(2),
    test3 NUMBER(2),
    finalia NUMBER(2)
);

-- List all the student details studying in fourth semester 'C' section.

SELECT s.*, ss.sem, ss.sec
  FROM student s, semsec ss, class c
 WHERE s.usn   = c.usn
   AND ss.ssid = c.ssid
   AND ss.sem  = 4
   AND ss.sec  = 'c';

-- Compute the total number of male and female students in each semester
-- and in each section.

SELECT ss.sem, ss.sec,
       s.gender, COUNT(s.gender) as count
  FROM student s, semsec ss, class c
 WHERE s.usn = c.usn
   AND ss.ssid = c.ssid
GROUP BY ss.sem, ss.sec, s.gender
ORDER BY sem;

-- Create a view of Test1 marks of student USN '1BI15CS101' in all subjects.

CREATE VIEW stu_test1_marks_view  AS
SELECT test1, subcod
  FROM iamarks
 WHERE usn = '1BI15CS101';

-- Calculate the FinalIA (average of best two test marks) and update the
-- corresponding table for all students.

CREATE OR REPLACE PROCEDURE AVGMARKS
IS CURSOR C_IAMARKS IS
SELECT GREATEST(test1, test2) AS A,
       GREATEST(test1, test3) AS B,
       GREATEST(test3, test2) AS C
  FROM iamarks
 WHERE finalia IS NULL FOR UPDATE;

C_A NUMBER;
C_B NUMBER;
C_C NUMBER;
C_SM NUMBER;
C_AV NUMBER;

BEGIN OPEN C_IAMARKS;
LOOP FETCH C_IAMARKS INTO C_A, C_B, C_C;
EXIT WHEN C_IAMARKS % NOTFOUND;
--DBMS_OUTPUT.PUT_LINE(C_A || ' ' || C_B || ' ' || C_C); IF (C_A != C_B) THEN
C_SM := C_A + C_B;
ELSE C_SM := C_A + C_C;
END IF;
C_AV := C_SM / 2;
--DBMS_OUTPUT.PUT_LINE('SUM = '||C_SM);
--DBMS_OUTPUT.PUT_LINE('AVERAGE = '||C_AV);
UPDATE iamarks
   SET finalia = C_AV
 WHERE CURRENT OF C_IAMARKS;
END LOOP;
CLOSE C_IAMARKS;
END;

BEGIN
AVGMARKS;
END;
