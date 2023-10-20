 
 
 pg_dump --help
 
 
 \l                    =>  list dataves
 \d      				=> details of anything
 CREATE DATABASE
 CREATE TABLE new_table();
CREATE TABLE sounds(sound_id SERIAL PRIMARY KEY); ---> in one line 
 ALTER TABLE table_name ADD COLUMN column_name TYPE; 
 ALTER TABLE sounds ADD COLUMN filename VARCHAR(40) NOT NULL UNIQUE;
INSERT INTO teble_name(key, key...) VALUES(value1, valu...), (value1, valu...), ...; -> isnerting data
	UPDATE courses
	SET published_date = '2020-08-01' 
	WHERE course_id = 3;
ALTER TABLE more_info RENAME COLUMN height TO height_in_cm; ===> rename column
CREATE TABLE sounds(sound_id SERIAL PRIMARY KEY); ---> in one line 
 ALTER TABLE characters ADD PRIMARY KEY(character_id);    -> set primary key
 ALTER TABLE characters DROP CONSTRAINT "characters_pkey" => drop prim key 
 
 ALTER TABLE more_info ADD COLUMN character_id INT REFERENCES characters(character_id); ---> add forgen key to table ONE TO MANY
 ALTER TABLE more_info ADD UNIQUE(character_id);     				----> 4 ONE to ONE set to forgen key
 
 ALTER TABLE more_info ALTER COLUMN character_id SET NOT NULL;    ---> set column to not null
 
 SELECT * FROM characters ORDER BY character_id ;
 
 
 MANY TO MANY 
 
 join table with 2 columns same as 
 
 ALTER TABLE character_actions ADD FOREIGN KEY(character_id) REFERENCES characters(character_id); --> add foreign key to join table
 ALTER TABLE character_actions ADD PRIMARY KEY(character_id, action_id);
 
 SELECT * FROM characters FULL JOIN more_info ON characters.character_id = more_info.character_id; --> join 2 tables with foreign key
 
 
 SELECT * FROM character_actions 
FULL JOIN characters ON character_actions.character_id = characters.character_id    ---> join 2 MANY to MANY tables
FULL JOIN actions ON character_actions.action_id = actions.action_id;

 SELECT MAX(gpa) FROM students; MIN SUM AVG CEIL FLOR ROUND(numebr, decimal_places)
 SELECT ROUND(AVG(major_id), 5) FROM students;
 SELECT COUNT(*) FROM students;
 SELECT DISTINCT(major_id) FROM students; sve razlicte iz kolone isto kao i ovo -> SELECT major_id FROM  students GROUP BY major_id;
 
SELECT major_id, COUNT(*) FROM students GROUP BY major_id;
SELECT major_id,MIN(gpa),MAX(gpa) FROM students GROUP BY major_id;

SELECT major_id,MIN(gpa),MAX(gpa) FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0;
 
 SELECT major_id, MIN(gpa) AS min_gpa, MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0;
 
 
 #!/bin/bash

# Info about my computer science students from students database

echo -e "\n~~ My Computer Science Students ~~\n"

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE gpa = 4.0")"

echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo "$($PSQL "SELECT course FROM courses WHERE course < 'D'")"

echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE last_name >= 'R' AND (gpa > 3.8 OR gpa < 2.0)")"

echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"
echo "$($PSQL "SELECT last_name FROM students WHERE last_name ILIKE '%sa%' OR last_name ILIKE '%r_'")"

echo -e "\nFirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' or they have a GPA greater than 3.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE major_id IS NULL AND (first_name LIKE 'D%' OR gpa > 3.0)")"

echo -e "\nCourse name of the first five courses, in reverse alphabetical order, that have an 'e' as the second letter or end with an 's':"
echo "$($PSQL "SELECT course FROM courses WHERE course LIKE '_e%' OR course LIKE '%s' ORDER BY course DESC LIMIT 5")"

echo -e "\nAverage GPA of all students rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(gpa), 2) FROM students")"

echo -e "\nMajor ID, total number of students in a column named 'number_of_students', and average GPA rounded to two decimal places in a column name 'average_gpa', for each major ID in the students table having a student count greater than 1:"
echo "$($PSQL "SELECT major_id, COUNT(*) AS number_of_students, ROUND(AVG(gpa), 2) AS average_gpa FROM students GROUP BY major_id HAVING COUNT(*) > 1")"

echo -e "\nList of majors, in alphabetical order, that either no student is taking or 
          has a student whose first name contains a case insensitive 'ma':"
echo "$($PSQL "SELECT major FROM students FULL JOIN majors ON students.major_id = majors.major_id WHERE major IS NOT NULL AND (student_id IS NULL OR first_name ILIKE '%ma%') ORDER BY major ")"

echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo "$($PSQL "SELECT DISTINCT(course) FROM students RIGHT JOIN majors USING(major_id) INNER JOIN majors_courses USING(major_id) INNER JOIN courses USING(course_id) WHERE (first_name = 'Obie' AND last_name = 'Hilpert') OR student_id IS NULL ORDER BY course DESC")"

echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
echo "$($PSQL "SELECT DISTINCT(course) FROM students INNER JOIN majors USING(major_id) INNER JOIN majors_courses USING(major_id) INNER JOIN courses USING(course_id) GROUP BY course HAVING COUNT(student_id)=1 ORDER BY course")"

