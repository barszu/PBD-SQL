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
ON WebinarsHistory
AFTER INSERT
AS
BEGIN
   UPDATE WebinarsShoppingItem
   SET hasTookPlace = 1
   WHERE webinarID IN (SELECT webinarID FROM inserted);
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