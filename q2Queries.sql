with CurrentStudent(StudentRegistrationId) as (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE degreeid = %2% and studentid = %1%) SELECT CourseName, grade FROM CourseRegistrations cr INNER JOIN CurrentStudent srd ON (cr.StudentRegistrationId = srd.StudentRegistrationId) INNER JOIN CourseOffers co ON (co.courseofferid = cr.courseofferid) WHERE grade >=5 ORDER BY year, quartile, co.courseofferid;
SELECT 0;
SELECT 0;
SELECT (cast(SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(s.Gender)) as percentage FROM Students s INNER JOIN StudentRegistrationsToDegrees srd on (s.StudentId = srd.StudentId) INNER JOIN Degrees d on (srd.DegreeId = d.DegreeId) WHERE (d.Dept =  %1%);
SELECT CourseId, COUNT(CASE WHEN Grade >= 5 THEN 1 END)*100/ (cast(Count(Grade) as float)) AS percentagePassing FROM CourseRegistrations WHERE Grade IS NOT NULL GROUP BY CourseId;
SELECT * FROM(SELECT StudentId, COUNT(CASE WHEN cr.Grade = mg.MaxGrade THEN 1 END) AS numberOfCoursesWhereExcellent FROM CourseRegistrations cr INNER JOIN MaxGradesQ1 mg ON (cr.CourseOfferId = mg.CourseOfferId) GROUP BY StudentId) as subquery WHERE numberOfCoursesWhereExcellent >= %1%;
SELECT 0;
with reee(courseofferid, cnt) as (SELECT courseofferid, count(studentregistrationid) FROM courseregistrations GROUP BY courseofferid), 
reee2(courseofferid, cnt2) as (SELECT courseofferid, count(studentregistrationid) FROM studentassistants GROUP BY courseofferid),
reee3(courseofferid, cnt, year, quartile, coursename) as (SELECT r.courseofferid, cnt, year, quartile, coursename FROM reee r INNER JOIN courseoffers co ON (co.courseofferid = r.courseofferid))  

SELECT coursename, year, quartile FROM reee3 r INNER JOIN reee2 r2 ON(r.courseofferid = r2.courseofferid) WHERE cnt2 < (((cnt - 1) / 50) + 1);
