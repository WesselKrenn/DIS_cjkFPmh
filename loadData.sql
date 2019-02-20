-- this file should load all data in the previously-created tables
-- the data will be stored under /mnt/ramdisk/tables
-- for example, the Students file is under /mnt/ramdisk/tables/Students.table 
-- The files of the folder are as follows (mind the lower-case/upper-case): 
--   CourseOffers.table, CourseRegistrations.table, Courses.table, Degrees.table
--   StudentAssistants.table, StudentRegistrationsToDegrees.table, Students.table
--   TeacherAssignmentsToCourses.table, Teachers.table
-- Don't forget to analyze at the end. It can make a difference in query performance.
-- Example:

COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/home/student/Downloads/tables-500/Degrees.table' DELIMITER ',' CSV HEADER;
COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/home/student/Downloads/tables-500/Students.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/home/student/Downloads/tables-500/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/home/student/Downloads/tables-500/Teachers.table' DELIMITER ',' CSV HEADER;
COPY Courses(CourseId, CourseName, CourseDescription,DegreeId,ETCS) FROM '/home/student/Downloads/tables-500/Courses.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM '/home/student/Downloads/tables-500/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/home/student/Downloads/tables-500/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/home/student/Downloads/tables-500/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/home/student/Downloads/tables-500/CourseRegistrations.table' DELIMITER ',' CSV HEADER;

ALTER TABLE Students add primary key (StudentId);
ALTER TABLE Degrees add primary key (DegreeId);
ALTER TABLE Teachers add primary key (TeacherId);
ALTER TABLE Courses add primary key (CourseId);
ALTER TABLE CourseOffers add primary key (CourseOffers);
ALTER TABLE StudentRegistrationsToDegrees(StudentRegistrationId);



ANALYZE VERBOSE
