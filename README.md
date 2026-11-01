# 📚 MySQL Practice – Basic to Advanced SQL Concepts

Welcome to my **MySQL Practice Repository!** 🚀

This repository contains my SQL learning journey, covering essential SQL concepts, functions, and queries from basic to advanced levels. It includes practical examples and hands-on exercises to strengthen my database management and query-writing skills.

I created this repository to practice SQL, improve my problem-solving abilities, and build a strong foundation for a career in **Data Analytics and Data Science**.

---

## 📌 Topics Covered

### 1. SQL Basics
- Introduction to SQL
- Database and Table Creation
- CREATE, INSERT, UPDATE, DELETE
- SELECT Statements
- WHERE Clause
- DISTINCT
- ORDER BY
- LIMIT
- AND, OR, NOT Operators
- IN, BETWEEN, LIKE Operators

### 2. Aggregate Functions
Aggregate functions perform calculations on multiple rows and return a single value.

**Functions Covered:**
- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

🔗 **Practice Repository:** [Aggregate Functions & Text Functions](https://github.com/hellomitchellnisith-hue/My-SQL-Practice-1-AGGREGATE-FUNCTIONS-TEXT-FUNCTIONS-)

### 3. Text / String Functions
String functions are used to manipulate and process text data.

**Functions Covered:**
- UPPER()
- LOWER()
- LENGTH()
- CONCAT()
- SUBSTRING()
- TRIM()
- REPLACE()
- LEFT()
- RIGHT()

### 4. Date and Time Functions
Date and time functions are used to manipulate, extract, and calculate date and time values.

**Functions Covered:**
- NOW()
- CURDATE()
- CURTIME()
- YEAR()
- MONTH()
- DAY()
- DAYNAME()
- MONTHNAME()
- DATE_FORMAT()
- DATEDIFF()
- TIMESTAMPDIFF()
- DATE_ADD()
- DATE_SUB()

**Example:**
```sql
-- Get the current date
SELECT CURDATE();

-- Get the current year
SELECT YEAR(CURDATE());

-- Calculate the difference between two dates
SELECT DATEDIFF('2026-12-31', '2026-01-01');
```

### 5. SQL Constraints
Constraints are rules applied to table columns to maintain data accuracy and integrity.

**Types of Constraints:**
- NOT NULL
- UNIQUE
- PRIMARY KEY
- FOREIGN KEY
- CHECK
- DEFAULT
- AUTO_INCREMENT

**Example:**
```sql
CREATE TABLE Students (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Age INT CHECK (Age >= 18),
    City VARCHAR(50) DEFAULT 'Bhubaneswar'
);
```

### 6. SQL Joins
Joins are used to retrieve data from multiple tables based on related columns.

**Types of Joins:**
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- CROSS JOIN
- SELF JOIN

**Example:**
```sql
SELECT 
    Students.Name,
    Departments.Department_Name
FROM Students
INNER JOIN Departments
ON Students.Department_ID = Departments.Department_ID;
```

### 7. Subqueries
A subquery is a query written inside another SQL query. It helps retrieve data based on the results of another query.

**Types of Subqueries:**
- Single Row Subquery
- Multiple Row Subquery
- Nested Subquery
- Correlated Subquery

**Example:**
```sql
SELECT *
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);
```

### 8. Common Table Expressions (CTEs)
CTEs allow us to create temporary named result sets using the WITH clause. They make complex queries easier to read and maintain.

**Topics Covered:**
- Basic CTE
- Multiple CTEs
- Recursive CTE

**Example:**
```sql
WITH AverageSalary AS (
    SELECT AVG(Salary) AS Avg_Salary
    FROM Employees
)
SELECT *
FROM Employees
WHERE Salary > (
    SELECT Avg_Salary
    FROM AverageSalary
);
```

---

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **Language:** SQL
- **Platform:** MySQL Workbench
- **Version Control:** Git & GitHub

---

## 🎯 Learning Objectives

- Understand fundamental SQL concepts.
- Write efficient SQL queries.
- Perform data manipulation and analysis.
- Work with multiple tables using joins.
- Retrieve complex data using subqueries and CTEs.
- Develop problem-solving skills through practical SQL exercises.
- Build a strong foundation for Data Analytics and Data Science.

---

## 📈 My Learning Journey

I believe in learning by doing. This repository will be updated regularly as I explore new SQL concepts, solve practical problems, and improve my database querying skills.

**Learning | Practicing | Improving | Growing 🚀**

---

⭐ If you find this repository helpful, feel free to explore and connect with me!
