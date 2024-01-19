-- AccessTimeLaws
CREATE PROCEDURE AddAccessTimeLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @noDays INT
AS
BEGIN
   UPDATE AccessTimeLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;


   INSERT INTO AccessTimeLaws (startDate, endDate, description, isTheRecent, no_days)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @noDays);
END;
go

-- Procedura Dodawania Nowej Sesji Administratora
CREATE PROCEDURE AddAdminSession(
   @adminID int
)
AS
BEGIN
   DECLARE @startedDate datetime = GETDATE();


   INSERT INTO AdminSessionHistory (adminID, startedDate)
   VALUES (@adminID, @startedDate);


   PRINT 'Nowa sesja została pomyślnie utworzona.';
END;
go

-- Procedura dodajaca administratora
CREATE PROCEDURE AddAdministrator(
   @adminID int,
   @accessLvl int,
   @firstname text,
   @lastname text,
   @title text,
   @email text,
   @phone text,
   @encodedPassword text,
   @address text,
   @postalcode text
)
AS
BEGIN
   INSERT INTO Administrators (adminID, accessLvl, firstname, lastname, title, email, phone, encodedPassword, address, postalcode)
   VALUES (@adminID, @accessLvl, @firstname, @lastname, @title, @email, @phone, @encodedPassword, @address, @postalcode);
END;
go

--Procedura dodająca kurs
CREATE PROCEDURE AddCourse(
  @courseID int,
  @courseTeacherID int,
  @date datetime,
  @price money,
  @maxEnrolls int,
  @currEnrolls int,
  @description text
)
AS
BEGIN
  INSERT INTO Courses (courseID, courseTeacherID, date, price, maxEnrolls, currEnrolls, description)
  VALUES (@courseID, @courseTeacherID, @date, @price, @maxEnrolls, @currEnrolls, @description);

  PRINT 'New course has been successfully added.';
END;
go

--Procedura dodająca moduł kursu
CREATE PROCEDURE AddCourseModule(
  @moduleID int,
  @courseID int,
  @courseWebinarID int,
  @translatorID int,
  @attendanceType varchar(max),
  @name varchar(max),
  @type varchar(max),
  @classroom varchar(max),
  @linkToRecord varchar(max),
  @description varchar(max)
)
AS
BEGIN
  INSERT INTO CourseModules (moduleID, courseID, courseWebinarID, translatorID, attendanceType, name, type, classroom, linkToRecord, description)
  VALUES (@moduleID, @courseID, @courseWebinarID, @translatorID, @attendanceType, @name, @type, @classroom, @linkToRecord, @description);

  PRINT 'New course module has been successfully added.';
END;
go

-- Procedura Dodawania Roli CourseTeacher
CREATE PROCEDURE AddCourseTeacherRole(
   @userID int
)
AS
BEGIN
   DECLARE @courseTeacherID int;
   DECLARE @description varchar(max) = 'Course Teacher';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Course Teacher
   INSERT INTO CourseTeacher (description, email)
   VALUES (@description, @email);


   SET @courseTeacherID = SCOPE_IDENTITY();


   -- Zaktualizuj pole courseTeacherID w tabeli Users
   UPDATE Users
   SET courseTeacherID = @courseTeacherID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO CourseTeacherDataChangeHistory
   VALUES (
       @courseTeacherID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT 'Nowy Course Teacher został pomyślnie dodany.';
END;
go

-- Procedura Dodawania Roli CourseUsers
CREATE PROCEDURE AddCourseUsersRole(
   @userID int
)
AS
BEGIN
   DECLARE @courseUserID int;
   DECLARE @description varchar(max) = 'Course User';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Course User
   INSERT INTO CourseUsers (description, email)
   VALUES (@description, @email);


   SET @courseUserID = SCOPE_IDENTITY();


   -- Zaktualizuj pole courseUserID w tabeli Users
   UPDATE Users
   SET courseUserID = @courseUserID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO CourseUsersDataChangeHistory
   VALUES (
       @courseUserID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT 'Nowy Course User został pomyślnie dodany.';
END;
go

-- DaysOfPracticeLaws
CREATE PROCEDURE AddDaysOfPracticeLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @noDays INT
AS
BEGIN
   UPDATE DaysOfPracticeLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;


   INSERT INTO DaysOfPracticeLaws (startDate, endDate, description, isTheRecent, no_days)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @noDays);
END;
go

--Procedura dodająca kierunek studiów
           CREATE PROCEDURE AddFieldOfStudies
   @fieldOfStudiesID int,
   @name text,
   @description text
AS
BEGIN
   INSERT INTO FieldOfStudies (fieldOfStudiesID, name, description)
   VALUES (@fieldOfStudiesID, @name, @description);
END;
go

-- MaxDaysForPayementBeforeCourseLaws
CREATE PROCEDURE AddMaxDaysForPayementBeforeCourseLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @noDays INT
AS
BEGIN
   UPDATE MaxDaysForPayementBeforeCourseLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;


   INSERT INTO MaxDaysForPayementBeforeCourseLaws (startDate, endDate, description, isTheRecent, no_days)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @noDays);
END;
go

-- MaxDaysForPayementBeforeStudiesLaws
CREATE PROCEDURE AddMaxDaysForPayementBeforeStudiesLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @noDays INT
AS
BEGIN
   UPDATE MaxDaysForPayementBeforeStudiesLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;


   INSERT INTO MaxDaysForPayementBeforeStudiesLaws (startDate, endDate, description, isTheRecent, no_days)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @noDays);
END;
go

-- MinAttendanceToPassCourseLaws
CREATE PROCEDURE AddMinAttendanceToPassCourseLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @minAttendance INT
 AS
 BEGIN
   UPDATE MinAttendanceToPassCourseLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;




   INSERT INTO MinAttendanceToPassCourseLaws (startDate, endDate, description, isTheRecent, min_attendance)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @minAttendance);
 END;
go

-- MinAttendanceToPassPracticeLaws
CREATE PROCEDURE AddMinAttendanceToPassPracticeLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @minAttendance INT
 AS
 BEGIN
   UPDATE MinAttendanceToPassPracticeLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;




   INSERT INTO MinAttendanceToPassPracticeLaws (startDate, endDate, description, isTheRecent, min_attendance)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @minAttendance);
 END;
go

CREATE PROCEDURE AddMinAttendanceToPassStudiesLaw
   @startDate DATETIME,
   @endDate DATETIME = NULL,
   @description TEXT,
   @isTheRecent INT = 1,
   @minAttendance INT
 AS
 BEGIN
   UPDATE MinAttendanceToPassStudiesLaws
   SET isTheRecent = 0, endDate = @startDate
   WHERE isTheRecent = 1;




   INSERT INTO MinAttendanceToPassStudiesLaws (startDate, endDate, description, isTheRecent, min_attendance)
   VALUES (@startDate, @endDate, @description, @isTheRecent, @minAttendance);
 END;
go

-- Procedura dodająca obecność
   CREATE PROCEDURE AddOutsiderAttendance
  @lessonID int,
  @outsiderID int,
  @wasPresent int,
  @studiesSubjectID int
AS
BEGIN
  INSERT INTO OutsidersAttendance (lessonID, outsiderID, wasPresent, studiesSubjectID)
  VALUES (@lessonID, @outsiderID, @wasPresent, @studiesSubjectID);

  PRINT 'New attendance record has been successfully added.';
END;
go

-- Procedura Dodawania Roli Outsider
CREATE PROCEDURE AddOutsiderRole(
   @userID int
)
AS
BEGIN
   DECLARE @outsiderID int;
   DECLARE @description varchar(max) = 'Outsider';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Outsider
   INSERT INTO Outsiders (description, email)
   VALUES (@description, @email);


   SET @outsiderID = SCOPE_IDENTITY();


   -- Zaktualizuj pole outsiderID w tabeli Users
   UPDATE Users
   SET studiesOutsiderID = @outsiderID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO OutsidersDataChangeHistory
   VALUES (
       @outsiderID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT N'Nowy Outsider został pomyślnie dodany.';
END;
go

-- Procedura dodająca przedmiot studiów
   CREATE PROCEDURE AddStudiesSubject
   @studiesSubjectID int,
   @fieldOfStudiesID int,
   @mainCoordinatorID int,
   @name text,
   @semester int,
   @description text,
   @price money,
   @maxEnrolls int,
   @currEnrolls int
AS
BEGIN
   INSERT INTO StudiesSubject (studiesSubjectID, fieldOfStudiesID, mainCoordinatorID, name, semester, description, price, maxEnrolls, currEnrolls)
   VALUES (@studiesSubjectID, @fieldOfStudiesID, @mainCoordinatorID, @name, @semester, @description, @price, @maxEnrolls, @currEnrolls);
END;
go

-- Procedura Dodawania Roli StudiesTeacher
CREATE PROCEDURE AddStudiesTeacherRole(
   @userID int
)
AS
BEGIN
   DECLARE @studiesTeacherID int;
   DECLARE @description varchar(max) = 'Studies Teacher';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Studies Teacher
   INSERT INTO StudiesTeacher (description, email)
   VALUES (@description, @email);


   SET @studiesTeacherID = SCOPE_IDENTITY();


   -- Zaktualizuj pole studiesTeacherID w tabeli Users
   UPDATE Users
   SET studiesTeacherID = @studiesTeacherID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO StudiesTeacherDataChangeHistory
   VALUES (
       @studiesTeacherID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT N'Nowy Studies Teacher został pomyślnie dodany.';
END;
go

-- Procedura dodająca obecność
CREATE PROCEDURE AddStudiesUserAttendance
  @lessonID int,
  @studiesUserID int,
  @wasPresent int,
  @grade int = NULL,
  @studiesSubjectID int
AS
BEGIN
  INSERT INTO StudiesUserAttendance (lessonID, studiesUserID, wasPresent, grade, studiesSubjectID)
  VALUES (@lessonID, @studiesUserID, @wasPresent, @grade, @studiesSubjectID);

  PRINT 'New attendance record has been successfully added.';
END;
go

-- Procedura Dodawania Roli StudiesUser
CREATE PROCEDURE AddStudiesUserRole(
   @userID int,
   @semester int,
   @isActive int,
   @index int
)
AS
BEGIN
   DECLARE @studiesUserID int;
   DECLARE @description varchar(max) = 'Studies User';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Studies User
   INSERT INTO StudiesUser (description, semester, isActive, "index", email)
   VALUES (@description, @semester, @isActive, @index, @email);


   SET @studiesUserID = SCOPE_IDENTITY();


   -- Zaktualizuj pole studiesUserID w tabeli Users
   UPDATE Users
   SET studiesUserID = @studiesUserID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO StudiesUserDataChangeHistory
   VALUES (
       @studiesUserID, @dateOfChange,
       '', 0, 0, 0, '', -- Brak starych wartości
       @description, @semester, @isActive, @index, @email
   );


   PRINT N'Nowy Studies User został pomyślnie dodany.';
END;
go

-- Procedura Dodawania Nowego Tłumacza (dodanie roli)
CREATE PROCEDURE AddTranslatorRole(
   @userID int
)
AS
BEGIN
   DECLARE @translatorID int;
   DECLARE @email varchar(max);
   DECLARE @description varchar(max) = 'I am a translator';
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego tłumacza
   INSERT INTO Translators (email, description)
   VALUES (@email, @description);


   SET @translatorID = SCOPE_IDENTITY();


   -- Zaktualizuj pole translatorID w tabeli Users
   UPDATE Users
   SET translatorID = @translatorID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO TranslatorsDataChangeHistory
   VALUES (
       @translatorID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT 'Nowy tłumacz został pomyślnie dodany.';
END;
go

-- Procedura Dodawania Nowego Użytkownika (nie ma usuwania)
CREATE PROCEDURE AddUser(
   @firstname varchar(max),
   @lastname varchar(max),
   @email varchar(max),
   @phone varchar(max),
   @encodedPassword varchar(max),
   @address varchar(max),
   @postalcode varchar(max),
   @title varchar(max) = NULL
)
AS
BEGIN
   DECLARE @userID int;
   DECLARE @dateOfCreation datetime = GETDATE();


   -- Dodaj nowego użytkownika
   INSERT INTO Users (firstname, lastname, title, email, phone, encodedPassword, address, postalcode)
   VALUES (@firstname, @lastname, @title, @email, @phone, @encodedPassword, @address, @postalcode);


   SET @userID = SCOPE_IDENTITY();


   -- Aktualizuj pola roli na NULL
   UPDATE Users
   SET
       translatorID = NULL,
       webinarUserID = NULL,
       webinarTeacherID = NULL,
       courseUserID = NULL,
       courseTeacherID = NULL,
       studiesUserID = NULL,
       studiesTeacherID = NULL,
       studiesOutsiderID = NULL
   WHERE userID = @userID;


   PRINT 'Nowy użytkownik został pomyślnie dodany.';
END;
go

-- Procedura Dodawania Nowej Sesji Użytkownika
CREATE PROCEDURE AddUserSession(
   @userID int
)
AS
BEGIN
   DECLARE @startedDate datetime = GETDATE();


   INSERT INTO UserSessionHistory (userID, startedDate)
   VALUES (@userID, @startedDate);


   PRINT 'Nowa sesja została pomyślnie utworzona dla userID: ' + CAST(@userID AS varchar(10));
END;
go

--Procedura dodająca webinar
   CREATE PROCEDURE AddWebinar(
  @webinarTeacherID int,
  @translatorID int,
  @date datetime,
  @price money,
  @linkToMeet text,
  @description text
)
AS
BEGIN
  INSERT INTO Webinars (webinarTeacherID, translatorID, date, price, linkToMeet, description)
  VALUES (@webinarTeacherID, @translatorID, @date, @price, @linkToMeet, @description);

  PRINT 'New webinar has been successfully added.';
END;
go

-- Procedura Dodawania Roli WebinarTeacher (po userID)
CREATE PROCEDURE AddWebinarTeacherRole(
   @userID int
)
AS
BEGIN
   DECLARE @webinarTeacherID int;
   DECLARE @description varchar(max) = 'Webinar Teacher';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Webinar Teacher
   INSERT INTO WebinarTeacher (description, email)
   VALUES (@description, @email);


   SET @webinarTeacherID = SCOPE_IDENTITY();


   -- Zaktualizuj pole webinarTeacherID w tabeli Users
   UPDATE Users
   SET webinarTeacherID = @webinarTeacherID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO WebinarTeacherDataChangeHistory
   VALUES (
       @webinarTeacherID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT 'Nowy Webinar Teacher został pomyślnie dodany.';
END;
go

-- Procedura Dodawania Roli WebinarUsers
CREATE PROCEDURE AddWebinarUsersRole(
   @userID int
)
AS
BEGIN
   DECLARE @webinarUserID int;
   DECLARE @description varchar(max) = 'Webinar User';
   DECLARE @email varchar(max);
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz email użytkownika
   SELECT @email = email
   FROM Users
   WHERE userID = @userID;


   -- Dodaj nowego Webinar User
   INSERT INTO WebinarUsers (description, email)
   VALUES (@description, @email);


   SET @webinarUserID = SCOPE_IDENTITY();


   -- Zaktualizuj pole webinarUserID w tabeli Users
   UPDATE Users
   SET webinarUserID = @webinarUserID
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO WebinarUsersDataChangeHistory
   VALUES (
       @webinarUserID, @dateOfChange,
       '', '', -- Brak starych wartości
       @description, @email
   );


   PRINT 'Nowy Webinar User został pomyślnie dodany.';
END;
go

-- Procedura dodająca użytkownika do kierunku studiów
   CREATE PROCEDURE AssignStudentToFieldOfStudies
   @fieldOfStudiesID int,
   @studiesUserID int
AS
BEGIN
   INSERT INTO StudiesUserAssignmentToFieldOfStudies (fieldOfStudiesID, studiesUserID)
   VALUES (@fieldOfStudiesID, @studiesUserID);


   UPDATE FieldOfStudies
   SET currEnrolls = currEnrolls + 1
   WHERE fieldOfStudiesID = @fieldOfStudiesID;
END;
go

-- Procedura dodająca użytkownika do kursu
CREATE PROCEDURE AssignUserToCourse
   @courseID int,
   @courseUserID int,
   @grade int,
   @passed int,
   @toPay money,
   @payed money,
   @accessGainedDate datetime,
   @haveAccess int
AS
BEGIN

 INSERT INTO CourseToUserAssignment (courseUserID, courseID, grade, passed, toPay, payed, accesGainedDate, haveAccess)
   VALUES (@courseUserID, @courseID, @grade, @passed, @toPay, @payed, @accessGainedDate, @haveAccess);

   UPDATE Courses
   SET currEnrolls = currEnrolls + 1
   WHERE courseID = @courseID;
END;
go

CREATE PROCEDURE AssignUserToStudiesSubject
   @studiesSubjectID int,
   @studiesUserID int,
   @grade int,
   @passed int
AS
BEGIN
   INSERT INTO StudiesUserAssignmentToStudiesSubject (studiesSubjectID, studiesUserID, grade, passed)
   VALUES (@studiesSubjectID, @studiesUserID, @grade, @passed);


   UPDATE StudiesSubject
   SET currEnrolls = currEnrolls + 1
   WHERE studiesSubjectID = @studiesSubjectID;
END;
go

-- Procedura dodająca użytkownika do webinaru
CREATE PROCEDURE AssignUserToWebinar
   @webinarID int,
   @webinarUserID int,
   @payed money,
   @toPay money,
   @haveAccess int,
   @haveParticipated int,
   @accessGainedDate datetime
AS
BEGIN
   INSERT INTO WebinarsToUserAssignment (webinarID, webinarUserID, payed, toPay, haveAccess, haveParticipated, accessGainedDate)
   VALUES (@webinarID, @webinarUserID, @payed, @toPay, @haveAccess, @haveParticipated, @accessGainedDate);
END;
go

-- Procedura usuń administratora
CREATE PROCEDURE DeleteAdministrator(
   @adminID int
)
AS
BEGIN
   -- Sprawdź, czy administrator istnieje
   IF EXISTS (SELECT 1 FROM Administrators WHERE adminID = @adminID)
   BEGIN
       -- Zapisz informacje o usuwanym administratorze w historii
       DECLARE @dateOfDeletion datetime = GETDATE();
       INSERT INTO AdministratorsDataChangeHistory
--        SELECT *, @dateOfDeletion FROM Administrators WHERE adminID = @adminID;
        SELECT
           adminID,
           @dateOfDeletion AS dateOfChange,
           accessLvl AS old_accessLvl,
           firstname AS old_firstname,
           lastname AS old_lastname,
           title AS old_title,
           email AS old_email,
           phone AS old_phone,
           encodedPassword AS old_encodedPassword,
           address AS old_address,
           postalcode AS old_postalcode,
           '' AS new_accessLvl,
           '' AS new_firstname,
           '' AS new_lastname,
           '' AS new_title,
           '' AS new_email,
           '' AS new_phone,
           '' AS new_encodedPassword,
           '' AS new_address,
           '' AS new_postalcode
       FROM Administrators
       WHERE adminID = @adminID;

       -- Usuń administratora
       DELETE FROM Administrators WHERE adminID = @adminID;


       PRINT 'Administrator zostal pomyslnie usuniety.';
   END
   ELSE
   BEGIN
       PRINT 'Administrator o podanym ID nie istnieje.';
   END
END;
go

CREATE PROCEDURE GetAdminChangeHistory
   @adminID int
AS
BEGIN
   SELECT *
   FROM AdministratorsDataChangeHistory
   WHERE adminID = @adminID;
END;
go

-- Procedura pobierz historię sesji administratora
CREATE PROCEDURE GetAdminSessionHistory(
   @adminID int
)
AS
BEGIN
   SELECT *
   FROM AdminSessionHistory
   WHERE adminID = @adminID;
END;
go

-- Procedura pobierz informacje o administratorze
CREATE PROCEDURE GetAdministratorInfo(
   @adminID int
)
AS
BEGIN
   SELECT
       adminID, accessLvl, firstname, lastname, title,
       email, phone, encodedPassword, address, postalcode
   FROM Administrators
   WHERE adminID = @adminID;
END;
go

--Procedura zwrająca informacje o kursie
       CREATE PROCEDURE GetCourseInfo(
  @courseID int
)
AS
BEGIN
  SELECT *
  FROM Courses
  WHERE courseID = @courseID;
END;
go

--Procedura zwrająca informacje o module kursu
       CREATE PROCEDURE GetCourseModuleInfo(
  @moduleID int,
  @courseID int
)
AS
BEGIN
  SELECT *
  FROM CourseModules
  WHERE moduleID = @moduleID AND courseID = @courseID;
END;
go

-- Procedura Zwracająca Informacje o CourseTeacher
CREATE PROCEDURE GetCourseTeacherInfo(
   @courseTeacherID int
)
AS
BEGIN
   -- Zwróć informacje o CourseTeacher
   SELECT
       ct.*,
       u.firstname,
       u.lastname,
       u.title
   FROM CourseTeacher ct
   JOIN Users u ON ct.courseTeacherID = u.courseTeacherID
   WHERE ct.courseTeacherID = @courseTeacherID;
END;
go

-- Procedura Zwracająca Historię dla CourseUser
CREATE PROCEDURE GetCourseUserHistory(
   @courseUserID int
)
AS
BEGIN
   -- Zwróć historię dla CourseUser
   SELECT *
   FROM CourseUsersDataChangeHistory
   WHERE courseUserID = @courseUserID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Informacje o CourseUser
CREATE PROCEDURE GetCourseUserInfo(
   @courseUserID int
)
AS
BEGIN
   -- Zwróć informacje o CourseUser
   SELECT
       cu.*,
       u.firstname,
       u.lastname,
       u.title
   FROM CourseUsers cu
   JOIN Users u ON cu.courseUserID = u.courseUserID
   WHERE cu.courseUserID = @courseUserID;
END;
go

-- Procedura zwrająca informacje o zajęciach
       CREATE PROCEDURE GetLessonsBySubject
  @studiesSubjectID int
AS
BEGIN
  SELECT *
  FROM Lessons
  WHERE studiesSubjectID = @studiesSubjectID;
END;
go

-- Procedura zwrająca informacje o obecności
           CREATE PROCEDURE GetOutsiderAttendance
  @outsiderID int
AS
BEGIN
  SELECT *
  FROM OutsidersAttendance
  WHERE outsiderID = @outsiderID;
END;
go

-- Procedura Zwracająca Historię dla Outsider
CREATE PROCEDURE GetOutsiderHistory(
   @outsiderID int
)
AS
BEGIN
   -- Zwróć historię dla Outsider
   SELECT *
   FROM OutsidersDataChangeHistory
   WHERE outsiderID = @outsiderID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Informacje o Outsider
CREATE PROCEDURE GetOutsiderInfo(
   @outsiderID int
)
AS
BEGIN
   -- Zwróć informacje o Outsider
   SELECT
       o.*,
       u.firstname,
       u.lastname,
       u.title
   FROM Outsiders o
   JOIN Users u ON o.outsiderID = u.studiesOutsiderID
   WHERE o.outsiderID = @outsiderID;
END;
go

CREATE FUNCTION GetRecentAccessTimeLaw()
RETURNS int
AS
BEGIN
   DECLARE @recentAccessTimeLaw int;


   SELECT @recentAccessTimeLaw = no_days
   FROM AccessTimeLaws
   WHERE isTheRecent = 1;


   RETURN @recentAccessTimeLaw;
END
go

CREATE FUNCTION GetRecentDaysOfPractice()
RETURNS int
AS
BEGIN
   DECLARE @recentDaysOfPractice int;


   SELECT @recentDaysOfPractice = no_days
   FROM DaysOfPracticeLaws
   WHERE isTheRecent = 1;


   RETURN @recentDaysOfPractice;
END
go

CREATE FUNCTION GetRecentMaxDaysForPaymentBeforeCourse()
RETURNS int
AS
BEGIN
   DECLARE @recentMaxDaysForPaymentBeforeCourse int;


   SELECT @recentMaxDaysForPaymentBeforeCourse = no_days
   FROM MaxDaysForPayementBeforeCourseLaws
   WHERE isTheRecent = 1;


   RETURN @recentMaxDaysForPaymentBeforeCourse;
END
go

CREATE FUNCTION GetRecentMaxDaysForPaymentBeforeStudies()
RETURNS int
AS
BEGIN
   DECLARE @recentMaxDaysForPaymentBeforeStudies int;


   SELECT @recentMaxDaysForPaymentBeforeStudies = no_days
   FROM MaxDaysForPayementBeforeStudiesLaws
   WHERE isTheRecent = 1;


   RETURN @recentMaxDaysForPaymentBeforeStudies;
END
go

CREATE FUNCTION GetRecentMinAttendanceForCourse()
RETURNS int
AS
BEGIN
   DECLARE @recentMinAttendance int;


   SELECT @recentMinAttendance = min_attendance
   FROM MinAttendanceToPassCourseLaws
   WHERE isTheRecent = 1;


   RETURN @recentMinAttendance;
END
go

CREATE FUNCTION GetRecentMinAttendanceForPractice()
RETURNS int
AS
BEGIN
   DECLARE @recentMinAttendance int;


   SELECT @recentMinAttendance = min_attendance
   FROM MinAttendanceToPassPracticeLaws
   WHERE isTheRecent = 1;


   RETURN @recentMinAttendance;
END
go

CREATE FUNCTION GetRecentMinAttendanceForStudies()
RETURNS int
AS
BEGIN
   DECLARE @recentMinAttendance int;


   SELECT @recentMinAttendance = min_attendance
   FROM MinAttendanceToPassStudiesLaws
   WHERE isTheRecent = 1;


   RETURN @recentMinAttendance;
END
go

-- Procedura Zwracająca Historię dla StudiesTeacher
CREATE PROCEDURE GetStudiesTeacherHistory(
   @studiesTeacherID int
)
AS
BEGIN
   -- Zwróć historię dla StudiesTeacher
   SELECT *
   FROM StudiesTeacherDataChangeHistory
   WHERE studiesTeacherID = @studiesTeacherID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Informacje o StudiesTeacher
CREATE PROCEDURE GetStudiesTeacherInfo(
   @studiesTeacherID int
)
AS
BEGIN
   -- Zwróć informacje o StudiesTeacher
   SELECT
       st.*,
       u.firstname,
       u.lastname,
       u.title
   FROM StudiesTeacher st
   JOIN Users u ON st.studiesTeacherID = u.studiesTeacherID
   WHERE st.studiesTeacherID = @studiesTeacherID;
END;
go

-- Procedura zwrająca informacje o obecności
CREATE PROCEDURE GetStudiesUserAttendance
  @studiesUserID int
AS
BEGIN
  SELECT *
  FROM StudiesUserAttendance
  WHERE studiesUserID = @studiesUserID;
END;
go

-- Procedura Zwracająca Historię dla StudiesUser
CREATE PROCEDURE GetStudiesUserHistory(
   @studiesUserID int
)
AS
BEGIN
   -- Zwróć historię dla StudiesUser
   SELECT *
   FROM StudiesUserDataChangeHistory
   WHERE studiesUserID = @studiesUserID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Informacje o StudiesUser
CREATE PROCEDURE GetStudiesUserInfo(
   @studiesUserID int
)
AS
BEGIN
   -- Zwróć informacje o StudiesUser
   SELECT
       su.*,
       u.firstname,
       u.lastname,
       u.title
   FROM StudiesUser su
   JOIN Users u ON su.studiesUserID = u.studiesUserID
   WHERE su.studiesUserID = @studiesUserID;
END;
go

CREATE FUNCTION GetTotalPriceForCourseUser(
   @courseUserId int
)
RETURNS money
AS
BEGIN
   DECLARE @totalPrice money;


   SELECT @totalPrice = SUM(price)
   FROM CoursesShoppingItem
   WHERE courseUserID = @courseUserId;


   RETURN @totalPrice;
END
go

CREATE FUNCTION GetTotalPriceForStudiesUserForOutsiders(
   @studiesUserId int
)
RETURNS money
AS
BEGIN
   DECLARE @totalPrice money;


   SELECT @totalPrice = SUM(price)
   FROM StudiesShoppingItemForOutsiders
   WHERE studiesUserID = @studiesUserId;


   RETURN @totalPrice;
END
go

CREATE FUNCTION GetTotalPriceForStudiesUserForStudiesUser(
   @studiesUserId int
)
RETURNS money
AS
BEGIN
   DECLARE @totalPrice money;


   SELECT @totalPrice = SUM(price)
   FROM StudiesShoppingItemForStudiesUser
   WHERE studiesUserID = @studiesUserId;


   RETURN @totalPrice;
END
go

CREATE FUNCTION GetTotalPriceForWebinarUser(
   @webinarUserId int
)
RETURNS money
AS
BEGIN
   DECLARE @totalPrice money;


   SELECT @totalPrice = SUM(price)
   FROM WebinarsShoppingItem
   WHERE webinarUserID = @webinarUserId;


   RETURN @totalPrice;
END
go

-- Procedura Zwracająca Historię dla Tłumacza
CREATE PROCEDURE GetTranslatorHistory(
   @translatorID int
)
AS
BEGIN
   -- Zwróć historię dla Tłumacza
   SELECT *
   FROM TranslatorsDataChangeHistory
   WHERE translatorID = @translatorID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Historię dla Użytkownika
CREATE PROCEDURE GetUserHistory(
   @userID int
)
AS
BEGIN
   -- Zwróć historię dla Użytkownika
   SELECT *
   FROM UsersDataChangeHistory
   WHERE userID = @userID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Pobierania Informacji o Użytkowniku
CREATE PROCEDURE GetUserInfo(
   @userID int
)
AS
BEGIN
   SELECT
       userID,
       firstname,
       lastname,
       title,
       email,
       phone,
       encodedPassword,
       address,
       postalcode
   FROM Users
   WHERE userID = @userID;
END;
go

-- Procedura Pobierania Informacji o Sesjach Użytkownika
CREATE PROCEDURE GetUserSessionHistory(
   @userID int
)
AS
BEGIN
   SELECT *
   FROM UserSessionHistory
   WHERE userID = @userID;
END;
go

--Procedura zwrająca informacje o webinarze
       CREATE PROCEDURE GetWebinarInfo(
  @webinarID int
)
AS
BEGIN
  SELECT *
  FROM Webinars
  WHERE webinarID = @webinarID;
END;
go

-- Procedura Zwracająca Historię dla WebinarTeacher (po webinarTeacherID)
CREATE PROCEDURE GetWebinarTeacherHistory(
   @webinarTeacherID int
)
AS
BEGIN
   -- Zwróć historię dla WebinarTeacher
   SELECT *
   FROM WebinarTeacherDataChangeHistory
   WHERE webinarTeacherID = @webinarTeacherID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Informacje o WebinarTeacher (po webinarTeacherID)
CREATE PROCEDURE GetWebinarTeacherInfo(
   @webinarTeacherID int
)
AS
BEGIN
   -- Zmienne do przechowywania danych
   DECLARE @firstname varchar(max), @lastname varchar(max), @title varchar(max);


   -- Pobierz informacje z tabeli Users
   SELECT
       @firstname = firstname,
       @lastname = lastname,
       @title = title
   FROM Users
   WHERE webinarTeacherID = @webinarTeacherID;


   -- Zwróć informacje o nauczycielu
   SELECT
       @firstname AS FirstName,
       @lastname AS LastName,
       @title AS Title,
       wt.*
   FROM WebinarTeacher wt
   WHERE wt.webinarTeacherID = @webinarTeacherID;
END;
go

-- Procedura Zwracająca Historię dla WebinarUser
CREATE PROCEDURE GetWebinarUserHistory(
   @webinarUserID int
)
AS
BEGIN
   -- Zwróć historię dla WebinarUser
   SELECT *
   FROM WebinarUsersDataChangeHistory
   WHERE webinarUserID = @webinarUserID
   ORDER BY dateOfChange DESC;
END;
go

-- Procedura Zwracająca Informacje dla WebinarUser (po webinarUserID)
CREATE PROCEDURE GetWebinarUserInfo(
   @webinarUserID int
)
AS
BEGIN
   -- Zmienne do przechowywania danych
   DECLARE @firstname varchar(max), @lastname varchar(max), @title varchar(max);


   -- Pobierz informacje z tabeli Users
   SELECT
       @firstname = firstname,
       @lastname = lastname,
       @title = title
   FROM Users
   WHERE webinarUserID = @webinarUserID;


   -- Zwróć informacje o WebinarUser
   SELECT
       @firstname AS FirstName,
       @lastname AS LastName,
       @title AS Title,
       wu.*
   FROM WebinarUsers wu
   WHERE wu.webinarUserID = @webinarUserID;
END;
go

-- Procedura Wstawiania Danych Ról Dla Użytkownika
CREATE PROCEDURE InsertUserRoles(
   @userID int,
   @translatorID int = NULL,
   @webinarUserID int = NULL,
   @webinarTeacherID int = NULL,
   @courseUserID int = NULL,
   @courseTeacherID int = NULL,
   @studiesUserID int = NULL,
   @studiesTeacherID int = NULL,
   @studiesOutsiderID int = NULL
)
AS
BEGIN
   UPDATE Users
   SET
       translatorID = ISNULL(@translatorID, translatorID),
       webinarUserID = ISNULL(@webinarUserID, webinarUserID),
       webinarTeacherID = ISNULL(@webinarTeacherID, webinarTeacherID),
       courseUserID = ISNULL(@courseUserID, courseUserID),
       courseTeacherID = ISNULL(@courseTeacherID, courseTeacherID),
       studiesUserID = ISNULL(@studiesUserID, studiesUserID),
       studiesTeacherID = ISNULL(@studiesTeacherID, studiesTeacherID),
       studiesOutsiderID = ISNULL(@studiesOutsiderID, studiesOutsiderID)
   WHERE userID = @userID;


   PRINT 'Dane ról zostały pomyślnie zaktualizowane dla userID: ' + CAST(@userID AS varchar(10));
END;
go

CREATE PROCEDURE ModifyAdministrator(
   @adminID int,
   @newAccessLvl int = NULL,
   @newFirstname varchar(max) = NULL,
   @newLastname varchar(max) = NULL,
   @newTitle varchar(max) = NULL,
   @newEmail varchar(max) = NULL,
   @newPhone varchar(max) = NULL,
   @newEncodedPassword varchar(max) = NULL,
   @newAddress varchar(max) = NULL,
   @newPostalcode varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();

   -- Pobierz informacje o istniejącym administratorze
   DECLARE @oldAccessLvl int, @oldFirstname varchar(max), @oldLastname varchar(max), @oldTitle varchar(max),
           @oldEmail varchar(max), @oldPhone varchar(max), @oldEncodedPassword varchar(max), @oldAddress varchar(max), @oldPostalcode varchar(max);

   SELECT
       @oldAccessLvl = accessLvl,
       @oldFirstname = firstname,
       @oldLastname = lastname,
       @oldTitle = title,
       @oldEmail = email,
       @oldPhone = phone,
       @oldEncodedPassword = encodedPassword,
       @oldAddress = address,
       @oldPostalcode = postalcode
   FROM Administrators
   WHERE adminID = @adminID;

   -- Aktualizuj pola o nowe wartości
   UPDATE Administrators
   SET
       accessLvl = ISNULL(@newAccessLvl, @oldAccessLvl),
       firstname = ISNULL(@newFirstname, @oldFirstname),
       lastname = ISNULL(@newLastname, @oldLastname),
       title = ISNULL(@newTitle, @oldTitle),
       email = ISNULL(@newEmail, @oldEmail),
       phone = ISNULL(@newPhone, @oldPhone),
       encodedPassword = ISNULL(@newEncodedPassword, @oldEncodedPassword),
       address = ISNULL(@newAddress, @oldAddress),
       postalcode = ISNULL(@newPostalcode, @oldPostalcode)
   WHERE adminID = @adminID;

   -- Zapisz zmiany w historii
   INSERT INTO AdministratorsDataChangeHistory
   VALUES (
       @adminID,
       @dateOfChange,
       @oldAccessLvl,
       @oldFirstname,
       @oldLastname,
       @oldTitle,
       @oldEmail,
       @oldPhone,
       @oldEncodedPassword,
       @oldAddress,
       @oldPostalcode,
       ISNULL(@newAccessLvl, @oldAccessLvl),
       ISNULL(@newFirstname, @oldFirstname),
       ISNULL(@newLastname, @oldLastname),
       ISNULL(@newTitle, @oldTitle),
       ISNULL(@newEmail, @oldEmail),
       ISNULL(@newPhone, @oldPhone),
       ISNULL(@newEncodedPassword, @oldEncodedPassword),
       ISNULL(@newAddress, @oldAddress),
       ISNULL(@newPostalcode, @oldPostalcode)
   );
END;
go

--Procedura modyfikująca moduł kursu
   CREATE PROCEDURE ModifyCourseModule(
  @moduleID int,
  @courseID int,
  @newCourseWebinarID int = NULL,
  @newTranslatorID int = NULL,
  @newAttendanceType varchar(max) = NULL,
  @newName varchar(max) = NULL,
  @newType varchar(max) = NULL,
  @newClassroom varchar(max) = NULL,
  @newLinkToRecord varchar(max) = NULL,
  @newDescription varchar(max) = NULL
)
AS
BEGIN
  DECLARE @dateOfChange datetime = GETDATE();

  DECLARE @oldCourseWebinarID int, @oldTranslatorID int, @oldAttendanceType varchar(max), @oldName varchar(max), @oldType varchar(max), @oldClassroom varchar(max), @oldLinkToRecord varchar(max), @oldDescription varchar(max);

  SELECT @oldCourseWebinarID = courseWebinarID, @oldTranslatorID = translatorID, @oldAttendanceType = attendanceType, @oldName = name, @oldType = type, @oldClassroom = classroom, @oldLinkToRecord = linkToRecord, @oldDescription = description
  FROM CourseModules
  WHERE moduleID = @moduleID AND courseID = @courseID;

  UPDATE CourseModules
  SET courseWebinarID = ISNULL(@newCourseWebinarID, courseWebinarID), translatorID = ISNULL(@newTranslatorID, translatorID), attendanceType = ISNULL(@newAttendanceType, attendanceType), name = ISNULL(@newName, name), type = ISNULL(@newType, type), classroom = ISNULL(@newClassroom, classroom), linkToRecord = ISNULL(@newLinkToRecord, linkToRecord), description = ISNULL(@newDescription, description)
  WHERE moduleID = @moduleID AND courseID = @courseID;

  INSERT INTO CourseModulesDataChangeHistory
  VALUES (@moduleID, @courseID, @dateOfChange, @oldCourseWebinarID, @oldTranslatorID, @oldAttendanceType, @oldName, @oldType, @oldClassroom, @oldLinkToRecord, @oldDescription, ISNULL(@newCourseWebinarID, @oldCourseWebinarID), ISNULL(@newTranslatorID, @oldTranslatorID), ISNULL(@newAttendanceType, @oldAttendanceType), ISNULL(@newName, @oldName), ISNULL(@newType, @oldType), ISNULL(@newClassroom, @oldClassroom), ISNULL(@newLinkToRecord, @oldLinkToRecord), ISNULL(@newDescription, @oldDescription));

  PRINT 'Course module data has been successfully updated.';
END;
go

-- Procedura Modyfikowania Danych CourseTeacher
CREATE PROCEDURE ModifyCourseTeacherData(
   @courseTeacherID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane CourseTeacher
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM CourseTeacher
   WHERE courseTeacherID = @courseTeacherID;


   -- Aktualizuj pola o nowe wartości
   UPDATE CourseTeacher
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE courseTeacherID = @courseTeacherID;


   -- Zapisz zmiany w historii
   INSERT INTO CourseTeacherDataChangeHistory
   VALUES (
       @courseTeacherID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newEmail, @oldEmail)
   );


   PRINT 'Dane CourseTeacher zostały pomyślnie zaktualizowane.';
END;
go

-- Procedura Modyfikowania Danych CourseUsers
CREATE PROCEDURE ModifyCourseUsersData(
   @courseUserID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane CourseUsers
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM CourseUsers
   WHERE courseUserID = @courseUserID;


   -- Aktualizuj pola o nowe wartości
   UPDATE CourseUsers
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE courseUserID = @courseUserID;


   -- Zapisz zmiany w historii
   INSERT INTO CourseUsersDataChangeHistory
   VALUES (
       @courseUserID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newEmail, @oldEmail)
   );


   PRINT 'Dane CourseUsers zostały pomyślnie zaktualizowane.';
END;
go

-- Procedura Modyfikowania Danych Outsider
CREATE PROCEDURE ModifyOutsiderData(
   @outsiderID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane Outsider
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM Outsiders
   WHERE outsiderID = @outsiderID;


   -- Aktualizuj pola o nowe wartości
   UPDATE Outsiders
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE outsiderID = @outsiderID;


   -- Zapisz zmiany w historii
   INSERT INTO OutsidersDataChangeHistory
   VALUES (
       @outsiderID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newEmail, @oldEmail)
   );


   PRINT N'Dane Outsider zostały pomyślnie zaktualizowane.';
END;
go

-- Procedura Modyfikowania Danych StudiesTeacher
CREATE PROCEDURE ModifyStudiesTeacherData(
   @studiesTeacherID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane StudiesTeacher
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM StudiesTeacher
   WHERE studiesTeacherID = @studiesTeacherID;


   -- Aktualizuj pola o nowe wartości
   UPDATE StudiesTeacher
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE studiesTeacherID = @studiesTeacherID;


   -- Zapisz zmiany w historii
   INSERT INTO StudiesTeacherDataChangeHistory
   VALUES (
       @studiesTeacherID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newEmail, @oldEmail)
   );


   PRINT N'Dane StudiesTeacher zostały pomyślnie zaktualizowane.';
END;
go

-- Procedura Modyfikowania Danych StudiesUser (Admin)
CREATE PROCEDURE ModifyStudiesUserData(
   @studiesUserID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL,
   @newSemester int = NULL,
   @newIsActive int = NULL,
   @newIndex int = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane StudiesUser
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max), @oldSemester int, @oldIsActive int, @oldIndex int;


   SELECT
       @oldEmail = email,
       @oldDescription = description,
       @oldSemester = semester,
       @oldIsActive = isActive,
       @oldIndex = "index"
   FROM StudiesUser
   WHERE studiesUserID = @studiesUserID;


   -- Aktualizuj pola o nowe wartości
   UPDATE StudiesUser
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription),
       semester = ISNULL(@newSemester, @oldSemester),
       isActive = ISNULL(@newIsActive, @oldIsActive),
       "index" = ISNULL(@newIndex, @oldIndex)
   WHERE studiesUserID = @studiesUserID;


   -- Zapisz zmiany w historii
   INSERT INTO StudiesUserDataChangeHistory
   VALUES (
       @studiesUserID, @dateOfChange,
       @oldDescription, @oldSemester, @oldIsActive, @oldIndex, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newSemester, @oldSemester),
       ISNULL(@newIsActive, @oldIsActive), ISNULL(@newIndex, @oldIndex), ISNULL(@newEmail, @oldEmail)
   );


   PRINT N'Dane StudiesUser zostały pomyślnie zaktualizowane.';
END;
go

CREATE PROCEDURE ModifyTranslatorData(
   @translatorID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane tłumacza
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM Translators
   WHERE translatorID = @translatorID;


   -- Aktualizuj pola o nowe wartości
   UPDATE Translators
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE translatorID = @translatorID;


   -- Zapisz zmiany w historii
   INSERT INTO TranslatorsDataChangeHistory
   VALUES (
       @translatorID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription),
       ISNULL(@newEmail, @oldEmail)
   );


   PRINT 'Dane tłumacza zostały pomyślnie zaktualizowane.';
END;
go

-- Procedura Modyfikowania Danych Użytkownika
CREATE PROCEDURE ModifyUserData(
   @userID int,
   @newFirstname varchar(max) = NULL,
   @newLastname varchar(max) = NULL,
   @newTitle varchar(max) = NULL,
   @newEmail varchar(max) = NULL,
   @newPhone varchar(max) = NULL,
   @newEncodedPassword varchar(max) = NULL,
   @newAddress varchar(max) = NULL,
   @newPostalcode varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane użytkownika
   DECLARE @oldFirstname varchar(max), @oldLastname varchar(max), @oldTitle varchar(max),
           @oldEmail varchar(max), @oldPhone varchar(max), @oldEncodedPassword varchar(max),
           @oldAddress varchar(max), @oldPostalcode varchar(max);


   SELECT
       @oldFirstname = firstname,
       @oldLastname = lastname,
       @oldTitle = title,
       @oldEmail = email,
       @oldPhone = phone,
       @oldEncodedPassword = encodedPassword,
       @oldAddress = address,
       @oldPostalcode = postalcode
   FROM Users
   WHERE userID = @userID;


   -- Aktualizuj pola o nowe wartości
   UPDATE Users
   SET
       firstname = ISNULL(@newFirstname, @oldFirstname),
       lastname = ISNULL(@newLastname, @oldLastname),
       title = ISNULL(@newTitle, @oldTitle),
       email = ISNULL(@newEmail, @oldEmail),
       phone = ISNULL(@newPhone, @oldPhone),
       encodedPassword = ISNULL(@newEncodedPassword, @oldEncodedPassword),
       address = ISNULL(@newAddress, @oldAddress),
       postalcode = ISNULL(@newPostalcode, @oldPostalcode)
   WHERE userID = @userID;


   -- Zapisz zmiany w historii
   INSERT INTO UsersDataChangeHistory
   VALUES (
       @userID,
       @dateOfChange,
       @oldFirstname,
       @oldLastname,
       @oldTitle,
       @oldEmail,
       @oldPhone,
       @oldEncodedPassword,
       @oldAddress,
       @oldPostalcode,
       ISNULL(@newFirstname, @oldFirstname),
       ISNULL(@newLastname, @oldLastname),
       ISNULL(@newTitle, @oldTitle),
       ISNULL(@newEmail, @oldEmail),
       ISNULL(@newPhone, @oldPhone),
       ISNULL(@newEncodedPassword, @oldEncodedPassword),
       ISNULL(@newAddress, @oldAddress),
       ISNULL(@newPostalcode, @oldPostalcode)
   );


   PRINT 'Dane użytkownika zostały pomyślnie zaktualizowane.';
END;
go

--Procedura modyfikująca webinar
   CREATE PROCEDURE ModifyWebinar(
  @webinarID int,
  @newWebinarTeacherID int = NULL,
  @newTranslatorID int = NULL,
  @newDate datetime = NULL,
  @newPrice money = NULL,
  @newLinkToMeet varchar(max) = NULL,
  @newDescription varchar(max) = NULL
)
AS
BEGIN
  DECLARE @dateOfChange datetime = GETDATE();

  DECLARE @oldWebinarTeacherID int, @oldTranslatorID int, @oldDate datetime, @oldPrice money, @oldLinkToMeet varchar(max), @oldDescription varchar(max);

  SELECT @oldWebinarTeacherID = webinarTeacherID, @oldTranslatorID = translatorID, @oldDate = date, @oldPrice = price, @oldLinkToMeet = linkToMeet, @oldDescription = description
  FROM Webinars
  WHERE webinarID = @webinarID;

  UPDATE Webinars
  SET webinarTeacherID = ISNULL(@newWebinarTeacherID, webinarTeacherID), translatorID = ISNULL(@newTranslatorID, translatorID), date = ISNULL(@newDate, date), price = ISNULL(@newPrice, price), linkToMeet = ISNULL(@newLinkToMeet, linkToMeet), description = ISNULL(@newDescription, description)
  WHERE webinarID = @webinarID;

  INSERT INTO WebinarsDataChangeHistory
  VALUES (@webinarID, @dateOfChange, @oldWebinarTeacherID, @oldTranslatorID, @oldDate, @oldPrice, @oldLinkToMeet, @oldDescription, ISNULL(@newWebinarTeacherID, @oldWebinarTeacherID), ISNULL(@newTranslatorID, @oldTranslatorID), ISNULL(@newDate, @oldDate), ISNULL(@newPrice, @oldPrice), ISNULL(@newLinkToMeet, @oldLinkToMeet), ISNULL(@newDescription, @oldDescription));

  PRINT 'Webinar data has been successfully updated.';
END;
go

-- Procedura Modyfikowania Danych WebinarTeacher (po webinarTeacherID)
CREATE PROCEDURE ModifyWebinarTeacherDataByID(
   @webinarTeacherID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane WebinarTeacher
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM WebinarTeacher
   WHERE webinarTeacherID = @webinarTeacherID;


   -- Aktualizuj pola o nowe wartości
   UPDATE WebinarTeacher
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE webinarTeacherID = @webinarTeacherID;


   -- Zapisz zmiany w historii
   INSERT INTO WebinarTeacherDataChangeHistory
   VALUES (
       @webinarTeacherID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newEmail, @oldEmail)
   );


   PRINT 'Dane WebinarTeacher zostały pomyślnie zaktualizowane.';
END;
go

-- Procedura Modyfikowania Danych dla WebinarUser (po webinarUserID)
CREATE PROCEDURE ModifyWebinarUserData(
   @webinarUserID int,
   @newEmail varchar(max) = NULL,
   @newDescription varchar(max) = NULL
)
AS
BEGIN
   DECLARE @dateOfChange datetime = GETDATE();


   -- Pobierz istniejące dane WebinarUser
   DECLARE @oldEmail varchar(max), @oldDescription varchar(max);


   SELECT
       @oldEmail = email,
       @oldDescription = description
   FROM WebinarUsers
   WHERE webinarUserID = @webinarUserID;


   -- Aktualizuj pola o nowe wartości
   UPDATE WebinarUsers
   SET
       email = ISNULL(@newEmail, @oldEmail),
       description = ISNULL(@newDescription, @oldDescription)
   WHERE webinarUserID = @webinarUserID;


   -- Zapisz zmiany w historii
   INSERT INTO WebinarUsersDataChangeHistory
   VALUES (
       @webinarUserID, @dateOfChange,
       @oldDescription, @oldEmail,
       ISNULL(@newDescription, @oldDescription), ISNULL(@newEmail, @oldEmail)
   );


   PRINT 'Dane WebinarUser zostały pomyślnie zaktualizowane.';
END;
go

--Procedura usuwająca moduł kursu
           CREATE PROCEDURE RemoveCourseModule(
  @moduleID int,
  @courseID int
)
AS
BEGIN
  IF EXISTS (SELECT 1 FROM CourseModules WHERE moduleID = @moduleID AND courseID = @courseID)
  BEGIN
      DELETE FROM CourseModules
      WHERE moduleID = @moduleID AND courseID = @courseID;

      PRINT 'Course module has been successfully removed.';
  END
  ELSE
  BEGIN
      PRINT 'Course module with the provided ID does not exist.';
  END
END;
go

-- Procedura Usuwania Roli CourseTeacher
CREATE PROCEDURE RemoveCourseTeacherRole(
   @userID int
)
AS
BEGIN
   DECLARE @courseTeacherID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz courseTeacherID użytkownika
   SELECT @courseTeacherID = courseTeacherID
   FROM Users
   WHERE userID = @userID;


   IF @courseTeacherID IS NOT NULL
   BEGIN
       -- Usuń rolę Course Teacher
       UPDATE Users
       SET courseTeacherID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Course Teacher w historii
       INSERT INTO CourseTeacherDataChangeHistory
       VALUES (
           @courseTeacherID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT 'Rola Course Teacher została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT 'Użytkownik o podanym ID nie posiada roli Course Teacher.';
   END
END;
go

-- Procedura Usuwania Roli CourseUsers
CREATE PROCEDURE RemoveCourseUsersRole(
   @userID int
)
AS
BEGIN
   DECLARE @courseUserID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz courseUserID użytkownika
   SELECT @courseUserID = courseUserID
   FROM Users
   WHERE userID = @userID;


   IF @courseUserID IS NOT NULL
   BEGIN
       -- Usuń rolę Course User
       UPDATE Users
       SET courseUserID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Course User w historii
       INSERT INTO CourseUsersDataChangeHistory
       VALUES (
           @courseUserID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT 'Rola Course User została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT 'Użytkownik o podanym ID nie posiada roli Course User.';
   END
END;
go

-- Procedura usuwająca zajęcia
   CREATE PROCEDURE RemoveLesson
  @lessonID int,
  @studiesSubjectID int
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Lessons WHERE lessonID = @lessonID AND studiesSubjectID = @studiesSubjectID)
  BEGIN
      DECLARE @old_studiesTeacherID int, @old_translatorID int, @old_date datetime, @old_description varchar(max), @old_classroom varchar(max), @old_attendanceType varchar(max), @old_type varchar(max), @old_linkToMeeting varchar(max), @old_singleLessonPrice money, @old_studentPrice money, @old_maxEnrolls int;

      SELECT @old_studiesTeacherID = studiesTeacherID, @old_translatorID = translatorID, @old_date = date, @old_description = description, @old_classroom = classroom, @old_attendanceType = attendanceType, @old_type = type, @old_linkToMeeting = linkToMeeting, @old_singleLessonPrice = singleLessonPrice, @old_studentPrice = studentPrice, @old_maxEnrolls = maxEnrolls
      FROM Lessons
      WHERE lessonID = @lessonID AND studiesSubjectID = @studiesSubjectID;

      DELETE FROM Lessons
      WHERE lessonID = @lessonID AND studiesSubjectID = @studiesSubjectID;

      INSERT INTO LessonsDataChangeHistory (lessonID, studiesSubjectID, dateOfChange, old_studiesTeacherID, old_translatorID, old_date, old_description, old_classroom, old_attendanceType, old_type, old_linkToMeeting, old_singleLessonPrice, old_studentPrice, old_maxEnrolls)
      VALUES (@lessonID, @studiesSubjectID, GETDATE(), @old_studiesTeacherID, @old_translatorID, @old_date, @old_description, @old_classroom, @old_attendanceType, @old_type, @old_linkToMeeting, @old_singleLessonPrice, @old_studentPrice, @old_maxEnrolls);

      PRINT 'Lesson has been successfully removed.';
  END
  ELSE
  BEGIN
      PRINT 'Lesson does not exist.';
  END
END;
go

-- Procedura Usuwania Roli Outsider
CREATE PROCEDURE RemoveOutsiderRole(
   @userID int
)
AS
BEGIN
   DECLARE @outsiderID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz outsiderID użytkownika
   SELECT @outsiderID = studiesOutsiderID
   FROM Users
   WHERE userID = @userID;


   IF @outsiderID IS NOT NULL
   BEGIN
       -- Usuń rolę Outsider
       UPDATE Users
       SET studiesOutsiderID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Outsider w historii
       INSERT INTO OutsidersDataChangeHistory
       VALUES (
           @outsiderID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT N'Rola Outsider została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT N'Użytkownik o podanym ID nie posiada roli Outsider.';
   END
END;
go

-- Procedura usuwająca użytkownika z kierunku studiów
       CREATE PROCEDURE RemoveStudentFromFieldOfStudies
   @fieldOfStudiesID int,
   @studiesUserID int
AS
BEGIN
   DELETE FROM StudiesUserAssignmentToFieldOfStudies
   WHERE fieldOfStudiesID = @fieldOfStudiesID AND studiesUserID = @studiesUserID;


   UPDATE FieldOfStudies
   SET currEnrolls = currEnrolls - 1
   WHERE fieldOfStudiesID = @fieldOfStudiesID;
END;
go

-- Procedura Usuwania Roli StudiesTeacher
CREATE PROCEDURE RemoveStudiesTeacherRole(
   @userID int
)
AS
BEGIN
   DECLARE @studiesTeacherID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz studiesTeacherID użytkownika
   SELECT @studiesTeacherID = studiesTeacherID
   FROM Users
   WHERE userID = @userID;


   IF @studiesTeacherID IS NOT NULL
   BEGIN
       -- Usuń rolę Studies Teacher
       UPDATE Users
       SET studiesTeacherID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Studies Teacher w historii
       INSERT INTO StudiesTeacherDataChangeHistory
       VALUES (
           @studiesTeacherID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT N'Rola Studies Teacher została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT N'Użytkownik o podanym ID nie posiada roli Studies Teacher.';
   END
END;
go

-- Procedura Usuwania Roli StudiesUser
CREATE PROCEDURE RemoveStudiesUserRole(
   @userID int
)
AS
BEGIN
   DECLARE @studiesUserID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz studiesUserID użytkownika
   SELECT @studiesUserID = studiesUserID
   FROM Users
   WHERE userID = @userID;


   IF @studiesUserID IS NOT NULL
   BEGIN
       -- Usuń rolę Studies User
       UPDATE Users
       SET studiesUserID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Studies User w historii
       INSERT INTO StudiesUserDataChangeHistory
       VALUES (
           @studiesUserID, @dateOfRemoval,
           '', 0, 0, 0, '', -- Brak starych wartości
           '', 0, 0, 0, ''  -- Brak nowych wartości
       );


       PRINT N'Rola Studies User została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT N'Użytkownik o podanym ID nie posiada roli Studies User.';
   END
END;
go

-- Procedura Usuwania Tłumacza
CREATE PROCEDURE RemoveTranslatorRole(
   @userID int
)
AS
BEGIN
   DECLARE @dateOfRemoval datetime = GETDATE();
   DECLARE @translatorID int;


   -- Sprawdź, czy użytkownik ma przypisaną rolę tłumacza
   SELECT @translatorID = translatorID
   FROM Users
   WHERE userID = @userID;


   IF @translatorID IS NOT NULL
   BEGIN
       -- Usuń rolę tłumacza poprzez ustawienie translatorID na NULL
       UPDATE Users
       SET translatorID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli tłumacza w historii
       INSERT INTO TranslatorsDataChangeHistory
       VALUES (
           @translatorID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT 'Rola tłumacza została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT 'Użytkownik o podanym ID nie posiada roli tłumacza.';
   END
END;
go

-- Procedura usuwająca użytkownika z kursu
CREATE PROCEDURE RemoveUserFromCourse
   @courseID int,
   @courseUserID int
AS
BEGIN
   -- Decrease the current enrollment count of the course
   UPDATE Courses
   SET currEnrolls = currEnrolls - 1
   WHERE courseID = @courseID;

   -- Delete the user's assignment to the course
   DELETE FROM CourseToUserAssignment
   WHERE courseUserID = @courseUserID AND courseID = @courseID;
END;
go

-- Procedura usuwająca użytkownika z przedmiotu studiów
CREATE PROCEDURE RemoveUserFromStudiesSubject
   @studiesSubjectID int,
   @studiesUserID int
AS
BEGIN
   DELETE FROM StudiesUserAssignmentToStudiesSubject
   WHERE studiesSubjectID = @studiesSubjectID AND studiesUserID = @studiesUserID;


   UPDATE StudiesSubject
   SET currEnrolls = currEnrolls - 1
   WHERE studiesSubjectID = @studiesSubjectID;
END;
go

-- Procedura usuwająca użytkownika z webinaru
CREATE PROCEDURE RemoveUserFromWebinar
   @webinarID int,
   @webinarUserID int
AS
BEGIN
   DELETE FROM WebinarsToUserAssignment
   WHERE webinarID = @webinarID AND webinarUserID = @webinarUserID;
END;
go

-- Procedura Usuwania Ról Dla Użytkownika
--     @Danger
CREATE PROCEDURE RemoveUserRoles(
   @userID int,
   @translatorRole bit = NULL,
   @webinarUserRole bit = NULL,
   @webinarTeacherRole bit = NULL,
   @courseUserRole bit = NULL,
   @courseTeacherRole bit = NULL,
   @studiesUserRole bit = NULL,
   @studiesTeacherRole bit = NULL,
   @studiesOutsiderRole bit = NULL
)
AS
BEGIN
   UPDATE Users
   SET
       translatorID = CASE WHEN @translatorRole IS NOT NULL AND @translatorRole = 0 THEN NULL ELSE translatorID END,
       webinarUserID = CASE WHEN @webinarUserRole IS NOT NULL AND @webinarUserRole = 0 THEN NULL ELSE webinarUserID END,
       webinarTeacherID = CASE WHEN @webinarTeacherRole IS NOT NULL AND @webinarTeacherRole = 0 THEN NULL ELSE webinarTeacherID END,
       courseUserID = CASE WHEN @courseUserRole IS NOT NULL AND @courseUserRole = 0 THEN NULL ELSE courseUserID END,
       courseTeacherID = CASE WHEN @courseTeacherRole IS NOT NULL AND @courseTeacherRole = 0 THEN NULL ELSE courseTeacherID END,
       studiesUserID = CASE WHEN @studiesUserRole IS NOT NULL AND @studiesUserRole = 0 THEN NULL ELSE studiesUserID END,
       studiesTeacherID = CASE WHEN @studiesTeacherRole IS NOT NULL AND @studiesTeacherRole = 0 THEN NULL ELSE studiesTeacherID END,
       studiesOutsiderID = CASE WHEN @studiesOutsiderRole IS NOT NULL AND @studiesOutsiderRole = 0 THEN NULL ELSE studiesOutsiderID END
   WHERE userID = @userID;


   PRINT 'Role zostały pomyślnie usunięte dla userID: ' + CAST(@userID AS varchar(10));
END;
go

--Procedura usuwająca webinar
CREATE PROCEDURE RemoveWebinar(
  @webinarID int
)
AS
BEGIN
  -- Check if the webinar exists
  IF EXISTS (SELECT 1 FROM Webinars WHERE webinarID = @webinarID)
  BEGIN
      -- Delete the webinar
      DELETE FROM Webinars
      WHERE webinarID = @webinarID;


      PRINT 'Webinar has been successfully removed.';
  END
  ELSE
  BEGIN
      PRINT 'Webinar with the provided ID does not exist.';
  END
END;
go

-- Procedura Usuwania Roli WebinarTeacher (po userID)
CREATE PROCEDURE RemoveWebinarTeacherRole(
   @userID int
)
AS
BEGIN
   DECLARE @webinarTeacherID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz webinarTeacherID użytkownika
   SELECT @webinarTeacherID = webinarTeacherID
   FROM Users
   WHERE userID = @userID;


   IF @webinarTeacherID IS NOT NULL
   BEGIN
       -- Usuń rolę Webinar Teacher
       UPDATE Users
       SET webinarTeacherID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Webinar Teacher w historii
       INSERT INTO WebinarTeacherDataChangeHistory
       VALUES (
           @webinarTeacherID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT 'Rola Webinar Teacher została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT 'Użytkownik o podanym ID nie posiada roli Webinar Teacher.';
   END
END;
go

-- Procedura Usuwania Roli WebinarUsers
CREATE PROCEDURE RemoveWebinarUsersRole(
   @userID int
)
AS
BEGIN
   DECLARE @webinarUserID int;
   DECLARE @dateOfRemoval datetime = GETDATE();


   -- Pobierz webinarUserID użytkownika
   SELECT @webinarUserID = webinarUserID
   FROM Users
   WHERE userID = @userID;


   IF @webinarUserID IS NOT NULL
   BEGIN
       -- Usuń rolę Webinar User
       UPDATE Users
       SET webinarUserID = NULL
       WHERE userID = @userID;


       -- Zapisz informacje o usunięciu roli Webinar User w historii
       INSERT INTO WebinarUsersDataChangeHistory
       VALUES (
           @webinarUserID, @dateOfRemoval,
           '', '', -- Brak starych wartości
           '', ''  -- Brak nowych wartości
       );


       PRINT 'Rola Webinar User została pomyślnie usunięta dla userID: ' + CAST(@userID AS varchar(10));
   END
   ELSE
   BEGIN
       PRINT 'Użytkownik o podanym ID nie posiada roli Webinar User.';
   END
END;
go

CREATE PROCEDURE UpdateAccessTimeLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @noDays INT
AS
BEGIN
   UPDATE AccessTimeLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       no_days = @noDays
   WHERE accessTimeLawID = @lawID;
END;
go

CREATE PROCEDURE UpdateDaysOfPracticeLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @noDays INT
AS
BEGIN
   UPDATE DaysOfPracticeLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       no_days = @noDays
   WHERE daysOfPracticeLawID = @lawID;
END;
go

--Procedura modyfikująca zajęcia
   CREATE PROCEDURE UpdateLesson
  @lessonID int,
  @studiesSubjectID int,
  @new_studiesTeacherID int,
  @new_translatorID int = NULL,
  @new_date datetime = NULL,
  @new_description varchar(max) = NULL,
  @new_classroom varchar(max) = NULL,
  @new_attendanceType varchar(max) = NULL,
  @new_type varchar(max) = NULL,
  @new_linkToMeeting varchar(max) = NULL,
  @new_singleLessonPrice money = NULL,
  @new_studentPrice money = NULL,
  @new_maxEnrolls int = NULL
AS
BEGIN
  DECLARE @old_studiesTeacherID int, @old_translatorID int, @old_date datetime, @old_description varchar(max), @old_classroom varchar(max), @old_attendanceType varchar(max), @old_type varchar(max), @old_linkToMeeting varchar(max), @old_singleLessonPrice money, @old_studentPrice money, @old_maxEnrolls int;

  SELECT @old_studiesTeacherID = studiesTeacherID, @old_translatorID = translatorID, @old_date = date, @old_description = description, @old_classroom = classroom, @old_attendanceType = attendanceType, @old_type = type, @old_linkToMeeting = linkToMeeting, @old_singleLessonPrice = singleLessonPrice, @old_studentPrice = studentPrice, @old_maxEnrolls = maxEnrolls
  FROM Lessons
  WHERE lessonID = @lessonID AND studiesSubjectID = @studiesSubjectID;

  UPDATE Lessons
  SET studiesTeacherID = ISNULL(@new_studiesTeacherID, studiesTeacherID),
      translatorID = ISNULL(@new_translatorID, translatorID),
      date = ISNULL(@new_date, date),
      description = ISNULL(@new_description, description),
      classroom = ISNULL(@new_classroom, classroom),
      attendanceType = ISNULL(@new_attendanceType, attendanceType),
      type = ISNULL(@new_type, type),
      linkToMeeting = ISNULL(@new_linkToMeeting, linkToMeeting),
      singleLessonPrice = ISNULL(@new_singleLessonPrice, singleLessonPrice),
      studentPrice = ISNULL(@new_studentPrice, studentPrice),
      maxEnrolls = ISNULL(@new_maxEnrolls, maxEnrolls)
  WHERE lessonID = @lessonID AND studiesSubjectID = @studiesSubjectID;

  INSERT INTO LessonsDataChangeHistory (lessonID, studiesSubjectID, dateOfChange, old_studiesTeacherID, old_translatorID, old_date, old_description, old_classroom, old_attendanceType, old_type, old_linkToMeeting, old_singleLessonPrice, old_studentPrice, old_maxEnrolls, new_studiesTeacherID, new_translatorID, new_date, new_description, new_classroom, new_attendanceType, new_type, new_linkToMeeting, new_singleLessonPrice, new_studentPrice, new_maxEnrolls)
   VALUES (@lessonID, @studiesSubjectID, GETDATE(), @old_studiesTeacherID, @old_translatorID, @old_date, @old_description, @old_classroom, @old_attendanceType, @old_type, @old_linkToMeeting, @old_singleLessonPrice, @old_studentPrice, @old_maxEnrolls, ISNULL(@new_studiesTeacherID, @old_studiesTeacherID), ISNULL(@new_translatorID, @old_translatorID), ISNULL(@new_date, @old_date), ISNULL(@new_description, @old_description), ISNULL(@new_classroom, @old_classroom), ISNULL(@new_attendanceType, @old_attendanceType), ISNULL(@new_type, @old_type), ISNULL(@new_linkToMeeting, @old_linkToMeeting), ISNULL(@new_singleLessonPrice, @old_singleLessonPrice), ISNULL(@new_studentPrice, @old_studentPrice), ISNULL(@new_maxEnrolls, @old_maxEnrolls));

  PRINT 'Lesson data has been successfully updated.';
END;
go

CREATE PROCEDURE UpdateMaxDaysForPayementBeforeCourseLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @noDays INT
AS
BEGIN
   UPDATE MaxDaysForPayementBeforeCourseLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       no_days = @noDays
   WHERE maxDaysForPayementBeforeCourseLawID = @lawID;
END;
go

CREATE PROCEDURE UpdateMaxDaysForPayementBeforeStudiesLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @noDays INT
AS
BEGIN
   UPDATE MaxDaysForPayementBeforeStudiesLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       no_days = @noDays
   WHERE maxDaysForPayementBeforeStudiesLawID = @lawID;
END;
go

CREATE PROCEDURE UpdateMinAttendanceToPassCourseLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @minAttendance INT
 AS
 BEGIN
   UPDATE MinAttendanceToPassCourseLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       min_attendance = @minAttendance
   WHERE minAttendanceToPassCourseLawsID = @lawID;
 END;
go

CREATE PROCEDURE UpdateMinAttendanceToPassPracticeLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @minAttendance INT
 AS
 BEGIN
   UPDATE MinAttendanceToPassPracticeLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       min_attendance = @minAttendance
   WHERE minAttendanceToPassPracticeLawID = @lawID;
 END;
go

CREATE PROCEDURE UpdateMinAttendanceToPassStudiesLaw
   @lawID INT,
   @startDate DATETIME,
   @endDate DATETIME,
   @description TEXT,
   @isTheRecent INT,
   @minAttendance INT
 AS
 BEGIN
   UPDATE MinAttendanceToPassStudiesLaws
   SET startDate = @startDate,
       endDate = @endDate,
       description = @description,
       isTheRecent = @isTheRecent,
       min_attendance = @minAttendance
   WHERE minAttendanceToPassStudiesLawID = @lawID;
 END;
go

-- Procedura modyfikująca obecność
       CREATE PROCEDURE UpdateOutsiderAttendance
  @lessonID int,
  @outsiderID int,
  @wasPresent int,
  @studiesSubjectID int
AS
BEGIN
  UPDATE OutsidersAttendance
  SET wasPresent = @wasPresent
  WHERE lessonID = @lessonID AND outsiderID = @outsiderID AND studiesSubjectID = @studiesSubjectID;

  PRINT 'Attendance record has been successfully updated.';
END;
go

-- Procedura modyfikująca obecność
   CREATE PROCEDURE UpdateStudiesUserAttendance
  @lessonID int,
  @studiesUserID int,
  @wasPresent int,
  @grade int = NULL,
  @studiesSubjectID int
AS
BEGIN
  UPDATE StudiesUserAttendance
  SET wasPresent = @wasPresent, grade = @grade
  WHERE lessonID = @lessonID AND studiesUserID = @studiesUserID AND studiesSubjectID = @studiesSubjectID;

  PRINT 'Attendance record has been successfully updated.';
END;
go

-- Procedura aktualizująca oceny
CREATE PROCEDURE UpdateUserFieldOfStudiesAssignment
   @fieldOfStudiesID int,
   @studiesUserID int,
   @newGrade int,
   @newPassed int
AS
BEGIN
   UPDATE StudiesUserAssignmentToFieldOfStudies
   SET grade = @newGrade, passed = @newPassed
   WHERE fieldOfStudiesID = @fieldOfStudiesID AND studiesUserID = @studiesUserID;
END;
go

-- Procedura aktualizująca oceny
CREATE PROCEDURE UpdateUserStudiesSubjectAssignment
   @studiesSubjectID int,
   @studiesUserID int,
   @newGrade int,
   @newPassed int
AS
BEGIN
   UPDATE StudiesUserAssignmentToStudiesSubject
   SET grade = @newGrade, passed = @newPassed
   WHERE studiesSubjectID = @studiesSubjectID AND studiesUserID = @studiesUserID;
END;
go

CREATE FUNCTION getTotalValFromAllCarts(@userID int)
RETURNS money
AS
BEGIN
   DECLARE @totalVal money;


   SELECT @totalVal = dbo.GetTotalPriceForWebinarUser(@userID)
                    + dbo.GetTotalPriceForCourseUser(@userID)
                    + dbo.GetTotalPriceForStudiesUserForOutsiders(@userID)
                    + dbo.GetTotalPriceForStudiesUserForStudiesUser(@userID);


   RETURN @totalVal;
END
go


