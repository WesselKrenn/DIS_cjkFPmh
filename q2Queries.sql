with CurrentStudent(StudentRegistrationId) as (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE degreeid = %2% and studentid = %1%) SELECT CourseName, grade FROM CourseRegistrations cr INNER JOIN CurrentStudent srd ON (cr.StudentRegistrationId = srd.StudentRegistrationId) INNER JOIN CourseOffers co ON (co.courseofferid = cr.courseofferid) WHERE grade >=5 ORDER BY year, quartile, co.courseofferid;
SELECT 0;
SELECT 0;
SELECT count(CASE WHEN S.Gender = 'F'  THEN 1 END)/count(SR.StudentId)::float as percentageFemale FROM Degrees D, StudentRegistrationsToDegrees SR, Students S WHERE SR.DegreeId = D.DegreeId and S.StudentId = SR.StudentId and D.Dept = %1%;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
