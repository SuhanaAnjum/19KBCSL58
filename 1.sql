CREATE TABLE publisher (
    name        VARCHAR2(20) PRIMARY KEY,
    phone       INTEGER,
    address     VARCHAR2(20)
);

CREATE TABLE book (
    book_id     INTEGER PRIMARY KEY,
    title       VARCHAR2(20),
    pub_year    VARCHAR2(20),
    publisher_name REFERENCES PUBLISHER (NAME) ON DELETE CASCADE
);

CREATE TABLE book_authors (
    author_name VARCHAR2(20) PRIMARY KEY,
    book_id REFERENCES book(book_id) ON DELETE CASCADE
);

CREATE TABLE library_branch (
    branch_id INTEGER PRIMARY KEY,
    branch_name VARCHAR2 (50),
    address VARCHAR2 (50)
);

CREATE TABLE book_copies (
    no_of_copies INTEGER,
    book_id REFERENCES book(book_id) ON DELETE CASCADE,
    branch_id REFERENCES library_branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE card (
    card_no INTEGER PRIMARY KEY
);

CREATE TABLE book_lending (
    date_out DATE, due_date DATE,
    book_id REFERENCES book(book_id) ON DELETE CASCADE,
    branch_id REFERENCES library_branch(branch_id) ON DELETE CASCADE,
    card_no REFERENCES card(card_no) ON DELETE CASCADE
);

-- 1. Retrieve details of all books in the library
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

-- Get the particulars of borrowers who have borrowed more than
-- 3 books, but from Jan 2017 to Jun 2017.

  SELECT card_no
    FROM book_lending
   WHERE date_out
 BETWEEN '01-jan-2017'
     AND '01-jul-2017'
GROUP BY card_no
  HAVING count(*) > 3;

-- Delete a book in BOOK table. Update the contents of other tables to
-- reflect this data manipulation operation.

DELETE FROM book WHERE book_id = 3;

-- Partition the BOOK table based on year of publication.
-- Demonstrate its working with a simple query.

CREATE VIEW v_publication AS
SELECT pub_year FROM book;

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