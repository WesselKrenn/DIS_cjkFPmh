
COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY Courses(CourseId, CourseName, CourseDescription,DegreeId,ECTS) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY temp_CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY temp_CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER NULL 'null';
CREATE UNLOGGED TABLE CourseOffers AS SELECT co.*, CourseName FROM temp_CourseOffers co INNER JOIN Courses c ON (co.courseid = c.courseid);
DROP TABLE temp_CourseOffers;
CREATE UNLOGGED TABLE CourseRegistrations AS SELECT cr.*, srd.StudentId, CourseId FROM temp_CourseRegistrations cr, CourseOffers co, StudentRegistrationsToDegrees srd WHERE cr.CourseOfferId = co.CourseOfferId and cr.StudentRegistrationId = srd.StudentRegistrationId;
DROP TABLE temp_CourseRegistrations;
ALTER TABLE Students add primary key (StudentId);
ALTER TABLE Degrees add primary key (DegreeId);
ALTER TABLE Teachers add primary key (TeacherId);
ALTER TABLE Courses add primary key (CourseId);
ALTER TABLE StudentRegistrationsToDegrees add primary key (StudentRegistrationId);
ALTER TABLE CourseRegistrations add primary key (StudentRegistrationId, CourseOfferId);
ANALYZE VERBOSE
