CREATE INDEX idx_SRTD ON StudentRegistrationsToDegrees USING hash(StudentId);
CREATE MATERIALIZED VIEW MaxGradesQ1 AS SELECT co.CourseOfferId, MAX(Grade) AS MaxGrade FROM CourseRegistrations cr INNER JOIN CourseOffers co ON (cr.courseofferid = co.courseofferid) WHERE Year = 2018 AND Quartile = 1 GROUP BY co.CourseOfferId;
