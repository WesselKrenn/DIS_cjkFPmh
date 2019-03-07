\timing

CREATE INDEX idx_SRTD ON StudentRegistrationsToDegrees USING hash(StudentId);
CREATE MATERIALIZED VIEW MaxGrades AS SELECT CourseOfferId, MAX(Grade) AS MaxGrade FROM CourseOfferRegistrations WHERE Year = 2018 AND Quartile = 1 GROUP BY CourseOfferId;

CREATE VIEW PassedCourses AS (SELECT * FROM courseofferregistrations WHERE Grade >= 5);


CREATE MATERIALIZED VIEW PassedCoursesPerStudent(StudentId, CourseOfferId, Year, Quartile, Grade, ECTS, DegreeId, CourseName) AS (
    SELECT StudentId, CourseOfferId, Year, Quartile, Grade, ECTS, srd.DegreeId, coursename FROM PassedCourses pc INNER JOIN StudentRegistrationsToDegrees srd ON (srd.StudentRegistrationId = pc.StudentRegistrationID)
);

CREATE INDEX idx_sid ON PassedCoursesPerStudent USING hash(StudentId);

CREATE MATERIALIZED VIEW StudentGPA AS (
    SELECT StudentId, SUM(ECTS * Grade) / CAST (SUM(ECTS) AS DECIMAL) AS GPA FROM PassedCoursesPerStudent
    GROUP BY StudentId
);





