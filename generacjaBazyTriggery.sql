CREATE TRIGGER SetIsPayedAfterWebinarsToUserAssignmentUpdate
ON WebinarsToUserAssignment
AFTER UPDATE
AS
BEGIN
    IF UPDATE(toPay)
    BEGIN
        UPDATE WebinarsShoppingItem
        SET isPayed = 1
        FROM WebinarsShoppingItem WSI
        INNER JOIN inserted I ON WSI.webinarUserID = I.webinarUserID AND WSI.webinarID = I.webinarID
        WHERE I.toPay = 0;
    END
END;
    go

CREATE TRIGGER SetIsPayedAfterWebinarsToUserAssignmentUpdateHistory
ON WebinarsToUserAssignment
AFTER UPDATE
AS
BEGIN
    IF UPDATE(toPay)
    BEGIN
        UPDATE WebinarsShoppingItemHistory
        SET isPayed = 1
        FROM WebinarsShoppingItemHistory WSIH
        INNER JOIN inserted I ON WSIH.webinarUserID = I.webinarUserID AND WSIH.webinarID = I.webinarID
        WHERE I.toPay = 0;
    END
END;
    go

create trigger UpdateToPayAndPayed
on OrderHistory
after update
as
begin
    declare @userID int;
    declare @details varchar(30);
    declare @totalValue money;
    declare @paymentStatus varchar(30);

    if @paymentStatus = 'success'
    BEGIN
        IF LEFT(@details, 1) = 'C'
        BEGIN
            UPDATE cua
            SET
                toPay = toPay - @totalValue,
                payed = payed + @totalValue
            FROM CourseToUserAssignment cua
            INNER JOIN CoursesShoppingItemHistory csih ON cua.courseUserID = csih.courseUserID AND cua.courseID = csih.courseID
            INNER JOIN OrderHistory oh ON csih.mainOrderID = oh.orderID
            WHERE cua.courseUserID = @userID;
        END
        ELSE IF LEFT(@details, 1) = 'W'
        BEGIN
            UPDATE wua
            SET
                toPay = toPay - @totalValue,
                payed = payed + @totalValue
            FROM WebinarsToUserAssignment wua
            INNER JOIN WebinarsShoppingItemHistory wsih ON wua.webinarUserID = wsih.webinarUserID AND wua.webinarID = wsih.webinarID
            INNER JOIN OrderHistory oh ON wsih.mainOrderID = oh.orderID
            WHERE wua.webinarUserID = @userID;
        END
    END
end
go

CREATE TRIGGER UpdateHasTookPlace
ON Webinars
AFTER UPDATE
AS
BEGIN
    IF UPDATE(isAvailable)
    BEGIN
        UPDATE WebinarsShoppingItem
        SET hasTookPlace = 1
        FROM WebinarsShoppingItem WSI
        INNER JOIN inserted I ON WSI.webinarID = I.webinarID
        WHERE I.isAvailable = 1;
    END
END;
go


CREATE TRIGGER UpdateAccessAfterLogin
ON UserSessionHistory
AFTER INSERT
AS
BEGIN
   DECLARE @recentAccessTimeLaw int;
   DECLARE @userID int;


   SELECT @userID = userID FROM inserted;


   SELECT @recentAccessTimeLaw = no_days
   FROM AccessTimeLaws
   WHERE isTheRecent = 1;


   UPDATE WebinarsToUserAssignment
   SET haveAccess = 0
   WHERE webinarUserID = @userID AND DATEDIFF(day, accessGainedDate, GETDATE()) > @recentAccessTimeLaw;
END;
go


    
CREATE TRIGGER trg_PreventIDChangeInsert
ON Users
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @oldTranslatorID int, @newTranslatorID int,
            @oldWebinarUserID int, @newWebinarUserID int,
            @oldWebinarTeacherID int, @newWebinarTeacherID int,
            @oldCourseUserID int, @newCourseUserID int,
            @oldCourseTeacherID int, @newCourseTeacherID int,
            @oldStudiesUserID int, @newStudiesUserID int,
            @oldStudiesTeacherID int, @newStudiesTeacherID int,
            @oldStudiesOutsiderID int, @newStudiesOutsiderID int;

    SELECT @oldTranslatorID = translatorID, @oldWebinarUserID = webinarUserID, @oldWebinarTeacherID = webinarTeacherID,
           @oldCourseUserID = courseUserID, @oldCourseTeacherID = courseTeacherID, @oldStudiesUserID = studiesUserID,
           @oldStudiesTeacherID = studiesTeacherID, @oldStudiesOutsiderID = studiesOutsiderID
    FROM deleted;

    SELECT @newTranslatorID = translatorID, @newWebinarUserID = webinarUserID, @newWebinarTeacherID = webinarTeacherID,
           @newCourseUserID = courseUserID, @newCourseTeacherID = courseTeacherID, @newStudiesUserID = studiesUserID,
           @newStudiesTeacherID = studiesTeacherID, @newStudiesOutsiderID = studiesOutsiderID
    FROM inserted;

    IF ((@oldTranslatorID IS NOT NULL AND @newTranslatorID IS NOT NULL AND @oldTranslatorID != @newTranslatorID) OR
    (@oldWebinarUserID IS NOT NULL AND @newWebinarUserID IS NOT NULL AND @oldWebinarUserID != @newWebinarUserID) OR
    (@oldWebinarTeacherID IS NOT NULL AND @newWebinarTeacherID IS NOT NULL AND @oldWebinarTeacherID != @newWebinarTeacherID) OR
    (@oldCourseUserID IS NOT NULL AND @newCourseUserID IS NOT NULL AND @oldCourseUserID != @newCourseUserID) OR
    (@oldCourseTeacherID IS NOT NULL AND @newCourseTeacherID IS NOT NULL AND @oldCourseTeacherID != @newCourseTeacherID) OR
    (@oldStudiesUserID IS NOT NULL AND @newStudiesUserID IS NOT NULL AND @oldStudiesUserID != @newStudiesUserID) OR
    (@oldStudiesTeacherID IS NOT NULL AND @newStudiesTeacherID IS NOT NULL AND @oldStudiesTeacherID != @newStudiesTeacherID) OR
    (@oldStudiesOutsiderID IS NOT NULL AND @newStudiesOutsiderID IS NOT NULL AND @oldStudiesOutsiderID != @newStudiesOutsiderID))
    BEGIN
        RAISERROR ('Nie można zmienić ID na inną wartość niż NULL.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
go

-- Trigger dla tabeli WebinarsToUserAssignment
CREATE TRIGGER trg_CheckWebinarAssignment
ON WebinarsToUserAssignment
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i JOIN WebinarsToUserAssignment w ON i.webinarID = w.webinarID AND i.webinarUserID = w.webinarUserID)
    BEGIN
        RAISERROR ('Użytkownik jest już przypisany do tego webinaru.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
go

-- Trigger dla tabeli CourseToUserAssignment
CREATE TRIGGER trg_CheckCourseAssignment
ON CourseToUserAssignment
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i JOIN CourseToUserAssignment c ON i.courseID = c.courseID AND i.courseUserID = c.courseUserID)
    BEGIN
        RAISERROR ('Użytkownik jest już przypisany do tego kursu.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
go

-- Trigger dla tabeli StudiesUserAssignmentToFieldOfStudies
CREATE TRIGGER trg_CheckStudiesAssignment
ON StudiesUserAssignmentToFieldOfStudies
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i JOIN StudiesUserAssignmentToFieldOfStudies s ON i.studiesUserID = s.studiesUserID AND i.fieldOfStudiesID = s.fieldOfStudiesID)
    BEGIN
        RAISERROR ('Użytkownik jest już przypisany do tych studiów.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
go

-- Trigger dla tabeli StudiesUserAssignmentToStudiesSubject
CREATE TRIGGER trg_CheckSubjectAssignment
ON StudiesUserAssignmentToStudiesSubject
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i JOIN StudiesUserAssignmentToStudiesSubject s ON i.studiesUserID = s.studiesUserID AND i.studiesSubjectID = s.studiesSubjectID)
    BEGIN
        RAISERROR ('Użytkownik jest już przypisany do tego przedmiotu.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
go
