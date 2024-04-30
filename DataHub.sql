create database DataHub;
use DataHub;
create table employee(
id int,
salary int,
name nvarchar(255),
city nvarchar(255),
company_name nvarchar(255),
);
insert into employee(id,name,salary,city,company_name) 
values
(1,'John',1000,'Kuala Lumpur','Tesla'),
(2,'Eliyeen',2000,'Dhaka','Bkash'),
(3, 'John Doe', 5000, 'New York', 'ABC Corp'),
(4, 'Jane Smith', 6000, 'Los Angeles', 'XYZ Company'),
(6, 'Emily Davis', 4800, 'San Francisco', 'Tech Solutions'),
(7, 'David Brown', 7000, 'Dhaka', 'Innovate Corp'),
(8, 'Sophia Garcia', 5200, 'Chicago', '123 Inc');
insert into employee(id,name,salary,city,company_name) 
values(5, 'Ricky', 5000, 'Chicago', 'Infosys');
--Select commands
SELECT * FROM employee;
select name,company_name,salary from employee;
select distinct city,company_name,name from employee;
select * from employee
where salary>=4000;
select * from employee
where city='Chicago' and salary>=5000;
--Delete commands
DELETE FROM employee
WHERE salary = 5200 and city='Miami';
DELETE FROM employee
WHERE salary = 5000 and city='Chicago';
--Common Table Expressions
WITH CTE AS (
    SELECT id, name, salary, city, company_name,
           ROW_NUMBER() OVER (PARTITION BY id, name, salary, city, company_name ORDER BY (SELECT NULL)) AS RowNumber
    FROM employee
)
DELETE FROM CTE WHERE RowNumber > 1;

--Order by (ASC and DESC)

select * from employee
order by salary;

select * from employee
order by salary desc;

--AND, OR, NOT

select * from employee
where name='Eliyeen' AND company_name='Bkash';

select * from employee
where name='John' or city='Chicago';

select * from employee
where not salary <= 5000;

--IN Operator

select * from employee
where  name IN('John','Ricky');

select * from employee
where  name NOT IN('John','Ricky');

--BETWEEN Operator

select * from employee
where salary between 5000 and 7000;

select * from employee
where salary not between 5000 and 7000;

select * from employee
where salary between 5000 and 7000;

select * from employee 
where name between 'D' and 'S'
order by name;

select * from employee 
where name between 'D' and 'S' and salary between 5000 and 9000
order by city;

-- Add and Alter

ALTER TABLE employee
ADD hire_date DATE;
insert into employee (hire_date)
VALUES
('2023-05-12'),
('2022-09-28'),
('2024-01-15'),
('2023-07-03'),
('2022-11-20'),
('2024-03-08'),
('2023-08-17'),
('2022-12-30');

ALTER TABLE employee
DROP COLUMN hire_date;

--Delete 
DELETE FROM employee
WHERE id IS NULL
   OR name IS NULL
   OR salary IS NULL
   OR city IS NULL
   OR company_name IS NULL;

 --Like Operator
   select * from employee
   where name like 'J%';

   select * from employee
   where company_name like 'T%';

   select * from employee
   where name  not like 'J%';
  
   select * from employee
   where name like '_O%';

   --Max and Min

  select MAX(Salary) as Result
   from employee;

 select MAX(company_name) as Output
   from employee;

  select min(Salary) as Result
   from employee;

 select min(city) as City
   from employee;

 --SUM and AVG

SELECT SUM(salary) AS total_salary
FROM employee;

SELECT SUM(salary) AS total_salary
FROM employee
where salary>= 5000;

SELECT SUM(salary) AS total_salary
FROM employee
where salary<= 5000;

SELECT AVG(salary) AS average_salary
FROM employee;

SELECT AVG(salary) AS average_salary
FROM employee
where salary>= 4000;

--Count

SELECT COUNT(*) FROM employee;

select COUNT(salary) from employee
where salary> 5000;

select COUNT(salary) from employee
where salary>= 5000 and name like 'J%';

-- Not Null, Unique, Primary Key, Foreign Key

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
	);

INSERT INTO department (department_id, department_name)
VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'Marketing'),
(4, 'IT'),
(5, 'Operations'),
(6, 'Sales'),
(7, 'Customer Service'),
(8, 'Research and Development');

	Drop table employee;

-- Recreating the table again
CREATE TABLE employee (
    id INT PRIMARY KEY,
    salary INT,
    name NVARCHAR(255) UNIQUE,
    city NVARCHAR(255),
    company_name NVARCHAR(255),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);
insert into employee(id,name,salary,city,company_name,department_id) 
values
(1,'John',1000,'Kuala Lumpur','Tesla',1),
(2,'Eliyeen',2000,'Dhaka','Bkash',2),
(3, 'John Doe', 5000, 'New York', 'ABC Corp',3),
(4, 'Jane Smith', 6000, 'Los Angeles', 'XYZ Company',4),
(5, 'Ricky', 5000, 'Chicago', 'Infosys',5),
(6, 'Emily Davis', 4800, 'San Francisco', 'Tech Solutions',6),
(7, 'David Brown', 7000, 'Dhaka', 'Innovate Corp',7),
(8, 'Sophia Garcia', 5200, 'Chicago', '123 Inc',8);

select * from employee;

-- Join tables
 
 SELECT 
    e.id,
    e.name AS employee_name,
    e.salary,
    e.city,
    e.company_name,
    d.department_name
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id;

-- ASC AND DESC COMMAND
SELECT name
FROM employee
ORDER BY name ASC;

SELECT salary
FROM employee
ORDER BY salary DESC;

--Update

UPDATE employee
SET salary = 6500
WHERE department_id = 3;

UPDATE employee
SET name = 'Sara'
WHERE department_id = 2;

select * from employee;

--Aliases
SELECT name AS Beautiful_Name
FROM employee;

--Stored Procedures and Indexes

create procedure Records
AS 
Select * from employee
GO;

exec Records;

CREATE INDEX idx_employee_name ON employee (name);

-- Backup Table with select into statement

SELECT *
INTO employee2024
FROM employee;

select * from employee2024;

--Backup Database in disk

backup database DataHub
 to disk= 'copy path where you want to save'

 --THANKS AND HAVE A GREAT SQL JOURNEY