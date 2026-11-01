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
create database practice_3;
use practice_3;

/* ------------------------------------------------------------
   TABLE 1: Authors  (Parent table)
   ------------------------------------------------------------
   1. author_id     -> uniquely identifies each author, cannot be empty
   2. author_name   -> cannot be left empty
   3. country        -> should default to 'India' if not specified
   4. birth_year     -> must only allow years between 1800 and 2015

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
create table author (
    author_id int primary key,
    author_name varchar(50), 
    country varchar(50),
    birth_year int check (birth_year  between 1800 and 2015));



/* Insert 10 rows into Authors.
   At least 2 rows should rely on the DEFAULT country. */
insert into author(author_id,author_name,country,birth_year)
values(101 , 'Jane Austen','England',1801),
       (102,'Charles Dickens','England',1812), 
       (103,'Leo Tolstoy','Russia',1828),	
       (104,'Mark Twain','United States',1835),
       (105,'Rabindranath Tagore','India',1861),	
       (106,'Agatha Christie','England',1890),	
       (107,'George Orwell','England',1903),	
       (108,'R. K. Narayan','India',1906),	
       (109,'J. K. Rowling','United Kingdom',1965),	
       (110,'Chetan Bhagat','India',1974);
	
    select * from author;

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
create table books(
    book_id int primary key,
    title varchar(50),
    isbn varchar(50) unique,
    price int check(price>0),
    published_year int check(published_year between 1900 and 2026),
    author_id int,
    foreign key (author_id) references author(author_id));


/* Insert 10 rows into Books.
   Distribute books across the author_id values from Authors.
   At least 2 rows should rely on the DEFAULT price. */
insert into books values
(201,'The Alchemist','isbn301',399,2000,101),
(202,'Atomic Habits','isbn302',499,2018,102),
(203,'The Psychology of Money','isbn303',450,2020,103),
(204,'The Kite Runner','isbn304',599,2021,104),
(205,'The Palace of Illusions','isbn305',499,2015,105),
(206,'1984','isbn306',199,2006,106),
(207,'Animal Farm','isbn307',149,2003,107),
(208,'The Silent Patient','isbn308',499,2000,108),
(209,'Norwegian Wood','isbn309',699,2005,109),
(210,'Pride and Prejudice','isbn310',295,2008,110);

select * from books;

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
create table members(
member_id int primary key,
member_name varchar(50),
age int check(age>=12),
email varchar(50) unique,
membership_type varchar(50) );

drop table members;

/* Insert 10 rows into Members.
   At least 2 rows should rely on the DEFAULT membership_type.
   At least 1 row should have a NULL email (optional but unique
   when provided). */
insert into members 
values
(301,	'Rahul Sharma',	24,	'rahul.sharma@gmail.com','Premium'),
(302,	'Priya Patel',	28,	'priya.patel@gmail.com','Gold'),
(303,	'Amit Kumar',	22,	'amit.kumar@gmail.com',	'Basic'),
(304,	'Sneha Das',	26,	'sneha.das@gmail.com',	'Premium'),
(305,	'Arjun Singh',	31,	'arjun.singh@gmail.com',	'Gold'),
(306,	'Neha Verma',	23,	'neha.verma@gmail.com',	'Basic'),
(307,	'Rohan Mehta',	29,	'rohan.mehta@gmail.com',	'Premium'),
(308,	'Ananya Roy',	25,	'ananya.roy@gmail.com',	'Gold'),
(309,	'Karan Gupta',	34,	'karan.gupta@gmail.com',	'Basic'),
(310,	'Pooja Mishra',	27,	'pooja.mishra@gmail.com',	'Premium');

select * from members;

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
create table transaction(
transaction_id int primary key,
book_id int,
foreign key (book_id) REFERENCES books(book_id),
member_id int,
foreign key (member_id) references members(member_id),
issue_date date,
return_date date,
status varchar(50),
fine int );



/* Insert 10 rows into Transactions.
   Mix book_id and member_id values from the tables above.
   At least 2 rows should rely on the DEFAULT status and/or fine.
   At least 2 rows should have a NULL return_date (not yet returned). */
insert into transaction 
values
(401,	201,	301, '2026-01-05',	'2026-01-15',	'Returned',	0),
(402,	202,	302,	'2026-01-10',	'2026-01-25',	'Returned',	20),
(403,	203,	303,	'2026-02-01',	'2026-02-10',	'Returned',	0),
(404,	204,	304,	'2026-02-05',	'2026-02-20',	'Returned',	30),
(405,	205,	305,	'2026-02-15',	'2026-02-28',	'Returned',	10),
(406,	206,	306,	'2026-03-01',	NULL,	'Issued',	0),
(407,	207,	307,	'2026-03-05',	NULL,	'Issued',	0),
(408,	208,	308,	'2026-03-10',	'2026-03-20',	'Returned',0),
(409,	209,	309,	'2026-03-15',	NULL,	'Overdue',	500),
(410,	210,	310,	'2026-03-20',	'2026-04-01',	'Returned',	15);

select * from transaction ;

/* ============================================================
   CONSTRAINT-BREAKING DEMOS
   Write ONE INSERT statement for each case below. Run it,
   note the error, then write down (as a comment) which
   constraint caused it to fail.
   ============================================================ */
select * from author;
select * from books;
select * from members;
select * from transaction;
 
-- 1. Insert an Author with a NULL author_name
insert into author values(111,null,"England",2000);

-- 2. Insert an Author with birth_year = 1750 (violates CHECK)
insert into author values(112,'raaj','India',1750);
-- error checked
-- 3. Insert a Book with a duplicate isbn
insert into books values (211,'the royal','isbn305',599,2000,111);
-- it shows duplicate entry
-- 4. Insert a Book with price = -100 (violates CHECK)
insert into books values(212,'the chemist','isbn312',-100,2000,111);

-- 5. Insert a Book with an author_id that does not exist in Authors
--    (violates FOREIGN KEY)
insert into books values (10,'the unknown','isbn10',200,2005,100);


-- 6. Insert a Member with a duplicate member_id
insert into members values(301,'raaj',22,'raaj@gmail.com','gold');


-- 7. Insert a Member with age = 9 (violates CHECK)
insert into members values(10,'likun',9,'likun@gmail.com','premium');

-- 8. Insert a Member with a duplicate email
insert into members values(1,'piks',10,'likun@gmail.com','premium');

-- 9. Insert a Transaction with a book_id that does not exist in Books
--    (violates FOREIGN KEY)
insert into transaction values (100,100,200,'2026-01-05','2026-01-15','Returned',0);


-- 10. Insert a Transaction with a member_id that does not exist in Members
--     (violates FOREIGN KEY)
insert into transaction values (100,250,350,'2026-01-05','2026-01-15','Returned',0);

-- 11. Insert a Transaction with a NULL issue_date
insert into transaction values(150,500,600,null,'2026-01-15','Returned',0);


-- 12. Insert a Transaction with fine = -50 (violates CHECK)
insert into transaction values (100,250,350,'2026-01-05','2026-01-15','Returned',-50);

