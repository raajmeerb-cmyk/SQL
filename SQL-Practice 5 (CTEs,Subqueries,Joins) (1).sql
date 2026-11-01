/* ============================================================
   PRACTICE FILE: SUBQUERIES, CTEs AND JOINS
   Scenario: Merchant Navy Operations
   Tables: Ships -> Sailors -> VoyageLogs
   ============================================================
   Ships      : the vessels operated by the shipping company
   Sailors    : crew members, each posted on one ship
   VoyageLogs : each sailor's logged duty record for a voyage

   Write the SQL query below each question.
   ============================================================ */


/* ------------------------------------------------------------
   TABLE 1: Ships (Parent table)
   ------------------------------------------------------------ */

CREATE TABLE Ships (
    ship_id INT PRIMARY KEY,
    ship_name VARCHAR(50) NOT NULL UNIQUE,
    ship_type VARCHAR(30) NOT NULL,
    capacity_tons INT CHECK (capacity_tons > 0),
    built_year INT CHECK (built_year >= 1950)
);

INSERT INTO Ships VALUES
(1, 'MV Sagar Kanya', 'Cargo', 45000, 2005),
(2, 'MV Ratna Prabha', 'Tanker', 62000, 1998),
(3, 'MV Nilgiri Express', 'Container', 38000, 2012),
(4, 'MV Coromandel Star', 'Bulk Carrier', 55000, 2001),
(5, 'MV Konkan Voyager', 'Cargo', 30000, 2016);


/* ------------------------------------------------------------
   TABLE 2: Sailors (Child of Ships)
   ------------------------------------------------------------ */

CREATE TABLE Sailors (
    sailor_id INT PRIMARY KEY,
    sailor_name VARCHAR(50) NOT NULL,
    rank_name VARCHAR(30) NOT NULL,
    ship_id INT,
    age INT CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (ship_id) REFERENCES Ships(ship_id)
);

INSERT INTO Sailors VALUES
(101, 'Ravi Kumar', 'Captain', 1, 42, 'ravi.kumar@merchantnavy.com'),
(102, 'Aman Gupta', 'Deck Officer', 1, 29, 'aman.gupta@merchantnavy.com'),
(103, 'Priya Sharma', 'Engineer', 2, 35, 'priya.sharma@merchantnavy.com'),
(104, 'Karan Mehta', 'Captain', 2, 47, 'karan.mehta@merchantnavy.com'),
(105, 'Sneha Iyer', 'Deck Officer', 3, 27, 'sneha.iyer@merchantnavy.com'),
(106, 'Rohit Verma', 'Engineer', 3, 33, 'rohit.verma@merchantnavy.com'),
(107, 'Divya Nair', 'Captain', 4, 45, 'divya.nair@merchantnavy.com'),
(108, 'Anjali Singh', 'Deck Officer', 4, 26, 'anjali.singh@merchantnavy.com'),
(109, 'Vikram Rao', 'Engineer', 5, 31, 'vikram.rao@merchantnavy.com'),
(110, 'Neha Joshi', 'Captain', 5, 39, 'neha.joshi@merchantnavy.com');


/* ------------------------------------------------------------
   TABLE 3: VoyageLogs (Child of Sailors)
   ------------------------------------------------------------ */

CREATE TABLE VoyageLogs (
    log_id INT PRIMARY KEY,
    sailor_id INT,
    voyage_date DATE,
    distance_covered_nm INT CHECK (distance_covered_nm >= 0),
    hours_on_duty INT CHECK (hours_on_duty BETWEEN 0 AND 24),
    cargo_handled_tons DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (sailor_id) REFERENCES Sailors(sailor_id)
);

INSERT INTO VoyageLogs VALUES
(1, 101, '2026-05-01', 1200, 10, 500.00),
(2, 101, '2026-05-08', 950, 8, 300.00),
(3, 102, '2026-05-01', 1200, 12, 0.00),
(4, 102, '2026-05-08', 950, 9, 0.00),
(5, 103, '2026-05-02', 1600, 11, 800.00),
(6, 104, '2026-05-02', 1600, 14, 0.00),
(7, 104, '2026-05-09', 1100, 10, 0.00),
(8, 105, '2026-05-03', 700, 7, 200.00),
(9, 106, '2026-05-03', 700, 9, 650.00),
(10, 106, '2026-05-10', 900, 10, 400.00),
(11, 107, '2026-05-04', 1400, 13, 0.00),
(12, 108, '2026-05-04', 1400, 8, 0.00),
(13, 108, '2026-05-11', 1000, 6, 0.00),
(14, 109, '2026-05-05', 500, 6, 900.00),
(15, 110, '2026-05-05', 500, 12, 0.00),
(16, 110, '2026-05-12', 1300, 11, 0.00);

-- Note: Deck Officers and Captains have 0 cargo_handled_tons in most rows
-- since cargo handling is primarily logged for Engineers -- useful for
-- filtering and comparison questions.


/* ============================================================
   SECTION A: SUBQUERY IN WHERE CLAUSE
   ============================================================ */

-- Q1. Find all sailors who work on the ship 'MV Sagar Kanya'.


-- Q2. Find the ship details where sailor 'Priya Sharma' is posted.


-- Q3. Find all voyage logs of the sailor with the highest age.


-- Q4. Find the ship that was built in the same year as 'MV Ratna Prabha'.


-- Q5. Find all sailors whose age is greater than the age of 'Anjali Singh'.


-- Q6. Find all voyage logs belonging to the sailor who has rank 'Captain'
--     and works on ship_id 1.


-- Q7. Find the sailor(s) who logged the maximum distance_covered_nm in a
--     single voyage (use a subquery with MAX).


-- Q8. Find all ships whose capacity_tons is greater than the capacity of
--     'MV Konkan Voyager'.


-- Q9. Find the sailor with the lowest age on the ship 'MV Nilgiri Express'.


-- Q10. Find all voyage logs where hours_on_duty is greater than the average
--      hours_on_duty across all logs.



/* ============================================================
   SECTION B: SUBQUERY WITH IN (MULTIPLE VALUES)
   ============================================================ */

-- Q11. Find all sailors who work on ships of type 'Cargo'.


-- Q12. Find all voyage logs of sailors whose rank is 'Engineer'.


-- Q13. Find all ships that have at least one sailor aged above 40.


-- Q14. Find all sailors who have logged a voyage with hours_on_duty
--      greater than 12.


-- Q15. Find all sailors who belong to ships built after the year 2005.


-- Q16. Find all voyage logs of sailors who work on 'MV Ratna Prabha' or
--      'MV Coromandel Star'.


-- Q17. Find all ships that have at least one sailor with the rank
--      'Captain'.


-- Q18. Find all sailors who have logged at least one voyage with
--      cargo_handled_tons greater than 500.


-- Q19. Find all sailors whose ship_id is among the ships with
--      capacity_tons greater than 40000.


-- Q20. Find all voyage logs where the sailor_id belongs to sailors
--      younger than 30.



/* ============================================================
   SECTION C: BASIC CTE
   ============================================================ */

-- Q21. Using a CTE, find the total distance covered by each sailor
--      across all voyages.


-- Q22. Using a CTE, find the total hours on duty logged by each sailor.


-- Q23. Using a CTE, find sailors whose total cargo handled is greater
--      than 500 tons.


-- Q24. Using a CTE, find the average distance covered per voyage for
--      each sailor.


-- Q25. Using a CTE, find the number of voyage logs recorded for each
--      sailor.


-- Q26. Using a CTE, find sailors whose average hours_on_duty is more
--      than 9.


-- Q27. Using a CTE, find the maximum distance covered in a single
--      voyage by each sailor.


-- Q28. Using a CTE, find the total cargo handled per sailor, showing
--      only sailors with more than 0 tons handled.


-- Q29. Using a CTE, find the minimum hours_on_duty logged by each
--      sailor.


-- Q30. Using a CTE, find the total number of voyages logged on each
--      voyage_date.



/* ============================================================
   SECTION D: CTE WITH JOINS
   ============================================================ */

-- Q31. Using a CTE, find each sailor's name, ship name, and total
--      distance covered.


-- Q32. Using a CTE, find each ship's name along with the total cargo
--      handled by all its sailors combined.


-- Q33. Using a CTE, find each sailor's name, rank, and total hours on
--      duty, joined with their ship name.


-- Q34. Using a CTE, find ships whose combined total distance covered
--      (by all sailors) is greater than 2000 nautical miles.


-- Q35. Using a CTE, find each sailor's name and average hours on duty,
--      along with the ship type they work on.


-- Q36. Using a CTE, find each ship's name and the number of voyage
--      logs recorded by sailors on that ship.


-- Q37. Using a CTE, find sailors whose total distance covered is above
--      the average total distance across all sailors (join required
--      to show ship name too).


-- Q38. Using a CTE, find each rank (Captain, Deck Officer, Engineer)
--      along with the total cargo handled by sailors of that rank.


-- Q39. Using a CTE, find each ship's name and its youngest sailor's age.


-- Q40. Using a CTE, find each sailor's name, ship name, and total
--      contribution (distance_covered_nm + cargo_handled_tons).



/* ============================================================
   SECTION E: JOINS (WITH GROUP BY / HAVING)
   ============================================================ */

-- Q41. List every sailor along with the name of the ship they work on.


-- Q42. Find the total number of sailors posted on each ship.


-- Q43. Find ships that have more than 2 sailors.


-- Q44. Find the total distance covered by each ship (joining all three
--      tables).


-- Q45. Find ships whose total distance covered is more than 2500
--      nautical miles.


-- Q46. Find the total cargo handled by each rank across all ships.


-- Q47. Find ranks where the average hours_on_duty is greater than 9.


-- Q48. Find the number of voyage logs recorded for each ship.


-- Q49. Find ships where the average sailor age is above 35.


-- Q50. Find the ship with the highest total distance covered (join all
--      three tables, group by ship, sort, and limit to top 1).

