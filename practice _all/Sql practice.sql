create database aaryan;
use aaryan;

-- table creation -->
Create table student(
rollno int primary key,
name varchar(200),
class varchar(200),
marks int);

select * from student;
-- insert data into table-->
insert into student(rollno,name,class,marks) values(01,"Aaryan","BCA",75),
(02,"Krishana","BA",60), (03,"Deepak","BCA",85),(04,"Anurag","BCA",80);  
 springboottesting
 -- delete data from table-->
 delete from student where rollno=04;
 
 -- change marks in table-->
 update student set marks =90 where rollno=02;
 
 -- change datayype in table-->
 alter table student modify class varchar(200);
 
 -- change column name in table -->
 alter table student change rollno Rollno int;
 
 -- add new column in table -->
 alter table student add  column email varchar(200);
 
 -- delete column from the table -->
 alter table student drop column email;
 
 --  Aggregate SQL function -->
 select count(*) from student;
 select max(marks) from student;
 select min(marks) from student;
 select sum(marks) from student;
 select avg(marks) from student;
 
 -- string sql function-->
 select lower(name) from student;
 select upper(name) from student;
 select length(name) from student;
 select concat(name,' kumar') from student;
 select substr(name,3,6) from student;
 select trim(' hello ') from student;
 
 -- date and time function -->
 select current_date();
 select year('17-9-2025');
 select now();
 
 -- conditional function -->
 SELECT CASE WHEN marks > 75 THEN 'PASS' ELSE 'FAIL' END FROM student;
SELECT IF(marks >= 90, 'Topper', 'Average') FROM student;

-- where clause -->
select Rollno,name from student where marks >=90;

-- group by -->
select marks, count(*) from student group by marks;

-- having  clause -->
select marks, count(*) from student group by marks having marks >=85;

-- order by -->
select * from student order by name desc;


--  foreign key and inner join (common record) -->
create table teacher(
id int primary key,
name varchar(200),
Rollno int,
class varchar(200),
foreign key (Rollno) references student(Rollno)); 

insert into teacher(id,name,Rollno,class) values(101,"Eshan",01,"BCA"), (102,"Swati",02,"BBA"),(103,"Prachi",03,"BSC");

SELECT student.name ,student.marks, teacher.name 
FROM student
INNER JOIN teacher ON student.Rollno = teacher.Rollno;

-- left join -->
SELECT student.Rollno,student.name ,student.marks,teacher.id,teacher.name 
FROM student
left JOIN teacher ON student.Rollno = teacher.Rollno;

-- Right join -->
SELECT student.Rollno,student.name ,student.marks,teacher.id,teacher.name 
FROM student
right JOIN teacher ON student.Rollno = teacher.Rollno;

-- Outer join (all data)-->

SELECT student.Rollno,student.name ,student.marks,teacher.id,teacher.name 
FROM student
left JOIN teacher ON student.Rollno = teacher.Rollno
union
SELECT student.Rollno,student.name ,student.marks,teacher.id,teacher.name 
FROM student
right JOIN teacher ON student.Rollno = teacher.Rollno;

-- SQL Transaction -->
commit



