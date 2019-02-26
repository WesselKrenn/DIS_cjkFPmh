-- this file should contain the code required to create the auxiliary structures, for query 2
-- this file will be given 10 minutes to run. Then it will be killed
-- The file will be invoked with timeout 10m psql -d uni -f q2Create.sql
-- Remember that the database (including the auxiliary structures) needs to be less than 11 GB.
-- This file will be executed with postgres -d uni -f q2Create.sql 
-- Example:
CREATE MATERIALIZED VIEW PersonCredits(StudentRegId, ECTS) AS (SELECT StudentRegistrationId, sum(ECTS) FROM CourseRegistrations cr, CourseOffers co, Courses c WHERE cr.CourseOfferId = co.CourseOfferId and co.CourseId = c.CourseId GROUP BY StudentRegistrationId); 
