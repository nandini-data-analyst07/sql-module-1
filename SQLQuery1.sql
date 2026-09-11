--QUES-1
--DEPARTMENT TABLE 
create table department (
deptID varchar(10) primary key,
deptname varchar(50)not null ,
location varchar(50),
mrgempID int)

insert into department (deptID,deptname,location,mrgempID) values  (
'd-101','HR','delhi',103),
('D-102', 'Development', 'Mumbai', 102),
('D-103', 'Sales', 'Bengaluru', 104),
('D-104', 'Admin', 'Delhi', NULL)

--PROJECT TABLE 
create table project (
projectID varchar(10)primary key,
projectname varchar(50) not null,
client varchar(10),
budget decimal(12,2))

insert into project (projectID,projectname,client,budget) values (
'p-501','alphalaunch','client A',50000.00),
('P-502', 'Backend Redo', 'Client B', 800000.00),
('P-503', 'New Website', 'Client A', 300000.00),
('P-504', 'Data Migration', 'Client C', 450000.00)

--EMPLOYEE TABLE 
create table employee (
empid int primary key,
empname varchar (50) not null,
deptid varchar(10),
salary decimal(10,2) check (salary>=40000),
projectID varchar(10),
ispermanent varchar (30),
JoiningDate DATE,
FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID))

INSERT INTO Employee (EmpID, EmpName, DeptID, Salary, ProjectID, IsPermanent, JoiningDate) 
VALUES (
101, 'Ankit', 'D-101', 65000.00, 'P-501', 'Yes', '2020-05-15'),
(102, 'Sheetal', 'D-102', 80000.00, 'P-502', 'Yes', '2019-11-20'),
(103, 'Neha', 'D-101', 52000.00, 'P-503', 'No', '2021-01-10'),
(104, 'Rahul', 'D-103', 95000.00, 'P-502', 'Yes', '2018-07-01'),
(105, 'Rohit', 'D-104', 45000.00, NULL, 'No', '2022-03-25'),
(106, 'Priya', 'D-102', 72000.00, 'P-501', 'Yes', '2020-09-01')

--QUES 2
select empname,joiningdate,salary from employee
where JoiningDate <='2020-01-01'and 
empname like 'r%'
order by salary desc 

--QUES 3
select ispermanent,sum(salary) as total_sal,max(salary) as maximum_sal from employee 
group by ispermanent

--QUES 4
SELECT DeptID FROM Employee 
GROUP BY DeptID 
HAVING AVG(Salary) > 65000

--QUES 5
select EmpName 
from Employee 
where DeptID = (select DeptID from Department where DeptName = 'Development')

--QUES 6
select e.EmpName, e.Salary, d.DeptName, p.ProjectName 
from Employee e 
inner join Department d on e.DeptID = d.DeptID 
inner join Project p on e.ProjectID = p.ProjectID

--QUES 7
select d.DeptName, count(e.EmpID) as EmployeeCount 
from Department d 
left join Employee e on d.DeptID = e.DeptID 
group by d.DeptID, d.DeptName;

--QUES 8
select EmpName, Salary, 
case 
when Salary > 80000 then Salary * 0.10 
when Salary >= 60000 and Salary <= 80000 then Salary * 0.05 
else Salary * 0.02 
end as Bonus_Payout 
from Employee

--QUES 9
create procedure GetProjectDetails @MinBudget decimal(10,2)
as
begin
select * from Project where Budget >= @MinBudget;
end;
go
exec GetProjectDetails @MinBudget = 550000.00

--QUES 10
with DelhiEmployees as (
select e.EmpID, e.EmpName, e.Salary 
from Employee e 
inner join Department d on e.DeptID = d.DeptID 
where d.Location = 'Delhi'
)
select EmpName, Salary 
from DelhiEmployees 
where Salary > 50000

--QUES 11
update Employee set Salary = Salary * 1.15 where EmpID = 103;

delete from Employee where IsPermanent = 'No';

insert into Employee (EmpID, EmpName, DeptID, Salary, ProjectID, IsPermanent, JoiningDate) 
values (107, 'Jatin', 'D-103', 68000.00, 'P-504', 'Yes', cast(getdate() as date))