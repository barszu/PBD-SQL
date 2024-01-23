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

    IF (@newTranslatorID IS NOT NULL OR @newWebinarUserID IS NOT NULL OR @newWebinarTeacherID IS NOT NULL OR
        @newCourseUserID IS NOT NULL OR @newCourseTeacherID IS NOT NULL OR @newStudiesUserID IS NOT NULL OR
        @newStudiesTeacherID IS NOT NULL OR @newStudiesOutsiderID IS NOT NULL)
    BEGIN
        RAISERROR ('Nie można zmienić ID na inną wartość niż NULL.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
go
