-- ATTENTION: Remove the comments and the example before submitting
-- This file should contain exactly 8 lines, without any comment. Each line will correspond to one of the 8 sub-questions of question 2.
-- Do not break long queries to more than one line, and do not leave empty lines between them. 
-- If you do not know the answer to one of the sub-questions, then write SELECT 0;
-- Example: Let's say I only know sub-question 3:
with PassedCourses(CourseName, Grade, Year, Quartile, CourseOfferId) as (SELECT CourseName, Grade, Year, Quartile, co.CourseOfferId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE c.CourseId = co.CourseId and co.CourseOfferId = cr.CourseOfferID and grade >= 5 and DegreeId = %2% and StudentRegistrationId in (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE StudentId = %1%) ORDER BY year, quartile, CourseOfferId) SELECT CourseName, grade FROM PassedCourses;
SELECT 0;
with activestudents(StudentregistrationId) as (SELECT StudentregistrationId FROM Degrees d INNER JOIN  Courses c ON (d.degreeid= c.degreeid) INNER JOIN Courseoffers co ON ( c.courseID = co.courseId) INNER JOIN Courseregistrations cr ON (co.Courseofferid = cr.courseofferid) GROUP BY StudentregistrationId HAVING max(totalECTS) < sum(ECTS)) SELECT degreeId, 100*count(case when gender = 'F' then 1.0 end)/count(*) FROM activestudents a INNER JOIN StudentregistrationsToDegrees srd ON (a.Studentregistrationid = srd.studentregistrationid) INNER JOIN Students s ON (srd.StudentId = s.StudentId) GROUP BY degreeId;
with GenPerDept(amount, gen) as (SELECT count(Gender), Gender FROM Students s, StudentRegistrationsToDegrees srd, degrees d WHERE Dept = %1% and d.DegreeId = srd.DegreeId and s.StudentId = srd.StudentId GROUP BY Gender) SELECT 100*amount(SELECT sum(amount) FROM GenPerDept) FROM GenPerDept WHERE Gen = 'F'; 
with AmountPassed(amount, courseid) as (SELECT count(Grade), c.CourseId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE Grade >= %1% and c.courseid = co.courseid and co.courseofferid = cr.courseofferid GROUP BY c.CourseID), AmountFailed(amount, courseid) as (SELECT count(Grade), c.CourseId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE Grade < %1% and c.courseid = co.courseid and co.courseofferid = cr.courseofferid GROUP BY c.CourseID) SELECT ap.CourseId, 100*ap.amount/(af.amount + ap.amount) FROM AmountFailed af, AmountPassed ap WHERE ap.courseid = af.courseid ORDER BY ap.courseid;
SELECT 0;
SELECT 0;
SELECT 0;
