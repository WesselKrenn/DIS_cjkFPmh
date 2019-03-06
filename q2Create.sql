-- this file should contain the code required to create the auxiliary structures, for query 2
-- this file will be given 10 minutes to run. Then it will be killed
-- The file will be invoked with timeout 10m psql -d uni -f q2Create.sql
-- Remember that the database (including the auxiliary structures) needs to be less than 11 GB.
-- This file will be executed with postgres -d uni -f q2Create.sql 
-- Example:
CREATE MATERIALIZED VIEW PersonCredits(StudentRegId, ECTS) AS (SELECT StudentRegistrationId, sum(ECTS) FROM CourseRegistrations cr, CourseOffers co, Courses c WHERE cr.CourseOfferId = co.CourseOfferId and co.CourseId = c.CourseId GROUP BY StudentRegistrationId); 



-- From wesselkrenn (no number) :

CREATE INDEX idx_SRTD ON StudentRegistrationsToDegrees USING hash(StudentId);

CREATE MATERIALIZED VIEW MaxGrades AS SELECT CourseRegistrations.CourseOfferId, MAX(Grade) AS MaxGrade FROM CourseRegistrations JOIN CourseOffers ON (CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId) WHERE Year = 2018 AND Quartile = 1 GROUP BY CourseRegistrations.CourseOfferId;


CREATE MATERIALIZED VIEW GPAAndECTSCount AS SELECT StudentRegistrationsToDegrees.StudentRegistrationId, SUM(CourseRegistrations.Grade * Courses.ECTS) / CAST(SUM(Courses.ECTS) AS float) AS GPA, SUM(Courses.ECTS) AS TotalECTSAcquired FROM StudentRegistrationsToDegrees INNER JOIN CourseRegistrations on (StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId) INNER JOIN CourseOffers on (CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId) INNER JOIN Courses on (CourseOffers.COurseId = Courses.CourseId) INNER JOIN Degrees on (Courses.DegreeId = Degrees.DegreeId) WHERE (CourseRegistrations.Grade > 5.0) GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId;


CREATE MATERIALIZED VIEW ActiveStudents AS 
SELECT GPAandECTSCount.StudentRegistrationId, StudentRegistrationsToDegrees.StudentId, Students.Gender, StudentRegistrationsToDegrees.DegreeId
FROM GPAAndECTSCount INNER JOIN StudentRegistrationsToDegrees on (GPAAndECTSCount.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId) INNER JOIN Students on (StudentRegistrationsToDegrees.StudentId = Students.StudentId) INNER JOIN Degrees on (StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId)
WHERE GPAAndECTSCount.TotalECTSAcquired < Degrees.TotalECTS;


