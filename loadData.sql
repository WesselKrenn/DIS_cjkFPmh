
COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY Courses(CourseId, CourseName, CourseDescription,DegreeId,ECTS) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER NULL 'null';
CREATE UNLOGGED TABLE CourseOffers2 AS SELECT co.CourseOfferId, co.CourseId, Year, Quartile, CourseName, ECTS FROM CourseOffers co INNER JOIN Courses c ON (co.courseid = c.courseid);
DROP TABLE CourseOffers;
CREATE UNLOGGED TABLE CourseOfferRegistrations AS SELECT CourseRegistrations.CourseOfferId, CourseRegistrations.StudentRegistrationId, CourseRegistrations.Grade, CourseOffers2.CourseId, CourseOffers2.Year, Courseoffers2.Quartile, CourseOffers2.CourseName, ECTS FROM CourseRegistrations, CourseOffers2 WHERE CourseRegistrations.CourseOfferId = CourseOffers2.CourseOfferId;
DROP TABLE CourseRegistrations;
DROP TABLE CourseOffers2;
ALTER TABLE Students add primary key (StudentId);
ALTER TABLE Degrees add primary key (DegreeId);
ALTER TABLE Teachers add primary key (TeacherId);
ALTER TABLE Courses add primary key (CourseId);
ALTER TABLE StudentRegistrationsToDegrees add primary key (StudentRegistrationId);
ALTER TABLE CourseOfferRegistrations add primary key (StudentRegistrationId, CourseOfferId);
ANALYZE VERBOSE
