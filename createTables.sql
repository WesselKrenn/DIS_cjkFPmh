-- This file should create the tables
-- An example follows, replace it with your own commands.
-- SQL files can be executed from command-line using psql -d THE_DATABASE_NAME -f THE_FILENAME
-- Notice the UNLOGGED option, which drastically increases performance and reduces space usage

CREATE UNLOGGED TABLE Degrees(DegreeId int, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int, PRIMARY KEY (DegreeId));
CREATE UNLOGGED TABLE Students(StudentId int, StudentName varchar(50), Address varchar(200),BirthyearStudent int, Gender char, PRIMARY KEY (StudentId));
CREATE UNLOGGED TABLE StudentRegistrationsToDegrees(StudentRegistrationId int, StudentId int, DegreeId int, RegistrationYear int, PRIMARY KEY (StudentRegistrationId));
CREATE UNLOGGED TABLE Teachers(TeacherId int, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char, PRIMARY KEY(TeacherId));
CREATE UNLOGGED TABLE Courses(CourseId int, CourseName varchar(50), CourseDescription varchar(200),DegreeId int, ETCS int, PRIMARY KEY (CourseId));
CREATE UNLOGGED TABLE CourseOffers(CourseOfferId int, CourseId int, Year int, Quartile int, PRIMARY KEY (CourseOfferId));
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses(CourseOfferId int, TeacherId int, FOREIGN KEY (CourseOfferId) REFERENCES CourseOffers(CourseOfferId), FOREIGN KEY (TeacherId) REFERENCES Teachers(TeacherId));
CREATE UNLOGGED TABLE StudentAssistants(CourseOfferId int, StudentRegistrationId int, FOREIGN KEY (CourseOfferId) REFERENCES CourseOffers(CourseOfferId), FOREIGN KEY (StudentRegistrationId) REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId));
CREATE UNLOGGED TABLE CourseRegistrations(CourseOfferId int, StudentRegistrationId int, Grade varchar(4), FOREIGN KEY (CourseOfferId) REFERENCES CourseOffers(CourseOfferId), FOREIGN KEY (StudentRegistrationId) REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId));
