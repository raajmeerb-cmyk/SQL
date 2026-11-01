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
create database practice_5;
use practice_5;

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

select * from ships;
select * from sailors;
select * from voyagelogs;

/* ============================================================
   SECTION A: SUBQUERY IN WHERE CLAUSE
   ============================================================ */

-- Q1. Find all sailors who work on the ship 'MV Sagar Kanya'.
select sailor_name,sailor_id
from sailors
where ship_id = (select ship_id from ships where ship_name = 'MV Sagar Kanya' );

-- Q2. Find the ship details where sailor 'Priya Sharma' is posted.
select *
from ships
where ship_id = (select ship_id from sailors where sailor_name = 'Priya Sharma' );

-- Q3. Find all voyage logs of the sailor with the highest age.
select log_id
from voyagelogs
where sailor_id = (select sailor_id from sailors
				  where age = (select max(age) from sailors));

-- Q4. Find the ship that was built in the same year as 'MV Ratna Prabha'.
select ship_id,ship_name
from ships
where built_year = (select built_year from ships where ship_name = 'MV Ratna Prabha' );


-- Q5. Find all sailors whose age is greater than the age of 'Anjali Singh'.
select sailor_name
from sailors
where age = (select age from sailors where sailor_name = 'Anjali Singh');

-- Q6. Find all voyage logs belonging to the sailor who has rank 'Captain'
--     and works on ship_id 1.
select log_id,sailor_id
from voyagelogs
where sailor_id = (select sailor_id from sailors where rank_name = 'Captain' and ship_id = 1);

-- Q7. Find the sailor(s) who logged the maximum distance_covered_nm in a
--     single voyage (use a subquery with MAX).
select sailor_id,sailor_name
from sailors
where sailor_id in (select sailor_id  from voyagelogs where distance_covered_nm = (select max(distance_covered_nm)from voyagelogs)); 

-- Q8. Find all ships whose capacity_tons is greater than the capacity of
--     'MV Konkan Voyager'.
select ship_id,ship_name
from ships
where capacity_tons > (select capacity_tons from ships where ship_name = 'MV Konkan Voyager'); 

-- Q9. Find the sailor with the lowest age on the ship 'MV Nilgiri Express'.
select sailor_name,age
from sailors
where ship_id = (select ship_id from ships where ship_name = 'MV Nilgiri Express')
 order by age asc
 limit 1;

-- Q10. Find all voyage logs where hours_on_duty is greater than the average
--      hours_on_duty across all logs.
select log_id
from voyagelogs
where hours_on_duty > (select avg(hours_on_duty) from voyagelogs);


/* ============================================================
   SECTION B: SUBQUERY WITH IN (MULTIPLE VALUES)
   ============================================================ */

-- Q11. Find all sailors who work on ships of type 'Cargo'.
select sailor_name,sailor_id
from sailors
where ship_id in (select ship_id from ships where ship_type = 'Cargo' );

-- Q12. Find all voyage logs of sailors whose rank is 'Engineer'.
select log_id,sailor_id
from voyagelogs
where sailor_id in (select sailor_id from sailors where rank_name = 'Engineer');

-- Q13. Find all ships that have at least one sailor aged above 40.
select ship_id,ship_name 
from ships
where ship_id in (select ship_id from sailors where age > 40);


-- Q14. Find all sailors who have logged a voyage with hours_on_duty
--      greater than 12.
select sailor_id,sailor_name
from sailors
where sailor_id in (select sailor_id from voyagelogs where hours_on_duty > 12);

-- Q15. Find all sailors who belong to ships built after the year 2005.
select sailor_id,sailor_name
from sailors
where ship_id in (select ship_id from ships where built_year > '2005');

-- Q16. Find all voyage logs of sailors who work on 'MV Ratna Prabha' or
--      'MV Coromandel Star'.
select log_id,sailor_id
from voyagelogs
where sailor_id in 
(select sailor_id from sailors where ship_id in 
(select ship_id from ships where ship_name in ('MV Ratna Prabha','MV Coromandel Star') ) );

-- Q17. Find all ships that have at least one sailor with the rank
--      'Captain'.
select ship_id,ship_name
from ships 
where ship_id in 
(select ship_id from sailors where rank_name = 'Captain' );

-- Q18. Find all sailors who have logged at least one voyage with
--      cargo_handled_tons greater than 500.
select sailor_name,sailor_id
from sailors
where sailor_id in 
(select sailor_id from voyagelogs where cargo_handled_tons > 500 );

-- Q19. Find all sailors whose ship_id is among the ships with
--      capacity_tons greater than 40000.
select sailor_id,sailor_name
from sailors
where ship_id in 
(select ship_id from ships where capacity_tons > 40000);

-- Q20. Find all voyage logs where the sailor_id belongs to sailors
--      younger than 30.
select log_id,sailor_id
from voyagelogs
where sailor_id in 
(select sailor_id from sailors where age <30);


/* ============================================================
   SECTION C: BASIC CTE
   ============================================================ */

-- Q21. Using a CTE, find the total distance covered by each sailor
--      across all voyages.
with sailor_distance as (
select s.sailor_id,s.sailor_name,sum(v.distance_covered_nm) as total_distance
from sailors s
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name)
select *
from sailor_distance
order by total_distance desc;

-- Q22. Using a CTE, find the total hours on duty logged by each sailor.
with sailor_hour as 
(select s.sailor_id,s.sailor_name,sum(v.hours_on_duty) as total_hours
from sailors s 
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name)
select * from sailor_hour;

-- Q23. Using a CTE, find sailors whose total cargo handled is greater
--      than 500 tons.
with sailors_cargo as (
select s.sailor_id,s.sailor_name,sum(v.cargo_handled_tons) as total_tons
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id 
group by s.sailor_id,s.sailor_name
having total_tons > 500
)
select * from sailors_cargo;


-- Q24. Using a CTE, find the average distance covered per voyage for
--      each sailor.
with sailor_distance as (
select s.sailor_id,s.sailor_name,round(avg(v.distance_covered_nm),2) as average_distance
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name
)
select * from sailor_distance;

-- Q25. Using a CTE, find the number of voyage logs recorded for each
--      sailor.
with sailor_log as (
select s.sailor_id,s.sailor_name,count(v.log_id) as total_logs
from sailors s
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name)
select * from sailor_log;

-- Q26. Using a CTE, find sailors whose average hours_on_duty is more
--      than 9.
with sailor_duty as (
select s.sailor_id,s.sailor_name,round(avg(v.hours_on_duty),2) as avg_duty
from sailors s 
inner join voyagelogs v 
on s.sailor_id =v.sailor_id
group by s.sailor_id,s.sailor_name
having avg_duty > 9
)
select * from sailor_duty;

-- Q27. Using a CTE, find the maximum distance covered in a single
--      voyage by each sailor.
with sailor_maxdistance as (
select s.sailor_id,s.sailor_name,max(v.distance_covered_nm) as total_distance
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name
)
select * from sailor_maxdistance;

-- Q28. Using a CTE, find the total cargo handled per sailor, showing
--      only sailors with more than 0 tons handled.
with sailor_handles_cargo as (
select s.sailor_id,s.sailor_name,sum(v.cargo_handled_tons) as total_tons
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name
)
select * from sailor_handles_cargo
where total_tons > 0;

-- Q29. Using a CTE, find the minimum hours_on_duty logged by each
--      sailor.
with sailor_min_duty as (
select s.sailor_id,s.sailor_name,min(hours_on_duty) as min_duty
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name
)
select * from sailor_min_duty;

-- Q30. Using a CTE, find the total number of voyages logged on each
--      voyage_date.
with log_date1 as (
select v.voyage_date,count(v.log_id) as total_logs
from voyagelogs v
group by v.voyage_date)
select * from log_date1;

/* ============================================================
   SECTION D: CTE WITH JOINS
   ============================================================ */

-- Q31. Using a CTE, find each sailor's name, ship name, and total
--      distance covered.
with totaldistance as (
select s.sailor_name,s.ship_id,sum(v.distance_covered_nm) as total_distance
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_name,s.ship_id)
select s.ship_name,t.sailor_name,t.total_distance 
from totaldistance t
inner join ships s 
on s.ship_id = t.ship_id;

-- Q32. Using a CTE, find each ship's name along with the total cargo
--      handled by all its sailors combined.
with totalcargo as (
select s.sailor_name,s.ship_id,sum(v.cargo_handled_tons) as total_cargo
from sailors s 
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by s.sailor_name,s.ship_id)
select s.ship_name,s.ship_id,t.sailor_name,t.total_cargo
from totalcargo t 
inner join ships s 
on t.ship_id = s.ship_id
order by total_cargo desc;

-- Q33. Using a CTE, find each sailor's name, rank, and total hours on
--      duty, joined with their ship name.
 with totalhour as (
 select s.ship_id,s.sailor_name,s.rank_name,sum(v.hours_on_duty) as total_hours
 from sailors s 
 inner join voyagelogs v 
 on s.sailor_id = v.sailor_id
 group by s.ship_id,s.sailor_name,s.rank_name)
 select s.ship_name,t.sailor_name,t.rank_name,t.total_hours
 from totalhour t
 inner join ships s 
 on s.ship_id = t.ship_id
 order by total_hours desc;

-- Q34. Using a CTE, find ships whose combined total distance covered
--      (by all sailors) is greater than 2000 nautical miles.
with totaldistance as (
select s.sailor_id,s.ship_id,s.sailor_name,sum(distance_covered_nm) as total_distance
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_id,s.sailor_name)
select s.ship_name,t.sailor_id,t.sailor_name,t.total_distance
from totaldistance t 
inner join ships s 
on s.ship_id = t.ship_id
where total_distance > 2000
order by total_distance desc;

-- Q35. Using a CTE, find each sailor's name and average hours on duty,
--      along with the ship type they work on.
with averagehours as (
select s.ship_id,s.sailor_name,s.sailor_id,avg(v.hours_on_duty) as total_hours
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_name,s.sailor_id)
select s.ship_name,s.ship_type,a.sailor_name,a.total_hours
from averagehours a 
inner join ships s 
on s.ship_id = a.ship_id
order by total_hours desc;

with SailorAveragehoursduty as 
(select s.ship_id,s.sailor_name,
round(avg(v.hours_on_duty),0) as Average_dutyhours
from sailors s 
inner join VoyageLogs v 
on s.sailor_id = v.sailor_id
group by s.ship_id,s.sailor_name)
select sa.sailor_name,s.ship_type,sa.Average_dutyhours
from SailorAveragehoursduty sa 
inner join ships s 
on sa.ship_id = s.ship_id 
order by Average_dutyhours desc;

-- Q36. Using a CTE, find each ship's name and the number of voyage
--      logs recorded by sailors on that ship.
with logrecord as (
select s.ship_id,s.sailor_name,count(v.log_id) as total_logs
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_name,s.ship_id)
select s.ship_name,l.sailor_name,l.total_logs
from logrecord l 
inner join ships s 
on l.ship_id = s.ship_id
order by total_logs desc;

-- Q37. Using a CTE, find sailors whose total distance covered is above
--      the average total distance across all sailors (join required
--      to show ship name too).
with totaldistance as (
select s.ship_id,s.sailor_name,sum(v.distance_covered_nm) as total_distance
from sailors s 
inner join voyagelogs v 
on v.sailor_id = s.sailor_id
group by s.sailor_name,s.ship_id),
avgdistance as (
select avg(total_distance) as avg_distance from totaldistance)
select s.ship_name,t.sailor_name,t.total_distance
from totaldistance t 
join ships s 
on s.ship_id = t.ship_id
cross join avgdistance a
where t.total_distance > a.avg_distance;

-- Q38. Using a CTE, find each rank (Captain, Deck Officer, Engineer)
--      along with the total cargo handled by sailors of that rank.
with sailorrank as (
select s.sailor_id,s.sailor_name,s.rank_name,count(v.cargo_handled_tons) as total_cargo
from sailors s 
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by s.sailor_name,s.sailor_id)
select sr.rank_name,sr.total_cargo 
from sailorrank sr;
 
-- Q39. Using a CTE, find each ship's name and its youngest sailor's age.
with sailorname as (
select s.ship_id,sh.ship_name,min(s.age) as age
from ships sh 
inner join sailors s
on s.ship_id =sh.ship_id
group by s.ship_id,sh.ship_name
)
select * from sailorname;

-- Q40. Using a CTE, find each sailor's name, ship name, and total
--      contribution (distance_covered_nm + cargo_handled_tons).
with cargodistance as (
select s.sailor_id,s.sailor_name,s.ship_id,
round(sum((v.distance_covered_nm)+(v.cargo_handled_tons)),0) as total_contribution
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id
group by s.sailor_name,s.sailor_id,s.ship_id)
select st.ship_name,cd.sailor_name,cd.total_contribution
from cargodistance cd
inner join ships st 
on st.ship_id = cd.ship_id
group by cd.sailor_name,st.ship_name,cd.total_contribution;

/* ============================================================
   SECTION E: JOINS (WITH GROUP BY / HAVING)
   ============================================================ */

-- Q41. List every sailor along with the name of the ship they work on.
select s.sailor_name,sh.ship_name
from sailors s 
inner join ships sh 
on sh.ship_id = s.ship_id
group by s.sailor_name,sh.ship_name;

-- Q42. Find the total number of sailors posted on each ship.
select sh.ship_id,sh.ship_name,count(distinct s.sailor_id) as total_sailors
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id
group by s.ship_id,sh.ship_name;

-- Q43. Find ships that have more than 2 sailors.
select sh.ship_id,sh.ship_name,count(distinct s.sailor_id) as total_sailors
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id
group by s.ship_id,sh.ship_name
having total_sailors > 2;

-- Q44. Find the total distance covered by each ship (joining all three
--      tables).
select sh.ship_id,sh.ship_name,sum(v.distance_covered_nm) as total_distance
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by sh.ship_id,sh.ship_name
order by total_distance desc;

-- Q45. Find ships whose total distance covered is more than 2500
--      nautical miles.
select sh.ship_id,sh.ship_name,sum(v.distance_covered_nm) as total_distance
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id
inner join voyagelogs v
on s.sailor_id = v.sailor_id
group by sh.ship_id,sh.ship_name
having total_distance > 2500
order by total_distance desc; 

-- Q46. Find the total cargo handled by each rank across all ships.
select sh.ship_id,sh.ship_name,s.rank_name,count(v.cargo_handled_tons) as total_cargo
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id 
inner join voyagelogs v 
on v.sailor_id = s.sailor_id
group by sh.ship_id,sh.ship_name,s.rank_name
order by total_cargo desc;

-- Q47. Find ranks where the average hours_on_duty is greater than 9.
select s.rank_name,sum(v.hours_on_duty) as total_hours
from sailors s 
inner join voyagelogs v 
on s.sailor_id = v.sailor_id  
group by s.rank_name
having total_hours > 9
order by total_hours desc;

-- Q48. Find the number of voyage logs recorded for each ship.
select sh.ship_id,sh.ship_name,count(v.log_id) as total_logs
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id
inner join voyagelogs v 
on v.sailor_id = s.sailor_id
group by sh.ship_id,sh.ship_name
order by total_logs desc;

-- Q49. Find ships where the average sailor age is above 35.
select sh.ship_id,sh.ship_name,round(avg(s.age),0) as avg_age
from ships sh 
inner join sailors s 
on sh.ship_id = s.ship_id
group by sh.ship_id,sh.ship_name
having avg_age > 35
order by avg_age desc;

-- Q50. Find the ship with the highest total distance covered (join all
--      three tables, group by ship, sort, and limit to top 1).
select sh.ship_id,sh.ship_name,sum(v.distance_covered_nm) as total_distance
from ships sh
inner join sailors s 
on sh.ship_id = s.ship_id
inner join voyagelogs v 
on v.sailor_id=s.sailor_id
group by sh.ship_id,sh.ship_name
order by total_distance desc
limit 1;

