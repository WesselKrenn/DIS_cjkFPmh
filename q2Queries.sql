-- ATTENTION: Remove the comments and the example before submitting
-- This file should contain exactly 8 lines, without any comment. Each line will correspond to one of the 8 sub-questions of question 2.
-- Do not break long queries to more than one line, and do not leave empty lines between them. 
-- If you do not know the answer to one of the sub-questions, then write SELECT 0;
-- Example: Let's say I only know sub-question 3:
with PassedCourses(CourseName, Grade, Year, Quartile, CourseOfferId) as (SELECT CourseName, Grade, Year, Quartile, co.CourseOfferId FROM Courses c, CourseOffers co, CourseRegistrations cr WHERE c.CourseId = co.CourseId and co.CourseOfferId = cr.CourseOfferID and grade >= 5 and DegreeId = %2% and StudentRegistrationId in (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE StudentId = %1%) ORDER BY year, quartile, CourseOfferId) SELECT CourseName, grade FROM PassedCourses;
SELECT 0;
SELECT phonenumber from myphonebook where name=%1%; 
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
