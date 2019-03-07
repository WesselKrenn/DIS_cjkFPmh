with CurrentStudent(StudentRegistrationId) as (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE degreeid = 1099 and studentid = 2) SELECT CourseName, Grade FROM CourseRegistrations cr INNER JOIN CurrentStudent srd ON (cr.StudentRegistrationId = srd.StudentRegistrationId) INNER JOIN CourseOffers co ON (co.courseofferid = cr.courseofferid) WHERE grade >=5 ORDER BY year, quartile, co.courseofferid;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
