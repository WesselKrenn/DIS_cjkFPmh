\timing
-- takes roughly 20 seconds
CREATE INDEX idx_SRTD ON StudentRegistrationsToDegrees USING hash(StudentId);
-- dont remember (20 as well?)
CREATE MATERIALIZED VIEW MaxGrades AS SELECT CourseOfferId, MAX(Grade) AS MaxGrade FROM CourseOfferRegistrations WHERE Year = 2018 AND Quartile = 1 GROUP BY CourseOfferId;
-- takes nothing
CREATE VIEW PassedCourses AS (SELECT * FROM courseofferregistrations WHERE Grade >= 5);

-- takes about 2:20
CREATE MATERIALIZED VIEW PassedCoursesPerStudent(StudentId, CourseOfferId, Year, Quartile, Grade, ECTS, DegreeId, CourseName) AS (
    SELECT StudentId, CourseOfferId, Year, Quartile, Grade, ECTS, srd.DegreeId, coursename FROM PassedCourses pc INNER JOIN StudentRegistrationsToDegrees srd ON (srd.StudentRegistrationId = pc.StudentRegistrationID)
);
-- takes about 2:40
CREATE INDEX idx_sid ON PassedCoursesPerStudent USING hash(StudentId);

-- takes about 50 sec
    CREATE MATERIALIZED VIEW StudentGPA AS (
    SELECT StudentId, SUM(ECTS * Grade) / CAST (SUM(ECTS) AS DECIMAL) AS GPA FROM PassedCoursesPerStudent
    GROUP BY StudentId
);





