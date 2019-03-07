-- ATTENTION: Remove the comments and the example before submitting
-- This file should contain exactly 8 lines, without any comment. Each line will correspond to one of the 8 sub-questions of question 2.
-- Do not break long queries to more than one line, and do not leave empty lines between them. 
-- If you do not know the answer to one of the sub-questions, then write SELECT 0;
-- Example: Let's say I only know sub-question 3:
--with PassedCourses(CourseName, Grade, Year, Quartile, CourseOfferId) as (SELECT CourseName, Grade, Year, Quartile, co.CourseOfferId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE c.CourseId = co.CourseId and co.CourseOfferId = cr.CourseOfferID and grade >= 5 and DegreeId = %2% and StudentRegistrationId in (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE StudentId = %1%) ORDER BY year, quartile, CourseOfferId) SELECT CourseName, grade FROM PassedCourses;
--SELECT 0;
--with activestudents(StudentregistrationId) as (SELECT StudentregistrationId FROM Degrees d INNER JOIN  Courses c ON (d.degreeid= c.degreeid) INNER JOIN Courseoffers co ON ( c.courseID = co.courseId) INNER JOIN Courseregistrations cr ON (co.Courseofferid = cr.courseofferid) GROUP BY StudentregistrationId HAVING max(totalECTS) < sum(ECTS)) SELECT degreeId, 100*count(case when gender = 'F' then 1.0 end)/count(*) FROM activestudents a INNER JOIN StudentregistrationsToDegrees srd ON (a.Studentregistrationid = srd.studentregistrationid) INNER JOIN Students s ON (srd.StudentId = s.StudentId) GROUP BY degreeId;
--with GenPerDept(amount, gen) as (SELECT count(Gender), Gender FROM Students s, StudentRegistrationsToDegrees srd, degrees d WHERE Dept = %1% and d.DegreeId = srd.DegreeId and s.StudentId = srd.StudentId GROUP BY Gender) SELECT 100*amount(SELECT sum(amount) FROM GenPerDept) FROM GenPerDept WHERE Gen = 'F'; 
--with AmountPassed(amount, courseid) as (SELECT count(Grade), c.CourseId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE Grade >= %1% and c.courseid = co.courseid and co.courseofferid = cr.courseofferid GROUP BY c.CourseID), AmountFailed(amount, courseid) as (SELECT count(Grade), c.CourseId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE Grade < %1% and c.courseid = co.courseid and co.courseofferid = cr.courseofferid GROUP BY c.CourseID) SELECT ap.CourseId, 100*ap.amount/(af.amount + ap.amount) FROM AmountFailed af, AmountPassed ap WHERE ap.courseid = af.courseid ORDER BY ap.courseid;
--SELECT 0;
--SELECT 0;
--SELECT 0;




-- From wesselKrenn1:

\timing
-- Q1 
-- takes 7 ms
SELECT CourseName, Grade FROM PassedCoursesPerStudent WHERE DegreeId = 1099 AND StudentId = 2 Order By year, quartile, courseofferid;
-- Q2 
-- takes a bit more than 1 minute (is executed 10 times so 10 mins aka not good)
SELECT DISTINCT StudentRegistrationsToDegrees.StudentId FROM StudentRegistrationsToDegrees INNER JOIN GPAAndECTSCount on (StudentRegistrationsToDegrees.StudentRegistrationId = GPAAndECTSCount.StudentRegistrationId) INNER JOIN CourseRegistrations on (GPAAndECTSCount.StudentRegistrationId = CourseRegistrations.StudentRegistrationId) INNER JOIN Degrees on (StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId) WHERE (GPAAndECTSCount.TotalECTSAcquired >= Degrees.TotalECTS AND CourseRegistrations.Grade > 5.0 AND GPAAndECTSCount.GPA > 9.0);
-- Duurt ages > 10 minutes aka SHIT
WITH crf (regId) AS (SELECT DISTINCT cr.StudentRegistrationId FROM CourseRegistrations AS cr WHERE cr.Grade < 5), temp (StudId, DegId) AS (SELECT DISTINCT srtd.StudentId, srtd.DegreeId FROM (SELECT * FROM CourseRegistrations AS cr WHERE NOT EXISTS (SELECT * FROM crf WHERE crf.regId = cr.StudentRegistrationId)) as cre INNER JOIN CourseOffers AS co ON cre.courseOfferId = co.courseOfferId INNER JOIN Courses AS c ON c.CourseId = co.CourseId INNER JOIN StudentRegistrationsToDegrees AS srtd ON srtd.StudentRegistrationId = cre.StudentRegistrationId INNER JOIN Degrees AS d ON d.DegreeId = srtd.DegreeId GROUP BY srtd.StudentId, srtd.DegreeId, d.TotalECTS HAVING AVG(cre.Grade) = 9.5 AND SUM(c.ECTS) >= d.TotalECTS) SELECT DISTINCT temp.StudId FROM temp;
-- Q3 
-- Takes 26 seconds good enough I guess
SELECT Degrees.DegreeId, (cast(SUM(CASE WHEN Students.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(Students.Gender)) as female_percent
FROM Students INNER JOIN StudentRegistrationsToDegrees on (Students.StudentId = StudentRegistrationsToDegrees.StudentId) INNER JOIN Degrees on (StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId)
GROUP BY Degrees.DegreeId;
-- Q4
-- takes a 2.5 seconds (is executed 10 times)
SELECT (cast(SUM(CASE WHEN Students.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(Students.Gender)) as female_percent
FROM Students INNER JOIN StudentRegistrationsToDegrees on (Students.StudentId = StudentRegistrationsToDegrees.StudentId) INNER JOIN Degrees on (StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId)
WHERE (Degrees.Dept = %1%);
-- Q5
-- Takes almost 2 minutes (executed 5 times so still too slow)
SELECT CourseId, COUNT(Grade), COUNT(CASE WHEN Grade >= 5 THEN 1 END), CAST(COUNT(CASE WHEN Grade >= 5 THEN 1 END) AS FLOAT) / COUNT(Grade) AS percentagePassing FROM CourseRegistrations INNER JOIN CourseOffers ON (CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId) WHERE Grade IS NOT NULL GROUP BY CourseId;
-- Q6
-- takes 33 seconds (executed 3 times (1, 2, 3)
SELECT * FROM (SELECT StudentRegistrationId, COUNT(CASE WHEN CourseRegistrations.Grade = MaxGrades.MaxGrade THEN 1 END) AS NrOfExcellentCourses FROM CourseRegistrations INNER JOIN MaxGrades ON (CourseRegistrations.CourseOfferId = MaxGrades.CourseOfferId) GROUP BY StudentRegistrationId) AS s WHERE nrOfExcellentCourses >= %1%;
-- Q7 
-- check for actieve studenten moet nog toegevoegd worden
SELECT StudentRegistrationsToDegrees.DegreeId, Students.BirthyearStudent, Students.Gender, AVG(CourseRegistrations.Grade) FROM StudentRegistrationsToDegrees INNER JOIN Students on (StudentRegistrationsToDegrees.StudentId = Students.StudentId) INNER JOIN CourseRegistrations on (StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId) GROUP BY (StudentRegistrationsToDegrees.DegreeId, Students.BirthyearStudent, Students.Gender);
-- Q8
-- !!!!!!! Doesnt run !!!!!!!
SELECT Courses.CourseName, CourseOffers.Year, CourseOffers.Quartile
FROM (SELECT Courses.CourseId, Courses.CourseName, CourseOffers.Year, CourseOffers.Quartile FROM Courses INNER JOIN CourseOffers on (Courses.CourseId = CourseOffers.CourseId) INNER JOIN CourseRegistrations on (CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId) INNER JOIN StudentAssistants on (CourseOffers.CourseOfferId = StudentAssistants.CourseOfferId)
GROUP BY Courses.CourseId, CourseOffers.Year, CourseOffers.Quartile
HAVING COUNT(CourseRegistrations.CourseOfferId) / 50 < COUNT(StudentAssistants.CourseOfferId)) as s;
-- Runs but kinda slow
SELECT CourseName, Year, Quartile
FROM (SELECT Courses.CourseId, Courses.CourseName, CourseOffers.Year, CourseOffers.Quartile FROM Courses INNER JOIN CourseOffers on (Courses.CourseId = CourseOffers.CourseId) INNER JOIN CourseRegistrations on (CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId) INNER JOIN StudentAssistants on (CourseOffers.CourseOfferId = StudentAssistants.CourseOfferId)
GROUP BY Courses.CourseId, CourseOffers.Year, CourseOffers.Quartile
HAVING COUNT(CourseRegistrations.CourseOfferId) /50 +1 > COUNT(StudentAssistants.CourseOfferId)) as s;
-- marko met zn reee
with reee(courseofferid, year, quartile, courseid, cnt) as (SELECT courseofferid, avg(year), avg(quartile), avg(courseid), count(studentregistrationid) FROM courseofferregistrations GROUP BY courseofferid), reee2(courseofferid, cnt2) as (SELECT courseofferid, count(studentregistrationid) FROM studentassistants GROUP BY courseofferid) 

SELECT coursename,q year, quartile FROM reee r INNER JOIN reee2 r2 ON(r.courseofferid = r2.courseofferid) INNER JOIN courses c ON (r.courseid = c.courseid)  WHERE cnt / 50 + 1 > cnt2;
-- QUERY 6
--SELECT DISTINCT StudentId, count(StudentId) FROM HighestGradeCourseOffers WHERE Year = 2018 AND Quartile = 1 GROUP BY StudentId HAVING count(studentid) >= 1;
-- QUERY 7
--SELECT degreeid, birthyearstudent, gender, avg(gpa) FROM Students LEFT JOIN ActiveStudentsPerDegree ON ActiveStudentsPerDegree.StudentId = Students.StudentId LEFT JOIN GPA ON GPA.StudentRegistrationId = ActiveStudentsPerDegree.StudentRegistrationId GROUP BY cube(degreeid, birthyearstudent, gender);
-- QUERY 8
--SELECT CourseName, Year, Quartile FROM NumAssistantsCourseOffer LEFT JOIN NumStudentsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = NumStudentsCourseOffer.CourseOfferId AND NumStudents/NumAssistants>50 LEFT JOIN CourseOffers ON NumStudentsCourseOffer.CourseOfferId = CourseOffers.CourseOfferId LEFT JOIN Courses ON Courses.CourseId = CourseOffers.CourseOfferId ORDER BY CourseOffers.CourseOfferId;
