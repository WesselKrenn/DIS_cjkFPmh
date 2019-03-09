with CurrentStudent(StudentRegistrationId) as (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE degreeid = %2% and studentid = %1%) SELECT CourseName, grade FROM CourseRegistrations cr INNER JOIN CurrentStudent srd ON (cr.StudentRegistrationId = srd.StudentRegistrationId) INNER JOIN CourseOffers co ON (co.courseofferid = cr.courseofferid) WHERE grade >=5 ORDER BY year, quartile, co.courseofferid;
SELECT 0;
SELECT 0;
SELECT (cast(SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(s.Gender)) as percentage FROM Students s INNER JOIN StudentRegistrationsToDegrees srd on (s.StudentId = srd.StudentId) INNER JOIN Degrees d on (srd.DegreeId = d.DegreeId) WHERE (d.Dept =  %1%);
SELECT 0;
SELECT * FROM(SELECT StudentId, COUNT(CASE WHEN cr.Grade = mg.MaxGrade THEN 1 END) AS numberOfCoursesWhereExcellent FROM CourseRegistrations cr INNER JOIN MaxGradesQ1 mg ON (cr.CourseOfferId = mg.CourseOfferId) GROUP BY StudentId) as subquery WHERE numberOfCoursesWhereExcellent >= %1%;
SELECT 0;
SELECT 0;
