SELECT cr.CourseOfferId, c.CourseId, Year, Quartile, c.CourseName, CourseDescription, d.DegreeId, ECTS, Dept, DegreeDescription, TotalECTS, t.TeacherId, TeacherName, Address, BirthyearTeacher, Gender FROM courseregistrations cr, courseoffers co, courses c, degrees d, teachers t, teacherassignmentstocourses tatc WHERE cr.courseofferid = 1 and cr.courseid = c.courseid and co.courseofferid = cr.courseofferid and d.degreeid = c.degreeid and t.teacherid = tatc.teacherid and tatc.courseofferid = cr.courseofferid LIMIT 1;
SELECT cr.courseofferid, cr.courseid, year, Quartile, s.studentid, studentname, address, birthyearstudent, gender, d.degreeid, dept, DegreeDescription, TotalECTS FROM studentregistrationstodegrees srd, studentassistants sa, courseregistrations cr, students s, degrees d, courseoffers co WHERE sa.studentregistrationid = 3 and sa.courseofferid = cr.courseofferid and s.studentID = srd.studentid and d.degreeid = srd.degreeid and srd.studentregistrationid = sa.studentregistrationid and cr.courseofferid = co.courseofferid LIMIT 1; 
SELECT avg(Grade) FROM CourseRegistrations WHERE StudentRegistrationId = 3;
