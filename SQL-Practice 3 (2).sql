/* ============================================================
   PRACTICE ASSIGNMENT: CONSTRAINTS (PK, FK, NOT NULL, UNIQUE,
   CHECK, DEFAULT) ACROSS FOUR CONNECTED TABLES
   Scenario: Library Management System

   Tables and how they connect:
     Authors  --(author_id)-->  Books
     Books    --(book_id)-->    Transactions
     Members  --(member_id)-->  Transactions

   So Transactions is linked to BOTH Books and Members.
   ============================================================

   WHAT YOU NEED TO DO:
   1. Write the CREATE TABLE statement for each table below,
      following the constraint requirements given in the comments.
   2. Insert 10 rows of realistic data into EACH table.
   3. Create tables and insert data in this ORDER: Authors, Books,
      Members, Transactions (parent tables must exist and have
      data before child tables can reference them).
   4. Write the constraint-violation INSERT statements to test
      each constraint (they should fail when run).
   ============================================================ */


/* ------------------------------------------------------------
   TABLE 1: Authors  (Parent table)
   ------------------------------------------------------------
   1. author_id     -> uniquely identifies each author, cannot be empty
   2. author_name   -> cannot be left empty
   3. country        -> should default to 'India' if not specified
   4. birth_year     -> must only allow years between 1800 and 2015

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */




/* Insert 10 rows into Authors.
   At least 2 rows should rely on the DEFAULT country. */




/* ------------------------------------------------------------
   TABLE 2: Books  (Child of Authors)
   ------------------------------------------------------------
   1. book_id         -> uniquely identifies each book, cannot be empty
   2. title            -> cannot be left empty
   3. isbn              -> must be unique across all books
   4. price              -> must only allow positive values, and
                             should default to 299.00 if not specified
   5. published_year     -> must only allow years between 1900 and 2026
   6. author_id           -> must reference a valid author from the
                              Authors table (Foreign Key)

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */




/* Insert 10 rows into Books.
   Distribute books across the author_id values from Authors.
   At least 2 rows should rely on the DEFAULT price. */




/* ------------------------------------------------------------
   TABLE 3: Members  (Parent table)
   ------------------------------------------------------------
   1. member_id      -> uniquely identifies each member, cannot be empty
   2. member_name    -> cannot be left empty
   3. age              -> must only allow members aged 12 or older
   4. email             -> must be unique across all members
   5. membership_type   -> should default to 'Standard' if not specified

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */




/* Insert 10 rows into Members.
   At least 2 rows should rely on the DEFAULT membership_type.
   At least 1 row should have a NULL email (optional but unique
   when provided). */




/* ------------------------------------------------------------
   TABLE 4: Transactions  (Child of Books AND Members)
   ------------------------------------------------------------
   1. transaction_id  -> uniquely identifies each transaction, cannot be empty
   2. book_id           -> must reference a valid book from the
                            Books table (Foreign Key)
   3. member_id          -> must reference a valid member from the
                             Members table (Foreign Key)
   4. issue_date          -> cannot be left empty
   5. return_date          -> no constraint (can be NULL if not yet returned)
   6. status                -> should default to 'Issued' if not specified
   7. fine                   -> must only allow values of 0 or more, and
                                 should default to 0.00 if not specified

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */




/* Insert 10 rows into Transactions.
   Mix book_id and member_id values from the tables above.
   At least 2 rows should rely on the DEFAULT status and/or fine.
   At least 2 rows should have a NULL return_date (not yet returned). */




/* ============================================================
   CONSTRAINT-BREAKING DEMOS
   Write ONE INSERT statement for each case below. Run it,
   note the error, then write down (as a comment) which
   constraint caused it to fail.
   ============================================================ */

-- 1. Insert an Author with a NULL author_name


-- 2. Insert an Author with birth_year = 1750 (violates CHECK)


-- 3. Insert a Book with a duplicate isbn


-- 4. Insert a Book with price = -100 (violates CHECK)


-- 5. Insert a Book with an author_id that does not exist in Authors
--    (violates FOREIGN KEY)


-- 6. Insert a Member with a duplicate member_id


-- 7. Insert a Member with age = 9 (violates CHECK)


-- 8. Insert a Member with a duplicate email


-- 9. Insert a Transaction with a book_id that does not exist in Books
--    (violates FOREIGN KEY)


-- 10. Insert a Transaction with a member_id that does not exist in Members
--     (violates FOREIGN KEY)


-- 11. Insert a Transaction with a NULL issue_date


-- 12. Insert a Transaction with fine = -50 (violates CHECK)

