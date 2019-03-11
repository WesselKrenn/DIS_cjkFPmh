CREATE INDEX idx_SRTD ON StudentRegistrationsToDegrees USING hash(StudentId);
CREATE MATERIALIZED VIEW MaxGradesQ1 AS SELECT co.CourseOfferId, MAX(Grade) AS MaxGrade FROM CourseRegistrations cr INNER JOIN CourseOffers co ON (cr.courseofferid = co.courseofferid) WHERE Year = 2018 AND Quartile = 1 GROUP BY co.CourseOfferId;
CREATE MATERIALIZED VIEW pointsPerStudent(StudentId, Studentregistrationid, sumECTS, GPA) as SELECT cr.studentid, cr.studentregistrationid, sum(ECTS), (cast(sum(cr.grade * c.ects) as float) /sum(c.ects)) FROM CourseRegistrations cr, courses c where cr.courseid = c.courseid and cr.grade >= 5 group by cr.studentid, cr.studentregistrationid;
CREATE UNIQUE INDEX idx_pointsperstudent on pointsperstudent(studentregistrationid);
CREATE MATERIALIZED VIEW gotdegree(studentid, sumECTS, GPA, studentregistrationid) as select pps.studentid, pps.sumECTS, pps.GPA, pps.studentregistrationid from pointsperstudent pps, studentregistrationstodegrees srtd, degrees d where pps.studentregistrationid = srtd.studentregistrationid AND srtd.degreeid = d.degreeid AND pps.sumECTS >= d.totalects;
CREATE INDEX idx_gotdegree on gotdegree(studentregistrationid);
CREATE MATERIALIZED VIEW gotdegreeNoFail(studentId, studentregistrationid, GPA) as select gd.studentid, gd.studentregistrationid, gd.GPA from gotdegree gd, courseregistrations cr where gd.studentregistrationid = cr.studentregistrationid Group by gd.studentregistrationid, gd.studentid, gd.GPA having min(cr.grade) >=5;
CREATE VIEW not_taken(studentregistrationid, sumECTS) AS (SELECT studentregistrationid, 0 FROM (SELECT studentregistrationid FROM studentregistrationstodegrees srtd EXCEPT SELECT studentregistrationid FROM pointsperstudent) AS new);
CREATE MATERIALIZED VIEW ActiveStudent(studentId, DegreeId) AS (Select srtd.studentid, d.degreeid From pointsperstudent pps, studentregistrationstodegrees srtd, degrees d where pps.studentregistrationid = srtd.studentregistrationid and d.degreeid = srtd.degreeid and d.totalects > pps.sumects UNION SELECT srtd.studentid, srtd.degreeid FROM studentregistrationstodegrees srtd, not_taken nt WHERE srtd.studentregistrationid = nt.studentregistrationid);
CREATE INDEX idx_activestud on ActiveStudent(studentId);
CREATE INDEX idx_studidpointsper on pointsperstudent(studentId);
