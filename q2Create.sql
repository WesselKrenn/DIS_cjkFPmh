-- this file should contain the code required to create the auxiliary structures, for query 2
-- this file will be given 10 minutes to run. Then it will be killed
-- The file will be invoked with timeout 10m psql -d uni -f q2Create.sql
-- Remember that the database (including the auxiliary structures) needs to be less than 11 GB.
-- This file will be executed with postgres -d uni -f q2Create.sql 
-- Example:



-- From wesselkrenn (no number) and wesselkrenn2 :
\timing
CREATE INDEX idx_SRTD ON StudentRegistrationsToDegrees USING hash(StudentId);
CREATE MATERIALIZED VIEW MaxGrades AS SELECT CourseRegistrations.CourseOfferId, MAX(Grade) AS MaxGrade FROM CourseRegistrations INNER JOIN CourseOffers ON (CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId) WHERE Year = 2018 AND Quartile = 1 GROUP BY CourseRegistrations.CourseOfferId;

--CREATE MATERIALIZED VIEW GPAAndECTSCount AS SELECT StudentRegistrationsToDegrees.StudentRegistrationId, SUM(CourseRegistrations.Grade * Courses.ECTS) / CAST(SUM(Courses.ECTS) AS float) AS GPA, SUM(Courses.ECTS) AS TotalECTSAcquired FROM StudentRegistrationsToDegrees INNER JOIN CourseRegistrations on (StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId) INNER JOIN CourseOffers on (CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId) INNER JOIN Courses on (CourseOffers.COurseId = Courses.CourseId) INNER JOIN Degrees on (Courses.DegreeId = Degrees.DegreeId) WHERE (CourseRegistrations.Grade > 5.0) GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId;

CREATE VIEW PassedCourses AS (
  SELECT * FROM courseregistration WHERE Grade >= 5);

CREATE MATERIALIZED VIEW PassedCoursesPerStudent AS (
    SELECT StudentId, C.CourseId, Grade, ECTS FROM Courses c INNER JOIN CourseOffers co ON (c.courseid = co.courseid)
                                                             INNER JOIN PassedCourses pc ON (co.courseofferid = pc.courseofferid)
                                                             INNER JOIN StudentRegistrationsToDegrees srd ON (srd.StudentRegistrationId = cr.StudentRegistrationID)
    WHERE Grade >= 5
    
);


CREATE MATERIALIZED VIEW StudentGPA AS (
    SELECT StudentId, SUM(ECTS * Grade) / CAST (SUM(ECTS) AS DECIMAL) AS GPA FROM PassedCoursesPerStudent
    GROUP BY StudentId
);





