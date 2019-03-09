with CurrentStudent(StudentRegistrationId) as (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE degreeid = %2% and studentid = %1%) SELECT CourseName, grade FROM CourseRegistrations cr INNER JOIN CurrentStudent srd ON (cr.StudentRegistrationId = srd.StudentRegistrationId) INNER JOIN CourseOffers co ON (co.courseofferid = cr.courseofferid) WHERE grade >=5 ORDER BY year, quartile, co.courseofferid;
SELECT distinct gdnf.studentid from gotdegreenofail gdnf where gdnf.GPA > %1% order by gdnf.studentid;
WITH pointsPerS(studentregistrationid, sumECTS) as (SELECT CR.studentregistrationid, sum(CO.ECTS) FROM courseRegistrations CR, CourseOffers CO WHERE CR.CourseOfferId = CO.CourseOfferId and CR.Grade >= 5 GROUP BY CR.studentregistrationid), have_not_taken_yet(studentregistrationid, sumECTS) as (SELECT studentregistrationid, 0 FROM (SELECT studentregistrationid FROM studentRegistrationsToDegrees D EXCEPT SELECT studentregistrationid FROM pointsPerS) as new), activeStudents(studentId, DegreeId) as (SELECT SD.StudentId, D.DegreeId FROM pointsPerS as almost, studentRegistrationsToDegrees SD, degrees D WHERE almost.studentregistrationid = sd.studentregistrationid and D.degreeid = SD.DegreeID and D.totalects > almost.sumECTS UNION SELECT SD.studentid, SD.DegreeID FROM studentRegistrationsToDegrees SD, have_not_taken_yet HY WHERE SD.studentregistrationid = HY.studentregistrationid) SELECT A.DegreeId, count(CASE WHEN S.Gender = 'F' THEN 1 END)/count(S.StudentId)::float as femalePercentage FROM Students S, ActiveStudents A WHERE S.StudentId = A.StudentId GROUP BY A.DegreeId ORDER BY A.DegreeId;
SELECT (cast(SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(s.Gender)) as percentage FROM Students s INNER JOIN StudentRegistrationsToDegrees srd on (s.StudentId = srd.StudentId) INNER JOIN Degrees d on (srd.DegreeId = d.DegreeId) WHERE (d.Dept =  %1%);
SELECT CourseId, COUNT(CASE WHEN Grade >= %1% THEN 1 END)/ (cast(Count(Grade) as float)) AS percentagePassing FROM CourseRegistrations WHERE Grade IS NOT NULL GROUP BY CourseId;
SELECT * FROM(SELECT StudentId, COUNT(CASE WHEN cr.Grade = mg.MaxGrade THEN 1 END) AS numberOfCoursesWhereExcellent FROM CourseRegistrations cr INNER JOIN MaxGradesQ1 mg ON (cr.CourseOfferId = mg.CourseOfferId) GROUP BY StudentId) as subquery WHERE numberOfCoursesWhereExcellent >= %1%;
SELECT 0;
with studentPerCourse(courseofferid, cnt) as (SELECT courseofferid, count(studentregistrationid) FROM courseregistrations GROUP BY courseofferid), assistantPerCourse(courseofferid, cnt2) as (SELECT courseofferid, count(studentregistrationid) FROM studentassistants GROUP BY courseofferid), tooMuchPeople(CourseOfferId) as (SELECT ac.courseofferid FROM studentPerCourse sc LEFT JOIN assistantPerCourse ac ON (sc.CourseOfferId = ac.CourseOfferId) WHERE ceil(cnt/50) > cnt2 or cnt is null ) SELECT courseName, year, quartile, co.courseofferid FROM tooMuchPeople tmp INNER JOIN courseoffers co ON (tmp.courseofferid = co.courseofferid) ORDER BY co.courseofferid;
