CREATE VIEW grades_Q1(studentid, courseofferid, grade) as (
	
SELECT studentid, co.courseofferid, Grade

FROM courseregisrations cr, CourseOffers co, studentregistrationstodegrees srd
	
WHERE Year = 2018 and quartile = 1
	
and cr.CourseOfferId = co.CourseOfferId
	
and srd.studentregistrationid = cr.studentregistrationid
);

CREATE VIEW highest_grades(coid, maxg) as (

SELECT courseofferid, max(Grade)

FROM grades_Q1

GROUP BY courseofferid
);

SELECT StudentId, count(CourseOfferId)
FROM grades_Q1
WHERE grade = (SELECT maxg WHERE coid = CourseOfferId)
GROUP BY StudentId
Having count(CourseOfferId) >= %1%;
      
