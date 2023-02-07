CREATE TABLE publisher (
    name    VARCHAR2(20) PRIMARY KEY,
    phone   INTEGER,
    address VARCHAR2(20)
);

CREATE TABLE book (
    book_id        INTEGER PRIMARY KEY,
    title          VARCHAR2(20),
    pub_year       VARCHAR2(20),
    publisher_name REFERENCES publisher(name) ON DELETE CASCADE
);

CREATE TABLE book_authors (
    author_name VARCHAR2(20) PRIMARY KEY,
    book_id     REFERENCES book(book_id) ON DELETE CASCADE
);

CREATE TABLE library_branch (
    branch_id   INTEGER PRIMARY KEY,
    branch_name VARCHAR2(50),
    address     VARCHAR2(50)
);

CREATE TABLE book_copies (
    no_of_copies INTEGER,
    book_id      REFERENCES book(book_id) ON DELETE CASCADE,
    branch_id    REFERENCES library_branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE card (
    card_no INTEGER PRIMARY KEY
);

CREATE TABLE book_lending (
    date_out  DATE, 
    due_date  DATE,
    book_id   REFERENCES book(book_id) ON DELETE CASCADE,
    branch_id REFERENCES library_branch(branch_id) ON DELETE CASCADE,
    card_no   REFERENCES card(card_no) ON DELETE CASCADE
);

-- Data insertion
INSERT INTO publisher VALUES ( 'McGraw Hill',     9999999999, 'Bangalore' );
INSERT INTO publisher VALUES ( 'Pearson',         9999999999, 'New Delhi' );
INSERT INTO publisher VALUES ( 'Random House',    9999999999, 'Hyderabad' );
INSERT INTO publisher VALUES ( 'Hachetter Liver', 9999999999, 'Chennai'   );
INSERT INTO publisher VALUES ( 'Grupo Planeta',   9999999999, 'Bangalore' );

INSERT INTO book VALUES ( 1, 'DBMS',  'Jan-2017', 'McGraw Hill'   );
INSERT INTO book VALUES ( 2, 'ADBMS', 'Jun-2016', 'McGraw Hill'   );
INSERT INTO book VALUES ( 3, 'CN',    'Sep-2016', 'Pearson'       );
INSERT INTO book VALUES ( 4, 'CG',    'Sep-2015', 'Grupo Planeta' );
INSERT INTO book VALUES ( 5, 'OS',    'May-2016', 'Pearson'       );

INSERT INTO book_authors VALUES ( 'Leland',       1 );
INSERT INTO book_authors VALUES ( 'Navanthe',     2 );
INSERT INTO book_authors VALUES ( 'Tanenbaum',    3 );
INSERT INTO book_authors VALUES ( 'Edward Angel', 4 );
INSERT INTO book_authors VALUES ( 'Galvin',       5 );

INSERT INTO library_branch VALUES ( 10, 'RR Nagar',     'Bangalore' );
INSERT INTO library_branch VALUES ( 11, 'Rnsit',        'Bangalore' );
INSERT INTO library_branch VALUES ( 12, 'Rajaji Nagar', 'Bangalore' );
INSERT INTO library_branch VALUES ( 13, 'Nitte',        'Mangalore' );
INSERT INTO library_branch VALUES ( 14, 'Manipal',      'Udupi'     );

INSERT INTO book_copies VALUES ( 10, 1, 10 );
INSERT INTO book_copies VALUES (  5, 1, 11 );
INSERT INTO book_copies VALUES (  2, 2, 12 );
INSERT INTO book_copies VALUES (  5, 2, 13 );
INSERT INTO book_copies VALUES ( 10, 3, 14 );
INSERT INTO book_copies VALUES (  5, 3, 10 );
INSERT INTO book_copies VALUES (  2, 4, 11 );
INSERT INTO book_copies VALUES (  5, 4, 12 );
INSERT INTO book_copies VALUES ( 10, 5, 13 );
INSERT INTO book_copies VALUES (  5, 5, 14 );

INSERT INTO card VALUES ( 100 );
INSERT INTO card VALUES ( 101 );
INSERT INTO card VALUES ( 102 );
INSERT INTO card VALUES ( 103 );
INSERT INTO card VALUES ( 104 );

INSERT INTO book_lending VALUES ( '01-Jan-17', '01-Jun-17', 1, 10, 101 );
INSERT INTO book_lending VALUES ( '11-Jan-17', '11-Mar-17', 2, 11, 101 );
INSERT INTO book_lending VALUES ( '21-Feb-17', '21-Apr-17', 3, 12, 101 );
INSERT INTO book_lending VALUES ( '15-Mar-17', '15-Jul-17', 4, 13, 101 );
INSERT INTO book_lending VALUES ( '12-Apr-17', '12-May-17', 5, 14, 104 );

-- Retrieve details of all books in the library
-- id, title, name of publisher, authors, number of copies in each branch, etc.

SELECT b.book_id, b.title, b.publisher_name,
       a.author_name,
       c.no_of_copies,
       l.branch_id
  FROM book b,
       book_authors a,
       book_copies c,
       library_branch l
 WHERE b.book_id   = a.book_id
   AND b.book_id   = c.book_id
   AND l.branch_id = c.branch_id;

-- +=========+=======+================+==============+==============+===========+
-- | BOOK_ID | TITLE | PUBLISHER_NAME | AUTHOR_NAME  | NO_OF_COPIES | BRANCH_ID |
-- +=========+=======+================+==============+==============+===========+
-- | 1       | DBMS  | McGraw Hill    | Leland       | 10           | 10        |
-- | 1       | DBMS  | McGraw Hill    | Leland       | 5            | 11        |
-- | 2       | ADBMS | McGraw Hill    | Navanthe     | 2            | 12        |
-- | 2       | ADBMS | McGraw Hill    | Navanthe     | 5            | 13        |
-- | 3       | CN    | Pearson        | Tanenbaum    | 10           | 14        |
-- | 3       | CN    | Pearson        | Tanenbaum    | 5            | 10        |
-- | 4       | CG    | Grupo Planeta  | Edward Angel | 2            | 11        |
-- | 4       | CG    | Grupo Planeta  | Edward Angel | 5            | 12        |
-- | 5       | OS    | Pearson        | Galvin       | 10           | 13        |
-- | 5       | OS    | Pearson        | Galvin       | 5            | 14        |
-- +---------+-------+----------------+--------------+--------------+-----------+

-- Get the particulars of borrowers who have borrowed more than
-- 3 books, but from Jan 2017 to Jun 2017.

  SELECT card_no
    FROM book_lending
   WHERE date_out
 BETWEEN '01-Jan-2017'
     AND '01-Jul-2017'
GROUP BY card_no
  HAVING count(*) > 3;

-- +=========+
-- | CARD_NO |
-- +=========+
-- | 101     |
-- +---------+

-- Delete a book in BOOK table. Update the contents of other tables to
-- reflect this data manipulation operation.

DELETE FROM book WHERE book_id = 3;

SELECT * FROM book;

-- +=========+=======+==========+================+
-- | BOOK_ID | TITLE | PUB_YEAR | PUBLISHER_NAME |
-- +=========+=======+==========+================+
-- | 1       | DBMS  | Jan-2017 | McGraw Hill    |
-- | 2       | ADBMS | Jun-2016 | McGraw Hill    |
-- | 4       | CG    | Sep-2015 | Grupo Planeta  |
-- | 5       | OS    | May-2016 | Pearson        |
-- +---------+-------+----------+----------------+

-- Partition the BOOK table based on year of publication.
-- Demonstrate its working with a simple query.

CREATE VIEW v_publication AS
SELECT pub_year FROM book;

SELECT * FROM v_publication;

-- +==========+
-- | PUB_YEAR |
-- +==========+
-- | Jan-2017 |
-- | Jun-2016 |
-- | Sep-2015 |
-- | May-2016 |
-- +----------+

-- Create a view of all books and its number of copies that are
-- currently available in the Library.

CREATE VIEW v_books AS
SELECT b.book_id, b.title,
       c.no_of_copies
  FROM book b,
       book_copies c,
       library_branch l
 WHERE b.book_id   = c.book_id
   AND c.branch_id = l.branch_id;

SELECT * FROM v_books;

-- +=========+=======+==============+
-- | BOOK_ID | TITLE | NO_OF_COPIES |
-- +=========+=======+==============+
-- | 1       | DBMS  | 10           |
-- | 1       | DBMS  | 5            |
-- | 2       | ADBMS | 2            |
-- | 2       | ADBMS | 5            |
-- | 4       | CG    | 2            |
-- | 4       | CG    | 5            |
-- | 5       | OS    | 10           |
-- | 5       | OS    | 5            |
-- +---------+-------+--------------+