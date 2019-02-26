-- ATTENTION: Remove the comments and the example before submitting
-- This file should contain exactly 8 lines, without any comment. Each line will correspond to one of the 8 sub-questions of question 2.
-- Do not break long queries to more than one line, and do not leave empty lines between them. 
-- If you do not know the answer to one of the sub-questions, then write SELECT 0;
-- Example: Let's say I only know sub-question 3:
with PassedCourses(CourseName, Grade, Year, Quartile, CourseOfferId) as (SELECT CourseName, Grade, Year, Quartile, co.CourseOfferId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE c.CourseId = co.CourseId and co.CourseOfferId = cr.CourseOfferID and grade >= 5 and DegreeId = %2% and StudentRegistrationId in (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE StudentId = %1%) ORDER BY year, quartile, CourseOfferId) SELECT CourseName, grade FROM PassedCourses;
SELECT 0;
SELECT 0;
with GenPerDept(amount, gen) as (SELECT count(Gender), Gender FROM Students s, StudentRegistrationsToDegrees srd, degrees d WHERE Dept = %1% and d.DegreeId = srd.DegreeId and s.StudentId = srd.StudentId GROUP BY Gender) SELECT 100*amount(SELECT sum(amount) FROM GenPerDept) FROM GenPerDept WHERE Gen = 'F'; 
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
