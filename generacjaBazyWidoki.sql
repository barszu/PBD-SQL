-- views
-- View: financial_raport_webinars
CREATE VIEW financial_raport_webinars
AS
SELECT webinarID , SUM(price) AS total
FROM WebinarsShoppingItemHistory
GROUP BY webinarID;
GO

-- View: financial_raport_courses
CREATE VIEW financial_raport_courses
AS
SELECT courseID , SUM(price) AS total
FROM CoursesShoppingItemHistory
GROUP BY courseID;
GO

-- View: financial_raport_studies
CREATE VIEW financial_raport_studies
AS
SELECT fieldOfStudiesID , SUM(t) AS total
FROM (
    SELECT fieldOfStudiesID , SUM(price) AS t
    FROM StudiesShoppingItemForStudiesUserHistory
    GROUP BY fieldOfStudiesID

    UNION

    SELECT fieldOfStudiesID , SUM(price) AS t
    FROM StudiesShoppingItemForOutsidersHistory
    GROUP BY fieldOfStudiesID
     ) AS subquery
GROUP BY fieldOfStudiesID;
GO

-- View: attendance_list_raport
CREATE VIEW attendance_list_raport
AS
SELECT
    cm.courseID,
    ch.date,
    u.firstname,
    u.lastname,
    CASE
        WHEN cm.wasPresent = 1 THEN 'obecny'
        ELSE 'nieobecny'
    END AS wasPresent
    FROM CourseModulePresence cm
    JOIN CourseUsers cu ON cm.courseUserID = cu.courseUserID
    JOIN Users u ON cu.courseUserID = u.userID
    JOIN CourseToUserAssignment cta ON cu.courseUserID = cta.courseUserID
    JOIN Courses ch on cm.courseID = CH.courseID;
GO

-- View: bilocation_raport
CREATE VIEW bilocation_raport
AS
SELECT DISTINCT
    u.userID,
    u.firstname,
    u.lastname
    FROM
        Users u
    JOIN CourseUsers cu ON u.userID = cu.courseUserID
    WHERE cu.courseUserID IN (
            SELECT cu.courseUserID
                FROM CourseUsers cu
            JOIN CourseToUserAssignment cta ON cu.courseUserID = cta.courseUserID
            JOIN Courses c ON cta.courseID = c.courseID
            JOIN CourseModules cm ON c.courseID = cm.courseID
            GROUP BY cu.courseUserID, cm.date
            HAVING COUNT(DISTINCT c.courseID) >= 2
        );
GO

-- View: webinars_to_pay_list
CREATE VIEW webinars_to_pay_list
AS
SELECT DISTINCT WebinarsToUserAssignment.webinarUserID, firstname, lastname, toPay
FROM WebinarsToUserAssignment JOIN Users ON Users.webinarUserID=WebinarsToUserAssignment.webinarUserID
WHERE toPay > 0;
GO

-- View: course_to_pay_list
CREATE VIEW course_to_pay_list
AS
SELECT DISTINCT CourseToUserAssignment.CourseUserID, firstname, lastname, toPay
FROM CourseToUserAssignment JOIN Users ON Users.webinarUserID=CourseToUserAssignment.CourseUserID
WHERE toPay > 0;
GO

-- View: future_webinar_attendees_list
CREATE VIEW future_webinar_attendees_list
AS
SELECT Webinars.webinarID, count(webinarUserID) as enrolled, 'zdalnie' as attendanceType
FROM Webinars JOIN WebinarsToUserAssignment ON Webinars.webinarID=WebinarsToUserAssignment.webinarID
GROUP BY Webinars.webinarID;
GO

-- View: future_course_attendees_list
CREATE VIEW future_course_attendees_list
AS
SELECT moduleID, CourseModules.courseID, currEnrolls, attendanceType
FROM CourseModules JOIN Courses ON Courses.courseID = CourseModules.courseID;
GO

-- View: future_lesson_attendee_list
CREATE VIEW future_lesson_attendee_list
AS
SELECT lessonID, currEnrolls, attendanceType
FROM Lessons;
GO

-- View: webinar_attendance_raport
CREATE VIEW webinar_attendance_raport
AS
SELECT Webinars.webinarID , SUM(haveParticipated)/COUNT(Webinars.webinarID) AS presence
FROM WebinarsToUserAssignment
RIGHT JOIN Webinars ON Webinars.webinarID = WebinarsToUserAssignment.webinarID
GROUP BY Webinars.webinarID;
GO

-- View: course_attendance_raport
CREATE VIEW course_attendance_raport
AS
SELECT CourseModules.moduleID , SUM(wasPresent)/COUNT(CourseModulePresence.moduleID) AS presence
    FROM CourseModulePresence
    RIGHT JOIN CourseModules ON CourseModules.moduleID = CourseModulePresence.moduleID
        AND CourseModules.hasTookPlace = 1
    GROUP BY CourseModules.moduleID;
GO

-- View: studies_attendance_raport
CREATE VIEW studies_attendance_raport
AS
SELECT lessonID , SUM(s)/SUM(p) as attendance FROM (
        SELECT StudiesUserAttendance.lessonID , SUM(wasPresent) AS s , COUNT(StudiesUserAttendance.lessonID) AS p
        FROM StudiesUserAttendance
        RIGHT JOIN Lessons ON Lessons.lessonID = StudiesUserAttendance.lessonID
            AND Lessons.tookPlace = 1
        GROUP BY StudiesUserAttendance.lessonID
        UNION
        SELECT OutsidersAttendance.lessonID , SUM(wasPresent) AS s , COUNT(OutsidersAttendance.lessonID) AS p
        FROM OutsidersAttendance
        RIGHT JOIN Lessons ON Lessons.lessonID = OutsidersAttendance.lessonID
            AND Lessons.tookPlace = 1
         GROUP BY OutsidersAttendance.lessonID
                  ) AS subquery
    GROUP BY lessonID;
GO
