-- TODO: dobre

    -- Reference: StudiesSubjectHistory_StudiesUserAssignmentToStudiesSubject (table: StudiesUserAssignmentToStudiesSubject)
ALTER TABLE StudiesUserAssignmentToStudiesSubject ADD CONSTRAINT StudiesSubjectHistory_StudiesUserAssignmentToStudiesSubject
    FOREIGN KEY (studiesSubjectID,fieldOfStudiesID)
    REFERENCES StudiesSubjectHistory (studiesSubjectID,fieldOfStudiesID);

-- Reference: StudiesSubject_StudiesUserAssignmentToStudiesSubject (table: StudiesUserAssignmentToStudiesSubject)
ALTER TABLE StudiesUserAssignmentToStudiesSubject ADD CONSTRAINT StudiesSubject_StudiesUserAssignmentToStudiesSubject
    FOREIGN KEY (studiesSubjectID,fieldOfStudiesID)
    REFERENCES StudiesSubject (studiesSubjectID,fieldOfStudiesID);


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-01-14 22:03:21.097

-- foreign keys
-- Reference: AdminSessionHistory_Administrators (table: AdminSessionHistory)
ALTER TABLE AdminSessionHistory ADD CONSTRAINT AdminSessionHistory_Administrators
    FOREIGN KEY (adminID)
    REFERENCES Administrators (adminID);

-- Reference: AdministratorsDataChangeHistory_Administrators (table: AdministratorsDataChangeHistory)
ALTER TABLE AdministratorsDataChangeHistory ADD CONSTRAINT AdministratorsDataChangeHistory_Administrators
    FOREIGN KEY (adminID)
    REFERENCES Administrators (adminID);

-- Reference: Copy_of_CourseModules_CourseModules (table: CourseModulesDataChangeHistory)
ALTER TABLE CourseModulesDataChangeHistory ADD CONSTRAINT Copy_of_CourseModules_CourseModules
    FOREIGN KEY (courseID,moduleID)
    REFERENCES CourseModules (courseID,moduleID);

-- Reference: Copy_of_CourseTeacherDataChangeHistory_Outsiders (table: OutsidersDataChangeHistory)
ALTER TABLE OutsidersDataChangeHistory ADD CONSTRAINT Copy_of_CourseTeacherDataChangeHistory_Outsiders
    FOREIGN KEY (outsiderID)
    REFERENCES Outsiders (outsiderID);

-- Reference: CourseModulePresence_CourseModules (table: CourseModulePresence)
ALTER TABLE CourseModulePresence ADD CONSTRAINT CourseModulePresence_CourseModules
    FOREIGN KEY (courseID,moduleID)
    REFERENCES CourseModules (courseID,moduleID);

-- Reference: CourseModulePresence_CourseUsers (table: CourseModulePresence)
ALTER TABLE CourseModulePresence ADD CONSTRAINT CourseModulePresence_CourseUsers
    FOREIGN KEY (courseUserID)
    REFERENCES CourseUsers (courseUserID);

-- Reference: CourseModules_Courses (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseModules_Courses
    FOREIGN KEY (courseID)
    REFERENCES Courses (courseID);

-- Reference: CourseModules_CoursesHistory (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseModules_CoursesHistory
    FOREIGN KEY (courseID)
    REFERENCES CoursesHistory (courseID);

-- Reference: CourseModules_Translators (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseModules_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: CourseTeacherDataChangeHistory_CourseTeacher (table: CourseTeacherDataChangeHistory)
ALTER TABLE CourseTeacherDataChangeHistory ADD CONSTRAINT CourseTeacherDataChangeHistory_CourseTeacher
    FOREIGN KEY (courseTeacherID)
    REFERENCES CourseTeacher (courseTeacherID);

-- Reference: CourseTeacher_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT CourseTeacher_Users
    FOREIGN KEY (courseTeacherID)
    REFERENCES CourseTeacher (courseTeacherID);

-- Reference: CourseToUserAssignment_CourseUsers (table: CourseToUserAssignment)
ALTER TABLE CourseToUserAssignment ADD CONSTRAINT CourseToUserAssignment_CourseUsers
    FOREIGN KEY (courseUserID)
    REFERENCES CourseUsers (courseUserID);

-- Reference: CourseToUserAssignment_CoursesHistory (table: CourseToUserAssignment)
ALTER TABLE CourseToUserAssignment ADD CONSTRAINT CourseToUserAssignment_CoursesHistory
    FOREIGN KEY (courseID)
    REFERENCES CoursesHistory (courseID);

-- Reference: CourseUsersDataChangeHistory_CourseUsers (table: CourseUsersDataChangeHistory)
ALTER TABLE CourseUsersDataChangeHistory ADD CONSTRAINT CourseUsersDataChangeHistory_CourseUsers
    FOREIGN KEY (courseUserID)
    REFERENCES CourseUsers (courseUserID);

-- Reference: CourseUsers_CoursesShoppingItemHistory (table: CoursesShoppingItemHistory)
ALTER TABLE CoursesShoppingItemHistory ADD CONSTRAINT CourseUsers_CoursesShoppingItemHistory
    FOREIGN KEY (courseUserID)
    REFERENCES CourseUsers (courseUserID);

-- Reference: CourseUsers_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT CourseUsers_Users
    FOREIGN KEY (courseUserID)
    REFERENCES CourseUsers (courseUserID);

-- Reference: CourseWebinarsDataChangeHistory_CourseWebinars (table: CourseWebinarsDataChangeHistory)
ALTER TABLE CourseWebinarsDataChangeHistory ADD CONSTRAINT CourseWebinarsDataChangeHistory_CourseWebinars
    FOREIGN KEY (courseWebinarID)
    REFERENCES CourseWebinars (courseWebinarID);

-- Reference: CourseWebinars_CourseModules (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseWebinars_CourseModules
    FOREIGN KEY (courseWebinarID)
    REFERENCES CourseWebinars (courseWebinarID);

-- Reference: CourseWebinars_Translators (table: CourseWebinars)
ALTER TABLE CourseWebinars ADD CONSTRAINT CourseWebinars_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: CoursesHistory_CourseTeacher (table: CoursesHistory)
ALTER TABLE CoursesHistory ADD CONSTRAINT CoursesHistory_CourseTeacher
    FOREIGN KEY (courseTeacherID)
    REFERENCES CourseTeacher (courseTeacherID);

-- Reference: CoursesShoppingCard_CourseUsers (table: CoursesShoppingItem)
ALTER TABLE CoursesShoppingItem ADD CONSTRAINT CoursesShoppingCard_CourseUsers
    FOREIGN KEY (courseUserID)
    REFERENCES CourseUsers (courseUserID);

-- Reference: CoursesShoppingItemHistory_OrderHistory (table: CoursesShoppingItemHistory)
ALTER TABLE CoursesShoppingItemHistory ADD CONSTRAINT CoursesShoppingItemHistory_OrderHistory
    FOREIGN KEY (mainOrderID)
    REFERENCES OrderHistory (orderID);

-- Reference: Courses_CourseTeacher (table: Courses)
ALTER TABLE Courses ADD CONSTRAINT Courses_CourseTeacher
    FOREIGN KEY (courseTeacherID)
    REFERENCES CourseTeacher (courseTeacherID);

-- Reference: Courses_CourseToUserAssignment (table: CourseToUserAssignment)
ALTER TABLE CourseToUserAssignment ADD CONSTRAINT Courses_CourseToUserAssignment
    FOREIGN KEY (courseID)
    REFERENCES Courses (courseID);

-- Reference: FieldOfStudies_StudiesUserAssignmentToFieldOfStudies (table: StudiesUserAssignmentToFieldOfStudies)
ALTER TABLE StudiesUserAssignmentToFieldOfStudies ADD CONSTRAINT FieldOfStudies_StudiesUserAssignmentToFieldOfStudies
    FOREIGN KEY (fieldOfStudiesID)
    REFERENCES FieldOfStudies (fieldOfStudiesID);

-- Reference: LessonsDataChangeHistory_Lessons (table: LessonsDataChangeHistory)
ALTER TABLE LessonsDataChangeHistory ADD CONSTRAINT LessonsDataChangeHistory_Lessons
    FOREIGN KEY (lessonID,studiesSubjectID)
    REFERENCES Lessons (lessonID,studiesSubjectID);

-- Reference: LessonsDataChangeHistory_LessonsHistory (table: LessonsDataChangeHistory)
ALTER TABLE LessonsDataChangeHistory ADD CONSTRAINT LessonsDataChangeHistory_LessonsHistory
    FOREIGN KEY (lessonID,studiesSubjectID)
    REFERENCES LessonsHistory (lessonID,studiesSubjectID);

-- Reference: LessonsHistory_StudiesSubjectHistory (table: LessonsHistory)
ALTER TABLE LessonsHistory ADD CONSTRAINT LessonsHistory_StudiesSubjectHistory
    FOREIGN KEY (studiesSubjectID,fieldOfStudiesID)
    REFERENCES StudiesSubjectHistory (studiesSubjectID,fieldOfStudiesID);

-- Reference: LessonsHistory_Translators (table: LessonsHistory)
ALTER TABLE LessonsHistory ADD CONSTRAINT LessonsHistory_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: Lessons_StudiesSubject (table: Lessons)
ALTER TABLE Lessons ADD CONSTRAINT Lessons_StudiesSubject
    FOREIGN KEY (studiesSubjectID,fieldOfStudiesID)
    REFERENCES StudiesSubject (studiesSubjectID,fieldOfStudiesID);

-- Reference: Lessons_StudiesSubjectHistory (table: Lessons)
ALTER TABLE Lessons ADD CONSTRAINT Lessons_StudiesSubjectHistory
    FOREIGN KEY (studiesSubjectID,fieldOfStudiesID)
    REFERENCES StudiesSubjectHistory (studiesSubjectID,fieldOfStudiesID);

-- Reference: Lessons_Translators (table: Lessons)
ALTER TABLE Lessons ADD CONSTRAINT Lessons_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: OutsidersAttendance_Lessons (table: OutsidersAttendance)
ALTER TABLE OutsidersAttendance ADD CONSTRAINT OutsidersAttendance_Lessons
    FOREIGN KEY (lessonID,studiesSubjectID)
    REFERENCES Lessons (lessonID,studiesSubjectID);

-- Reference: OutsidersAttendance_Outsiders (table: OutsidersAttendance)
ALTER TABLE OutsidersAttendance ADD CONSTRAINT OutsidersAttendance_Outsiders
    FOREIGN KEY (outsiderID)
    REFERENCES Outsiders (outsiderID);

-- Reference: Outsiders_StudiesShoppingItemForOutsiders (table: StudiesShoppingItemForOutsiders)
ALTER TABLE StudiesShoppingItemForOutsiders ADD CONSTRAINT Outsiders_StudiesShoppingItemForOutsiders
    FOREIGN KEY (studiesUserID)
    REFERENCES Outsiders (outsiderID);

-- Reference: Outsiders_StudiesShoppingItemForOutsidersHistory (table: StudiesShoppingItemForOutsidersHistory)
ALTER TABLE StudiesShoppingItemForOutsidersHistory ADD CONSTRAINT Outsiders_StudiesShoppingItemForOutsidersHistory
    FOREIGN KEY (studiesUserID)
    REFERENCES Outsiders (outsiderID);

-- Reference: Outsiders_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT Outsiders_Users
    FOREIGN KEY (studiesOutsiderID)
    REFERENCES Outsiders (outsiderID);

-- Reference: StudiesShoppingItemForOutsidersHistory_OrderHistory (table: StudiesShoppingItemForOutsidersHistory)
ALTER TABLE StudiesShoppingItemForOutsidersHistory ADD CONSTRAINT StudiesShoppingItemForOutsidersHistory_OrderHistory
    FOREIGN KEY (mainOrderID)
    REFERENCES OrderHistory (orderID);

-- Reference: StudiesShoppingItemForStudiesUserHistory_OrderHistory (table: StudiesShoppingItemForStudiesUserHistory)
ALTER TABLE StudiesShoppingItemForStudiesUserHistory ADD CONSTRAINT StudiesShoppingItemForStudiesUserHistory_OrderHistory
    FOREIGN KEY (mainOrderID)
    REFERENCES OrderHistory (orderID);

-- Reference: StudiesSubjectHistory_FieldOfStudies (table: StudiesSubjectHistory)
ALTER TABLE StudiesSubjectHistory ADD CONSTRAINT StudiesSubjectHistory_FieldOfStudies
    FOREIGN KEY (fieldOfStudiesID)
    REFERENCES FieldOfStudies (fieldOfStudiesID);

-- Reference: StudiesSubjectHistory_FieldOfStudiesHistory (table: StudiesSubjectHistory)
ALTER TABLE StudiesSubjectHistory ADD CONSTRAINT StudiesSubjectHistory_FieldOfStudiesHistory
    FOREIGN KEY (fieldOfStudiesID)
    REFERENCES FieldOfStudiesHistory (fieldOfStudiesID);

-- Reference: StudiesSubjectHistory_StudiesTeacher (table: StudiesSubjectHistory)
ALTER TABLE StudiesSubjectHistory ADD CONSTRAINT StudiesSubjectHistory_StudiesTeacher
    FOREIGN KEY (mainCoordinatorID)
    REFERENCES StudiesTeacher (studiesTeacherID);

-- Reference: StudiesSubject_FieldOfStudies (table: StudiesSubject)
ALTER TABLE StudiesSubject ADD CONSTRAINT StudiesSubject_FieldOfStudies
    FOREIGN KEY (fieldOfStudiesID)
    REFERENCES FieldOfStudies (fieldOfStudiesID);

-- Reference: StudiesSubject_FieldOfStudiesHistory (table: StudiesSubject)
ALTER TABLE StudiesSubject ADD CONSTRAINT StudiesSubject_FieldOfStudiesHistory
    FOREIGN KEY (fieldOfStudiesID)
    REFERENCES FieldOfStudiesHistory (fieldOfStudiesID);

-- Reference: StudiesSubject_StudiesTeacher (table: StudiesSubject)
ALTER TABLE StudiesSubject ADD CONSTRAINT StudiesSubject_StudiesTeacher
    FOREIGN KEY (mainCoordinatorID)
    REFERENCES StudiesTeacher (studiesTeacherID);

-- Reference: StudiesTeacherDataChangeHistory_StudiesTeacher (table: StudiesTeacherDataChangeHistory)
ALTER TABLE StudiesTeacherDataChangeHistory ADD CONSTRAINT StudiesTeacherDataChangeHistory_StudiesTeacher
    FOREIGN KEY (studiesTeacherID)
    REFERENCES StudiesTeacher (studiesTeacherID);

-- Reference: StudiesTeacher_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT StudiesTeacher_Users
    FOREIGN KEY (studiesTeacherID)
    REFERENCES StudiesTeacher (studiesTeacherID);

-- Reference: StudiesUserAssignmentToFieldOfStudies_FieldOfStudiesHistory (table: StudiesUserAssignmentToFieldOfStudies)
ALTER TABLE StudiesUserAssignmentToFieldOfStudies ADD CONSTRAINT StudiesUserAssignmentToFieldOfStudies_FieldOfStudiesHistory
    FOREIGN KEY (fieldOfStudiesID)
    REFERENCES FieldOfStudiesHistory (fieldOfStudiesID);

-- Reference: StudiesUserAssignmentToFieldOfStudies_StudiesUser (table: StudiesUserAssignmentToFieldOfStudies)
ALTER TABLE StudiesUserAssignmentToFieldOfStudies ADD CONSTRAINT StudiesUserAssignmentToFieldOfStudies_StudiesUser
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: StudiesUserAssignmentToStudiesSubject_StudiesUser (table: StudiesUserAssignmentToStudiesSubject)
ALTER TABLE StudiesUserAssignmentToStudiesSubject ADD CONSTRAINT StudiesUserAssignmentToStudiesSubject_StudiesUser
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: StudiesUserAttendance_Lessons (table: StudiesUserAttendance)
ALTER TABLE StudiesUserAttendance ADD CONSTRAINT StudiesUserAttendance_Lessons
    FOREIGN KEY (lessonID,studiesSubjectID)
    REFERENCES Lessons (lessonID,studiesSubjectID);

-- Reference: StudiesUserAttendance_StudiesUser (table: StudiesUserAttendance)
ALTER TABLE StudiesUserAttendance ADD CONSTRAINT StudiesUserAttendance_StudiesUser
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: StudiesUserDataChangeHistory_StudiesUser (table: StudiesUserDataChangeHistory)
ALTER TABLE StudiesUserDataChangeHistory ADD CONSTRAINT StudiesUserDataChangeHistory_StudiesUser
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: StudiesUser_StudiesShoppingItem (table: StudiesShoppingItemForStudiesUser)
ALTER TABLE StudiesShoppingItemForStudiesUser ADD CONSTRAINT StudiesUser_StudiesShoppingItem
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: StudiesUser_StudiesShoppingItemForStudiesUserHistory (table: StudiesShoppingItemForStudiesUserHistory)
ALTER TABLE StudiesShoppingItemForStudiesUserHistory ADD CONSTRAINT StudiesUser_StudiesShoppingItemForStudiesUserHistory
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: StudiesUser_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT StudiesUser_Users
    FOREIGN KEY (studiesUserID)
    REFERENCES StudiesUser (studiesUserID);

-- Reference: TranslatorsDataChangeHistory_Translators (table: TranslatorsDataChangeHistory)
ALTER TABLE TranslatorsDataChangeHistory ADD CONSTRAINT TranslatorsDataChangeHistory_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: UsersDataChangeHistory_Users (table: UsersDataChangeHistory)
ALTER TABLE UsersDataChangeHistory ADD CONSTRAINT UsersDataChangeHistory_Users
    FOREIGN KEY (userID)
    REFERENCES Users (userID);

-- Reference: Users_OrderHistory (table: OrderHistory)
ALTER TABLE OrderHistory ADD CONSTRAINT Users_OrderHistory
    FOREIGN KEY (userID)
    REFERENCES Users (userID);

-- Reference: Users_Translators (table: Users)
ALTER TABLE Users ADD CONSTRAINT Users_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: Users_UserSessionHistory (table: UserSessionHistory)
ALTER TABLE UserSessionHistory ADD CONSTRAINT Users_UserSessionHistory
    FOREIGN KEY (userID)
    REFERENCES Users (userID);

-- Reference: WebinarTeacherDataChangeHistory_WebinarTeacher (table: WebinarTeacherDataChangeHistory)
ALTER TABLE WebinarTeacherDataChangeHistory ADD CONSTRAINT WebinarTeacherDataChangeHistory_WebinarTeacher
    FOREIGN KEY (webinarTeacherID)
    REFERENCES WebinarTeacher (webinarTeacherID);

-- Reference: WebinarTeacherDataChangeHistory_WebinarUsers (table: WebinarUsersDataChangeHistory)
ALTER TABLE WebinarUsersDataChangeHistory ADD CONSTRAINT WebinarTeacherDataChangeHistory_WebinarUsers
    FOREIGN KEY (webinarUserID)
    REFERENCES WebinarUsers (webinarUserID);

-- Reference: WebinarTeacher_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT WebinarTeacher_Users
    FOREIGN KEY (webinarTeacherID)
    REFERENCES WebinarTeacher (webinarTeacherID);

-- Reference: WebinarUsers_Users (table: Users)
ALTER TABLE Users ADD CONSTRAINT WebinarUsers_Users
    FOREIGN KEY (webinarUserID)
    REFERENCES WebinarUsers (webinarUserID);

-- Reference: WebinarUsers_WebinarsShoppingItemHistory (table: WebinarsShoppingItemHistory)
ALTER TABLE WebinarsShoppingItemHistory ADD CONSTRAINT WebinarUsers_WebinarsShoppingItemHistory
    FOREIGN KEY (webinarUserID)
    REFERENCES WebinarUsers (webinarUserID);

-- Reference: WebinarsDataChangeHistory_Webinars (table: WebinarsDataChangeHistory)
ALTER TABLE WebinarsDataChangeHistory ADD CONSTRAINT WebinarsDataChangeHistory_Webinars
    FOREIGN KEY (webinarID)
    REFERENCES Webinars (webinarID);

-- Reference: WebinarsDataChangeHistory_WebinarsHistory (table: WebinarsDataChangeHistory)
ALTER TABLE WebinarsDataChangeHistory ADD CONSTRAINT WebinarsDataChangeHistory_WebinarsHistory
    FOREIGN KEY (webinarID)
    REFERENCES WebinarsHistory (webinarID);

-- Reference: WebinarsHistory_Translators (table: WebinarsHistory)
ALTER TABLE WebinarsHistory ADD CONSTRAINT WebinarsHistory_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: WebinarsHistory_WebinarTeacher (table: WebinarsHistory)
ALTER TABLE WebinarsHistory ADD CONSTRAINT WebinarsHistory_WebinarTeacher
    FOREIGN KEY (webinarTeacherID)
    REFERENCES WebinarTeacher (webinarTeacherID);

-- Reference: WebinarsShoppingCard_WebinarUsers (table: WebinarsShoppingItem)
ALTER TABLE WebinarsShoppingItem ADD CONSTRAINT WebinarsShoppingCard_WebinarUsers
    FOREIGN KEY (webinarUserID)
    REFERENCES WebinarUsers (webinarUserID);

-- Reference: WebinarsShoppingItemHistory_OrderHistory (table: WebinarsShoppingItemHistory)
ALTER TABLE WebinarsShoppingItemHistory ADD CONSTRAINT WebinarsShoppingItemHistory_OrderHistory
    FOREIGN KEY (mainOrderID)
    REFERENCES OrderHistory (orderID);

-- Reference: WebinarsToUserAssignment_WebinarUsers (table: WebinarsToUserAssignment)
ALTER TABLE WebinarsToUserAssignment ADD CONSTRAINT WebinarsToUserAssignment_WebinarUsers
    FOREIGN KEY (webinarUserID)
    REFERENCES WebinarUsers (webinarUserID);

-- Reference: WebinarsToUserAssignment_Webinars (table: WebinarsToUserAssignment)
ALTER TABLE WebinarsToUserAssignment ADD CONSTRAINT WebinarsToUserAssignment_Webinars
    FOREIGN KEY (webinarID)
    REFERENCES Webinars (webinarID);

-- Reference: WebinarsToUserAssignment_WebinarsHistory (table: WebinarsToUserAssignment)
ALTER TABLE WebinarsToUserAssignment ADD CONSTRAINT WebinarsToUserAssignment_WebinarsHistory
    FOREIGN KEY (webinarID)
    REFERENCES WebinarsHistory (webinarID);

-- Reference: Webinars_Translators (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Webinars_Translators
    FOREIGN KEY (translatorID)
    REFERENCES Translators (translatorID);

-- Reference: Webinars_WebinarTeacher (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Webinars_WebinarTeacher
    FOREIGN KEY (webinarTeacherID)
    REFERENCES WebinarTeacher (webinarTeacherID);
