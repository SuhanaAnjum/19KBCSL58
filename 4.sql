CREATE TABLE student (
    usn     VARCHAR2(20) PRIMARY KEY,
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
    usn  REFERENCES student(usn),
    ssid REFERENCES semsec(ssid)
);

CREATE TABLE subject (
    subcode VARCHAR2(8) PRIMARY KEY,
    title   VARCHAR2(20),
    sem     NUMBER(2),
    credits NUMBER(2)
);

CREATE TABLE iamarks (
    usn     REFERENCES student(usn),
    subcode REFERENCES subject(subcode),
    ssid    REFERENCES semsec(ssid),
    test1   NUMBER(2),
    test2   NUMBER(2),
    test3   NUMBER(2),
    finalia  NUMBER(2)
);

INSERT INTO student VALUES ( '19KB02BS[020]', 'Akshay',   'Bangalore', 9999999999, 'M' );
INSERT INTO student VALUES ( '19KB02BS[062]', 'Sandhiya', 'Bangalore', 9999999999, 'F' );
INSERT INTO student VALUES ( '19KB02BS[091]', 'Teesha',   'Bangalore', 9999999999, 'F' );
INSERT INTO student VALUES ( '19KB02BS[066]', 'Supriya',  'Mangalore', 9999999999, 'F' );
INSERT INTO student VALUES ( '19KB02BS[010]', 'Abhay',    'Bangalore', 9999999999, 'M' );
INSERT INTO student VALUES ( '19KB02BS[032]', 'Bhaskar',  'Bangalore', 9999999999, 'M' );
INSERT INTO student VALUES ( '19KB02BS[011]', 'Ajay',     'Tumkur',    9999999999, 'M' );
INSERT INTO student VALUES ( '19KB02BS[029]', 'Chitra',   'Davangere', 9999999999, 'F' );
INSERT INTO student VALUES ( '19KB02BS[045]', 'Jeeva',    'Goa',       9999999999, 'M' );
INSERT INTO student VALUES ( '19KB02BS[088]', 'Samira',   'Gulbarga',  9999999999, 'F' );
INSERT INTO student VALUES ( '19KB02BS[122]', 'Vinayaka', 'Hubli',     9999999999, 'F' );
INSERT INTO student VALUES ( '19KB02BS[025]', 'Asmi',     'Goa',       9999999999, 'F' );

INSERT INTO semsec VALUES ( 'CSE8A', 8, 'A' );
INSERT INTO semsec VALUES ( 'CSE8B', 8, 'B' );
INSERT INTO semsec VALUES ( 'CSE8C', 8, 'C' );

INSERT INTO semsec VALUES ( 'CSE7A', 7, 'A' );
INSERT INTO semsec VALUES ( 'CSE7B', 7, 'B' );
INSERT INTO semsec VALUES ( 'CSE7C', 7, 'C' );

INSERT INTO semsec VALUES ( 'CSE6A', 6, 'A' );
INSERT INTO semsec VALUES ( 'CSE6B', 6, 'B' );
INSERT INTO semsec VALUES ( 'CSE6C', 6, 'C' );

INSERT INTO semsec VALUES ( 'CSE5A', 5, 'A' );
INSERT INTO semsec VALUES ( 'CSE5B', 5, 'B' );
INSERT INTO semsec VALUES ( 'CSE5C', 5, 'C' );

INSERT INTO semsec VALUES ( 'CSE4A', 4, 'A' );
INSERT INTO semsec VALUES ( 'CSE4B', 4, 'B' );
INSERT INTO semsec VALUES ( 'CSE4C', 4, 'C' );

INSERT INTO semsec VALUES ( 'CSE3A', 3, 'A' );
INSERT INTO semsec VALUES ( 'CSE3B', 3, 'B' );
INSERT INTO semsec VALUES ( 'CSE3C', 3, 'C' );

INSERT INTO semsec VALUES ( 'CSE2A', 2, 'A' );
INSERT INTO semsec VALUES ( 'CSE2B', 2, 'B' );
INSERT INTO semsec VALUES ( 'CSE2C', 2, 'C' );

INSERT INTO semsec VALUES ( 'CSE1A', 1, 'A' );
INSERT INTO semsec VALUES ( 'CSE1B', 1, 'B' );
INSERT INTO semsec VALUES ( 'CSE1C', 1, 'C' );

INSERT INTO class VALUES ( '19KB02BS[020]', 'CSE8A' );
INSERT INTO class VALUES ( '19KB02BS[062]', 'CSE8A' );
INSERT INTO class VALUES ( '19KB02BS[091]', 'CSE4C' );
INSERT INTO class VALUES ( '19KB02BS[066]', 'CSE8B' );
INSERT INTO class VALUES ( '19KB02BS[010]', 'CSE7A' );
INSERT INTO class VALUES ( '19KB02BS[032]', 'CSE7A' );
INSERT INTO class VALUES ( '19KB02BS[011]', 'CSE4A' );
INSERT INTO class VALUES ( '19KB02BS[029]', 'CSE4A' );
INSERT INTO class VALUES ( '19KB02BS[045]', 'CSE4B' );
INSERT INTO class VALUES ( '19KB02BS[088]', 'CSE3B' );
INSERT INTO class VALUES ( '19KB02BS[122]', 'CSE3C' );
INSERT INTO class VALUES ( '19KB02BS[025]', 'CSE7A' );

INSERT INTO subject VALUES ( '10CS81', 'ACA',  8, 4 );
INSERT INTO subject VALUES ( '10CS82', 'SSM',  8, 4 );
INSERT INTO subject VALUES ( '10CS83', 'NM',   8, 4 );
INSERT INTO subject VALUES ( '10CS84', 'CC',   8, 4 );
INSERT INTO subject VALUES ( '10CS85', 'EW',   8, 4 );

INSERT INTO subject VALUES ( '10CS71', 'OOD',  7, 4 );
INSERT INTO subject VALUES ( '10CS72', 'ECS',  7, 4 );
INSERT INTO subject VALUES ( '10CS73', 'PTW',  7, 4 );
INSERT INTO subject VALUES ( '10CS74', 'DWDM', 7, 4 );
INSERT INTO subject VALUES ( '10CS75', 'JAVA', 7, 4 );
INSERT INTO subject VALUES ( '10CS76', 'SAN',  7, 4 );

INSERT INTO subject VALUES ( '10CS51', 'ME',   5, 4 );
INSERT INTO subject VALUES ( '10CS52', 'CN',   5, 4 );
INSERT INTO subject VALUES ( '10CS53', 'DBMS', 5, 4 );
INSERT INTO subject VALUES ( '10CS54', 'ATC',  5, 4 );
INSERT INTO subject VALUES ( '10CS55', 'AI',   5, 4 );

INSERT INTO subject VALUES ( '10CS41', 'M4',   4, 4 );
INSERT INTO subject VALUES ( '10CS42', 'SE',   4, 4 );
INSERT INTO subject VALUES ( '10CS43', 'DAA',  4, 4 );

INSERT INTO iamarks ( usn, subcode, ssid, test1, test2, test3 ) 
       VALUES ( '19KB02BS[091]', '10CS81', 'CSE8C', 16, 16, 18 );
INSERT INTO iamarks ( usn, subcode, ssid, test1, test2, test3 ) 
       VALUES ( '19KB02BS[091]', '10CS82', 'CSE8C', 12, 19, 14 );
INSERT INTO iamarks ( usn, subcode, ssid, test1, test2, test3 ) 
       VALUES ( '19KB02BS[091]', '10CS83', 'CSE8C', 19, 15, 20 );
INSERT INTO iamarks ( usn, subcode, ssid, test1, test2, test3 ) 
       VALUES ( '19KB02BS[091]', '10CS84', 'CSE8C', 20, 16, 19 );
INSERT INTO iamarks ( usn, subcode, ssid, test1, test2, test3 ) 
       VALUES ( '19KB02BS[091]', '10CS85', 'CSE8C', 15, 15, 12 );

-- List all the student details studying in fourth semester 'C' section.

SELECT s.*, ss.sem, ss.sec
  FROM student s, semsec ss, class c
 WHERE s.usn   = c.usn
   AND ss.ssid = c.ssid
   AND ss.sem  = 4
   AND ss.sec  = 'C';

-- +===============+========+===========+============+========+=====+=====+
-- | USN           | SNAME  | ADDRESS   | PHONE      | GENDER | SEM | SEC |
-- +===============+========+===========+============+========+=====+=====+
-- | 19KB02BS[091] | Teesha | Bangalore | 9999999999 | F      | 4   | C   |
-- +---------------+--------+-----------+------------+--------+-----+-----+

-- Compute the total number of male and female students in each semester
-- and in each section.

SELECT ss.sem, ss.sec,
       s.gender, COUNT(s.gender) as count
  FROM student s, semsec ss, class c
 WHERE s.usn = c.usn
   AND ss.ssid = c.ssid
GROUP BY ss.sem, ss.sec, s.gender
ORDER BY sem;

-- +=====+=====+========+=======+
-- | SEM | SEC | GENDER | COUNT |
-- +=====+=====+========+=======+
-- | 3   | B   | F      | 1     |
-- | 3   | C   | F      | 1     |
-- | 4   | A   | F      | 1     |
-- | 4   | A   | M      | 1     |
-- | 4   | B   | M      | 1     |
-- | 4   | C   | F      | 1     |
-- | 7   | A   | F      | 1     |
-- | 7   | A   | M      | 2     |
-- | 8   | A   | F      | 1     |
-- | 8   | A   | M      | 1     |
-- | 8   | B   | F      | 1     |
-- +-----+-----+--------+-------+

-- Create a view of Test1 marks of student USN '1BI15CS101' in all subjects.

CREATE VIEW stu_test1_marks_view  AS
SELECT test1, subcode
  FROM iamarks
 WHERE usn = '19KB02BS[091]';

SELECT * FROM stu_test1_marks_view;

-- +=======+=========+
-- | TEST1 | SUBCODE |
-- +=======+=========+
-- | 16    | 10CS81  |
-- | 12    | 10CS82  |
-- | 19    | 10CS83  |
-- | 20    | 10CS84  |
-- | 15    | 10CS85  |
-- +-------+---------+

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

IF (C_A != C_B) THEN
C_SM := C_A + C_B;
ELSE C_SM := C_A + C_C;
END IF;
C_AV := C_SM / 2;

UPDATE iamarks
   SET finalia = C_AV
 WHERE CURRENT OF C_IAMARKS;
END LOOP;
CLOSE C_IAMARKS;
END;

BEGIN
AVGMARKS;
END;
/