USE u_szubiak
-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-01-14 22:03:21.097


    -- Table: StudiesUserAssignmentToStudiesSubject
CREATE TABLE StudiesUserAssignmentToStudiesSubject (
    studiesUserID int  NOT NULL ,
    studiesSubjectID int  NOT NULL,
    passed int  NOT NULL CHECK (passed = 0 OR passed = 1),
    grade int  NOT NULL CHECK (grade <= 6 AND grade >=1),
    fieldOfStudiesID int  NOT NULL,
    CONSTRAINT StudiesUserAssignmentToStudiesSubject_pk PRIMARY KEY  (studiesUserID,studiesSubjectID)
);

-- tables
-- Table: AccessTimeLaws
CREATE TABLE AccessTimeLaws (
    accessTimeLawID int          NOT NULL IDENTITY(1,1),
    startDate       datetime     NOT NULL,
    endDate         datetime     NULL,
    description     varchar(max) NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent     int          NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    no_days         int          NOT NULL CHECK (no_days >=0),
    CONSTRAINT AccessTimeLaws_pk PRIMARY KEY  (accessTimeLawID)
);

-- Table: AdminSessionHistory
CREATE TABLE AdminSessionHistory (
    sessionId int  NOT NULL IDENTITY(1,1),
    adminID int  NOT NULL,
    startedDate datetime  NOT NULL,
    CONSTRAINT AdminSessionHistory_pk PRIMARY KEY  (sessionId,adminID)
);

-- Table: Administrators
CREATE TABLE Administrators (
    adminID         int          NOT NULL IDENTITY(1,1),
    accessLvl       int          NOT NULL CHECK (accessLvl = 1 OR accessLvl = 2),
    firstname       varchar(max) NOT NULL CHECK (LEN(firstname)<=25),
    lastname        varchar(max) NOT NULL CHECK (LEN(lastname)<=25),
    title           varchar(max) NULL CHECK (LEN(title) <= 10),
    email           varchar(max)         NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    phone           varchar(max)         NOT NULL CHECK (LEN(phone)=9),
    encodedPassword varchar(max)         NOT NULL,
    address         varchar(max)         NOT NULL,
    postalcode      varchar(max) NOT NULL CHECK (postalcode LIKE '__-___'),
    CONSTRAINT Administrators_pk PRIMARY KEY  (adminID)
);

-- Table: AdministratorsDataChangeHistory
CREATE TABLE AdministratorsDataChangeHistory (
    adminID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_accessLvl int  NOT NULL CHECK (old_accessLvl = 1 OR old_accessLvl = 2),
    old_firstname varchar(max)  NOT NULL CHECK (LEN(old_firstname)<=25),
    old_lastname varchar(max)  NOT NULL CHECK (LEN(old_lastname)<=25),
    old_title varchar(max)  NULL CHECK (LEN(old_title) <= 10),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    old_phone varchar(max)  NOT NULL CHECK (LEN(old_phone)=9),
    old_encodedPassword varchar(max)  NOT NULL,
    old_address varchar(max)  NOT NULL,
    old_postalcode varchar(max)  NOT NULL CHECK (old_postalcode LIKE '__-___'),
    new_accessLvl int  NOT NULL CHECK (new_accessLvl = 1 OR new_accessLvl = 2),
    new_firstname varchar(max)  NOT NULL CHECK (LEN(new_firstname)<=25),
    new_lastname varchar(max)  NOT NULL CHECK (LEN(new_lastname)<=25),
    new_title varchar(max)  NULL CHECK (LEN(new_title) <= 10),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    new_phone varchar(max)  NOT NULL CHECK (LEN(new_phone)=9),
    new_encodedPassword varchar(max)  NOT NULL,
    new_address varchar(max)  NOT NULL,
    new_postalcode varchar(max)  NOT NULL CHECK (new_postalcode LIKE '__-___'),
    CONSTRAINT AdministratorsDataChangeHistory_pk PRIMARY KEY  (adminID,dateOfChange)
);

-- Table: CourseModulePresence
CREATE TABLE CourseModulePresence (
    courseUserID int  NOT NULL,
    moduleID int  NOT NULL,
    courseID int  NOT NULL,
    havePassed int  NOT NULL CHECK (havePassed = 0 OR havePassed =1),
    wasPresent int  NOT NULL CHECK (wasPresent = 0 OR wasPresent =1),
    watchedRecord int  NULL CHECK (watchedRecord = 0 OR watchedRecord =1),
    CONSTRAINT CourseModulePresence_pk PRIMARY KEY  (courseUserID,moduleID,courseID)
);

-- Table: CourseModules
CREATE TABLE CourseModules (
    courseID int  NOT NULL,
    moduleID int  NOT NULL IDENTITY(1,1),
    date datetime  NOT NULL,
    courseWebinarID int  NOT NULL,
    translatorID int  NULL,
    attendanceType varchar(max)  NOT NULL,
    name varchar(max)  NOT NULL CHECK (LEN(name)<=25),
    type varchar(max)  NOT NULL CHECK (LEN(type) <= 25),
    classroom varchar(max)  NOT NULL,
    linkToRecord varchar(max)  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    hasTookPlace int  NOT NULL CHECK (hasTookPlace = 0 OR hasTookPlace = 1),
    CONSTRAINT CourseModules_pk PRIMARY KEY  (courseID,moduleID)
);

-- Table: CourseModulesDataChangeHistory
CREATE TABLE CourseModulesDataChangeHistory (
    courseID int  NOT NULL,
    moduleID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_courseWebinarID int  NOT NULL,
    old_translatorID int  NULL,
    old_attendanceType varchar(max)  NOT NULL,
    old_name varchar(max)  NOT NULL CHECK (LEN(old_name)<=25),
    old_type varchar(max)  NOT NULL,
    old_classroom varchar(max)  NOT NULL,
    old_linktToRecord varchar(max)  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    new_courseWebinarID int  NOT NULL,
    new_translatorID int  NOT NULL,
    new_attendanceType varchar(max)  NOT NULL,
    new_name varchar(max)  NOT NULL CHECK (LEN(new_name)<=25),
    new_type varchar(max)  NOT NULL,
    new_classroom varchar(max)  NOT NULL,
    new_linkToRecord varchar(max)  NOT NULL,
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    CONSTRAINT CourseModulesDataChangeHistory_pk PRIMARY KEY  (courseID,moduleID,dateOfChange)
);

-- Table: CourseTeacher
CREATE TABLE CourseTeacher (
    courseTeacherID int  NOT NULL IDENTITY(1,1),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT CourseTeacher_pk PRIMARY KEY  (courseTeacherID)
);

-- Table: CourseTeacherDataChangeHistory
CREATE TABLE CourseTeacherDataChangeHistory (
    courseTeacherID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    CONSTRAINT CourseTeacherDataChangeHistory_pk PRIMARY KEY  (courseTeacherID,dateOfChange)
);

-- Table: CourseToUserAssignment
CREATE TABLE CourseToUserAssignment (
    courseUserID int  NOT NULL,
    courseID int  NOT NULL,
    grade int  NOT NULL CHECK (grade <= 6 AND grade >=1),
    passed int  NOT NULL CHECK (passed = 0 OR passed = 1),
    toPay money  NOT NULL,
    payed money  NOT NULL,
    accesGainedDate datetime  NOT NULL,
    haveAccess int  NOT NULL CHECK (haveAccess = 0 OR haveAccess = 1),
    CONSTRAINT CourseToUserAssignment_pk PRIMARY KEY  (courseUserID,courseID)
);

-- Table: CourseUsers
CREATE TABLE CourseUsers (
    courseUserID int  NOT NULL IDENTITY(1,1),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT CourseUsers_pk PRIMARY KEY  (courseUserID)
);

-- Table: CourseUsersDataChangeHistory
CREATE TABLE CourseUsersDataChangeHistory (
    courseUserID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    CONSTRAINT CourseUsersDataChangeHistory_pk PRIMARY KEY  (courseUserID,dateOfChange)
);

-- Table: CourseWebinars
CREATE TABLE CourseWebinars (
    courseWebinarID int  NOT NULL IDENTITY(1,1),
    courseTeacherID int  NOT NULL,
    translatorID int  NULL,
    date datetime  NOT NULL,
    linkToMeet varchar(max)  NULL,
    classroom varchar(max)  NOT NULL,
    linkToRecord varchar(max)  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    CONSTRAINT CourseWebinars_pk PRIMARY KEY  (courseWebinarID)
);

-- Table: CourseWebinarsDataChangeHistory
CREATE TABLE CourseWebinarsDataChangeHistory (
    courseWebinarID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_courseTeacherID int  NOT NULL,
    old_translatorID int  NULL,
    old_date datetime  NOT NULL,
    old_linkToMeet varchar(max)  NULL,
    old_classroom varchar(max)  NOT NULL,
    old_linkToRecord varchar(max)  NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    new_courseTeacherID int  NOT NULL,
    new_translatorID int  NOT NULL,
    new_date datetime  NOT NULL,
    new_linkToMeet varchar(max)  NOT NULL,
    new_classroom varchar(max)  NOT NULL,
    new_linkToRecord varchar(max)  NOT NULL,
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    CONSTRAINT CourseWebinarsDataChangeHistory_pk PRIMARY KEY  (courseWebinarID,dateOfChange)
);

-- Table: Courses
CREATE TABLE Courses (
    courseID int  NOT NULL IDENTITY(1,1),
    courseTeacherID int  NOT NULL,
    date datetime  NOT NULL,
    price money  NOT NULL,
    currEnrolls int  NOT NULL,
    maxEnrolls int  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    CONSTRAINT Courses_pk PRIMARY KEY  (courseID),
    CONSTRAINT enrolls CHECK (currEnrolls <= maxEnrolls)
);

-- Table: CoursesHistory
CREATE TABLE CoursesHistory (
    courseID int  NOT NULL,
    courseTeacherID int  NOT NULL,
    date datetime  NOT NULL,
    price money  NOT NULL,
    enrolls int  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    CONSTRAINT CoursesHistory_pk PRIMARY KEY  (courseID)
);

-- Table: CoursesShoppingItem
CREATE TABLE CoursesShoppingItem (
    courseID int  NOT NULL,
    courseUserID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    hasTookPlace int  NOT NULL CHECK (hasTookPlace = 0 OR hasTookPlace = 1),
    CONSTRAINT CoursesShoppingItem_pk PRIMARY KEY  (courseID,courseUserID)
);

-- Table: CoursesShoppingItemHistory
CREATE TABLE CoursesShoppingItemHistory (
    mainOrderID int  NOT NULL,
    courseID int  NOT NULL,
    courseUserID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    hasTookPlace int  NOT NULL CHECK (hasTookPlace = 0 OR hasTookPlace = 1),
    CONSTRAINT CoursesShoppingItemHistory_pk PRIMARY KEY  (courseID,courseUserID)
);

-- Table: DaysOfPracticeLaws
CREATE TABLE DaysOfPracticeLaws (
    daysOfPracticeLawID int  NOT NULL IDENTITY(1,1),
    startDate datetime  NOT NULL,
    endDate datetime  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent int  NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    no_days int  NOT NULL CHECK (no_days>=0),
    CONSTRAINT DaysOfPracticeLaws_pk PRIMARY KEY  (daysOfPracticeLawID)
);

-- Table: FieldOfStudies
CREATE TABLE FieldOfStudies (
    fieldOfStudiesID int  NOT NULL IDENTITY(1,1),
    name varchar(max)  NOT NULL CHECK (LEN(name)<=25),
    type varchar(max)  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    practises varchar(max)  NOT NULL CHECK (LEN(practises) <= 100),
    maxEnrolls int  NOT NULL,
    currEnrolls int  NOT NULL,
    startDate date  NOT NULL,
    entryFee money, --tutaj wpisowe
    isAvailible int  NOT NULL CHECK (isAvailible = 0 OR isAvailible = 1),
    CONSTRAINT enrolls_2 CHECK (currEnrolls <= maxEnrolls),
    CONSTRAINT FieldOfStudies_pk PRIMARY KEY  (fieldOfStudiesID)
);

-- Table: FieldOfStudiesHistory
CREATE TABLE FieldOfStudiesHistory (
    fieldOfStudiesID int  NOT NULL,
    name varchar(max)  NOT NULL,
    type varchar(max)  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    practises varchar(max)  NOT NULL CHECK (LEN(practises)<=100),
    startDate date  NOT NULL,
    enrolls int  NOT NULL,
    entryFee money, --tutaj wpisowe
    CONSTRAINT FieldOfStudiesHistory_pk PRIMARY KEY  (fieldOfStudiesID)
);

-- Table: Lessons
CREATE TABLE Lessons (
    lessonID int  NOT NULL IDENTITY(1,1),
    studiesSubjectID int  NOT NULL,
    studiesTeacherID int  NOT NULL,
    translatorID int  NULL,
    date datetime  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    classroom varchar(max)  NOT NULL,
    attendanceType varchar(max)  NOT NULL,
    type varchar(max)  NOT NULL,
    linkToMeeting varchar(max)  NOT NULL,
    singleLessonPrice money  NOT NULL,
    studentPrice money  NOT NULL,
    maxEnrolls int  NOT NULL,
    currEnrolls int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    tookPlace int  NOT NULL,
    CONSTRAINT enrolls_3 CHECK (currEnrolls <= maxEnrolls),
    CONSTRAINT Lessons_pk PRIMARY KEY  (lessonID,studiesSubjectID)
);

-- Table: LessonsDataChangeHistory
CREATE TABLE LessonsDataChangeHistory (
    lessonID int  NOT NULL,
    studiesSubjectID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_studiesTeacherID int  NOT NULL,
    old_translatorID int  NULL,
    old_date datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_classroom varchar(max)  NOT NULL,
    old_attendanceType varchar(max)  NOT NULL,
    old_type varchar(max)  NOT NULL,
    old_linkToMeeting varchar(max)  NOT NULL,
    old_singleLessonPrice money  NOT NULL,
    old_studentPrice money  NOT NULL,
    old_maxEnrolls int  NOT NULL,
    new_studiesTeacherID int  NOT NULL,
    new_translatorID int  NOT NULL,
    new_date datetime  NOT NULL,
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_classroom varchar(max)  NOT NULL,
    new_attendanceType varchar(max)  NOT NULL,
    new_type varchar(max)  NOT NULL,
    new_linkToMeeting varchar(max)  NOT NULL,
    new_singleLessonPrice money  NOT NULL,
    new_studentPrice money  NOT NULL,
    new_maxEnrolls int  NOT NULL,
    CONSTRAINT LessonsDataChangeHistory_pk PRIMARY KEY  (lessonID,studiesSubjectID,dateOfChange)
);

-- Table: LessonsHistory
CREATE TABLE LessonsHistory (
    lessonID int  NOT NULL,
    studiesSubjectID int  NOT NULL,
    studiesTeacherID int  NOT NULL,
    translatorID int  NULL,
    date datetime  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    classroom varchar(max)  NOT NULL,
    attendanceType varchar(max)  NOT NULL,
    type varchar(max)  NOT NULL,
    linkToMeeting varchar(max)  NOT NULL,
    singleLessonPrice money  NOT NULL,
    studentPrice money  NOT NULL,
    enrolls int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    CONSTRAINT LessonsHistory_pk PRIMARY KEY  (lessonID,studiesSubjectID)
);

-- Table: MaxDaysForPayementBeforeCourseLaws
CREATE TABLE MaxDaysForPayementBeforeCourseLaws (
    maxDaysForPayementBeforeCourseLawID int  NOT NULL IDENTITY(1,1),
    startDate datetime  NOT NULL,
    endDate datetime  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent int  NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    no_days int  NOT NULL CHECK (no_days >=0),
    CONSTRAINT MaxDaysForPayementBeforeCourseLaws_pk PRIMARY KEY  (maxDaysForPayementBeforeCourseLawID)
);

-- Table: MaxDaysForPayementBeforeStudiesLaws
CREATE TABLE MaxDaysForPayementBeforeStudiesLaws (
    maxDaysForPayementBeforeStudiesLawID int  NOT NULL IDENTITY(1,1),
    startDate datetime  NOT NULL,
    endDate datetime  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent int  NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    no_days int  NOT NULL CHECK (no_days >=0),
    CONSTRAINT MaxDaysForPayementBeforeStudiesLaws_pk PRIMARY KEY  (maxDaysForPayementBeforeStudiesLawID)
);

-- Table: MinAttendanceToPassCourseLaws
CREATE TABLE MinAttendanceToPassCourseLaws (
    minAttendanceToPassCourseLawsID int  NOT NULL IDENTITY(1,1),
    startDate datetime  NOT NULL,
    endDate datetime  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent int  NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    min_attendance int  NOT NULL DEFAULT 50 CHECK (min_attendance BETWEEN 0 AND 100),
    CONSTRAINT MinAttendanceToPassCourseLaws_pk PRIMARY KEY  (minAttendanceToPassCourseLawsID)
);

-- Table: MinAttendanceToPassPracticeLaws
CREATE TABLE MinAttendanceToPassPracticeLaws (
    minAttendanceToPassPracticeLawID int  NOT NULL IDENTITY(1,1),
    startDate datetime  NOT NULL,
    endDate datetime  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent int  NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    min_attendance int  NOT NULL DEFAULT 50 CHECK (min_attendance BETWEEN 0 AND 100),
    CONSTRAINT MinAttendanceToPassPracticeLaws_pk PRIMARY KEY  (minAttendanceToPassPracticeLawID)
);

-- Table: MinAttendanceToPassStudiesLaws
CREATE TABLE MinAttendanceToPassStudiesLaws (
    minAttendanceToPassStudiesLawID int  NOT NULL IDENTITY(1,1),
    startDate datetime  NOT NULL,
    endDate datetime  NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isTheRecent int  NOT NULL CHECK (isTheRecent =0 OR isTheRecent = 1),
    min_attendance int  NOT NULL DEFAULT 50 CHECK (min_attendance BETWEEN 0 AND 100),
    CONSTRAINT MinAttendanceToPassStudiesLaws_pk PRIMARY KEY  (minAttendanceToPassStudiesLawID)
);

-- Table: OrderHistory
CREATE TABLE OrderHistory (
    orderID int  NOT NULL IDENTITY(1,1),
    userID int  NOT NULL,
    totalalValue money  NOT NULL,
    paymentStatus varchar(max)  NOT NULL,
    details varchar(max)  NULL CHECK (LEN(details)<=100),
    orderDate datetime  NOT NULL,
    CONSTRAINT OrderHistory_pk PRIMARY KEY  (orderID)
);

-- Table: Outsiders
CREATE TABLE Outsiders (
    outsiderID int  NOT NULL IDENTITY(1,1),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT Outsiders_pk PRIMARY KEY  (outsiderID)
);

-- Table: OutsidersAttendance
CREATE TABLE OutsidersAttendance (
    lessonID int  NOT NULL,
    outsiderID int  NOT NULL,
    wasPresent int  NOT NULL CHECK (wasPresent = 0 OR wasPresent =1),
    studiesSubjectID int  NOT NULL,
    CONSTRAINT OutsidersAttendance_pk PRIMARY KEY  (outsiderID,lessonID)
);

-- Table: OutsidersDataChangeHistory
CREATE TABLE OutsidersDataChangeHistory (
    outsiderID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL,
    CONSTRAINT OutsidersDataChangeHistory_pk PRIMARY KEY  (outsiderID,dateOfChange)
);

-- Table: StudiesShoppingItemForOutsiders
CREATE TABLE StudiesShoppingItemForOutsiders (
    studiesUserID int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    CONSTRAINT StudiesShoppingItemForOutsiders_pk PRIMARY KEY  (studiesUserID)
);

-- Table: StudiesShoppingItemForOutsidersHistory
CREATE TABLE StudiesShoppingItemForOutsidersHistory (
    mainOrderID int  NOT NULL,
    studiesUserID int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    CONSTRAINT StudiesShoppingItemForOutsidersHistory_pk PRIMARY KEY  (studiesUserID,mainOrderID)
);

-- Table: StudiesShoppingItemForStudiesUser
CREATE TABLE StudiesShoppingItemForStudiesUser (
    studiesUserID int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    CONSTRAINT StudiesShoppingItemForStudiesUser_pk PRIMARY KEY  (studiesUserID)
);

-- Table: StudiesShoppingItemForStudiesUserHistory
CREATE TABLE StudiesShoppingItemForStudiesUserHistory (
    mainOrderID int  NOT NULL,
    studiesUserID int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    CONSTRAINT StudiesShoppingItemForStudiesUserHistory_pk PRIMARY KEY  (studiesUserID,mainOrderID)
);

-- Table: StudiesSubject
CREATE TABLE StudiesSubject (
    studiesSubjectID int  NOT NULL IDENTITY(1,1),
    fieldOfStudiesID int  NOT NULL,
    mainCoordinatorID int  NOT NULL,
    name varchar(max)  NOT NULL CHECK (LEN(name)<=25),
    semester int  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    price money  NOT NULL,
    maxEnrolls int  NOT NULL,
    currEnrolls int  NOT NULL,
    CONSTRAINT enrolls_4 CHECK (currEnrolls <= maxEnrolls),
    CONSTRAINT StudiesSubject_pk PRIMARY KEY  (studiesSubjectID,fieldOfStudiesID)
);

-- Table: StudiesSubjectHistory
CREATE TABLE StudiesSubjectHistory (
    studiesSubjectID int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    mainCoordinatorID int  NOT NULL,
    name varchar(max)  NOT NULL CHECK (LEN(name)<=25),
    semester int  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    price money  NOT NULL,
    enrolls int  NOT NULL,
    CONSTRAINT StudiesSubjectHistory_pk PRIMARY KEY  (studiesSubjectID,fieldOfStudiesID)
);

-- Table: StudiesTeacher
CREATE TABLE StudiesTeacher (
    studiesTeacherID int  NOT NULL IDENTITY(1,1),
    description int  NOT NULL CHECK (LEN(description) <= 100),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT StudiesTeacher_pk PRIMARY KEY  (studiesTeacherID)
);

-- Table: StudiesTeacherDataChangeHistory
CREATE TABLE StudiesTeacherDataChangeHistory (
    studiesTeacherID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL,
    CONSTRAINT StudiesTeacherDataChangeHistory_pk PRIMARY KEY  (studiesTeacherID,dateOfChange)
);

-- Table: StudiesUser
CREATE TABLE StudiesUser (
    studiesUserID int  NOT NULL IDENTITY(1,1),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    semester int  NOT NULL,
    isActive int  NOT NULL,
    "index" int  NOT NULL,
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT StudiesUser_pk PRIMARY KEY  (studiesUserID)
);

-- Table: StudiesUserAssignmentToFieldOfStudies
CREATE TABLE StudiesUserAssignmentToFieldOfStudies (
    studiesUserID int  NOT NULL,
    fieldOfStudiesID int  NOT NULL,
    passed int  NOT NULL CHECK (passed = 0 OR passed = 1),
    grade int  NOT NULL CHECK (grade <= 6 AND grade >=1),
    paidFee int NOT NULL CHECK (paidFee = 0 OR paidFee = 1),
    CONSTRAINT StudiesUserAssignmentToFieldOfStudies_pk PRIMARY KEY  (studiesUserID,fieldOfStudiesID)
);



-- Table: StudiesUserAttendance
CREATE TABLE StudiesUserAttendance (
    lessonID int  NOT NULL,
    studiesUserID int  NOT NULL,
    wasPresent int  NOT NULL CHECK (wasPresent = 0 OR wasPresent =1),
    grade int  NULL CHECK (grade <= 6 AND grade >=1),
    studiesSubjectID int  NOT NULL,
    CONSTRAINT StudiesUserAttendance_pk PRIMARY KEY  (studiesUserID,lessonID)
);

-- Table: StudiesUserDataChangeHistory
CREATE TABLE StudiesUserDataChangeHistory (
    studiesUserID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_semester int  NOT NULL,
    old_isActive int  NOT NULL,
    old_index int  NOT NULL,
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_semester int  NOT NULL,
    new_isActive int  NOT NULL,
    new_index int  NOT NULL,
    new_email varchar(max)  NOT NULL,
    CONSTRAINT StudiesUserDataChangeHistory_pk PRIMARY KEY  (studiesUserID,dateOfChange)
);

-- Table: Translators
CREATE TABLE Translators (
    translatorID int  NOT NULL IDENTITY(1,1),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    CONSTRAINT Translators_pk PRIMARY KEY  (translatorID)
);

-- Table: TranslatorsDataChangeHistory
CREATE TABLE TranslatorsDataChangeHistory (
    translatorID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    CONSTRAINT TranslatorsDataChangeHistory_pk PRIMARY KEY  (translatorID,dateOfChange)
);

-- Table: UserSessionHistory
CREATE TABLE UserSessionHistory (
    sessionId int  NOT NULL IDENTITY(1,1),
    userID int  NOT NULL,
    startedDate datetime  NOT NULL,
    CONSTRAINT UserSessionHistory_pk PRIMARY KEY  (sessionId,userID)
);

-- Table: Users
CREATE TABLE Users (
    userID int  NOT NULL IDENTITY(1,1),
    translatorID int  NULL,
    webinarUserID int  NULL,
    webinarTeacherID int  NULL,
    courseUserID int  NULL,
    courseTeacherID int  NULL,
    studiesUserID int  NULL,
    studiesTeacherID int  NULL,
    studiesOutsiderID int  NULL,
    firstname varchar(max)  NOT NULL CHECK (LEN(firstname)<=25),
    lastname varchar(max)  NOT NULL CHECK (LEN(lastname)<=25),
    title varchar(max)  NULL CHECK (LEN(title) <= 10),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    phone varchar(max)  NOT NULL CHECK (LEN(phone)=9),
    encodedPassword varchar(max)  NOT NULL,
    address varchar(max)  NOT NULL,
    postalcode varchar(max)  NOT NULL CHECK (postalcode LIKE '__-___'),
    CONSTRAINT Users_pk PRIMARY KEY  (userID)
);

-- Table: UsersDataChangeHistory
CREATE TABLE UsersDataChangeHistory (
    userID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_firstname varchar(max)  NOT NULL CHECK (LEN(old_firstname)<=25),
    old_lastname varchar(max)  NOT NULL CHECK (LEN(old_lastname)<=25),
    old_title varchar(max)  NULL CHECK (LEN(old_title) <= 10),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    old_phone varchar(max)  NOT NULL CHECK (LEN(old_phone)=9),
    old_encodedPassword varchar(max)  NOT NULL,
    old_address varchar(max)  NOT NULL,
    old_postalcode varchar(max)  NOT NULL CHECK (old_postalcode LIKE '__-___'),
    new_firstname varchar(max)  NOT NULL CHECK (LEN(new_firstname)<=25),
    new_lastname varchar(max)  NOT NULL CHECK (LEN(new_lastname)<=25),
    new_title varchar(max)  NULL CHECK (LEN(new_title) <= 10),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    new_phone varchar(max)  NOT NULL CHECK (LEN(new_phone)=9),
    new_encodedPassword varchar(max)  NOT NULL,
    new_address varchar(max)  NOT NULL,
    new_postalcode varchar(max)  NOT NULL CHECK (new_postalcode LIKE '__-___'),
    CONSTRAINT UsersDataChangeHistory_pk PRIMARY KEY  (userID,dateOfChange)
);

-- Table: WebinarTeacher
CREATE TABLE WebinarTeacher (
    webinarTeacherID int  NOT NULL IDENTITY(1,1),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    email varchar(max)  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT WebinarTeacher_pk PRIMARY KEY  (webinarTeacherID)
);

-- Table: WebinarTeacherDataChangeHistory
CREATE TABLE WebinarTeacherDataChangeHistory (
    webinarTeacherID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    CONSTRAINT WebinarTeacherDataChangeHistory_pk PRIMARY KEY  (webinarTeacherID,dateOfChange)
);

-- Table: WebinarUsers
CREATE TABLE WebinarUsers (
    webinarUserID int  NOT NULL IDENTITY(1,1),
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    email int  NOT NULL CHECK (LEN(email)<=25 AND email LIKE '%@%'),
    CONSTRAINT WebinarUsers_pk PRIMARY KEY  (webinarUserID)
);

-- Table: WebinarUsersDataChangeHistory
CREATE TABLE WebinarUsersDataChangeHistory (
    webinarUserID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    old_email varchar(max)  NOT NULL CHECK (LEN(old_email)<=25 AND old_email LIKE '%@%'),
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    new_email varchar(max)  NOT NULL CHECK (LEN(new_email)<=25 AND new_email LIKE '%@%'),
    CONSTRAINT WebinarUsersDataChangeHistory_pk PRIMARY KEY  (webinarUserID,dateOfChange)
);

-- Table: Webinars
CREATE TABLE Webinars (
    webinarID int  NOT NULL IDENTITY(1,1),
    webinarTeacherID int  NOT NULL,
    translatorID int  NULL,
    date datetime  NOT NULL,
    price money  NOT NULL,
    linkToMeet varchar(max)  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    CONSTRAINT Webinars_pk PRIMARY KEY  (webinarID)
);

-- Table: WebinarsDataChangeHistory
CREATE TABLE WebinarsDataChangeHistory (
    webinarID int  NOT NULL,
    dateOfChange datetime  NOT NULL,
    old_webinarTeacherID int  NOT NULL,
    old_translatorID int  NULL,
    old_date datetime  NOT NULL,
    old_price money  NOT NULL,
    old_linkToMeet varchar(max)  NOT NULL,
    old_description varchar(max)  NOT NULL CHECK (LEN(old_description) <= 100),
    new_webinarTeacherID int  NOT NULL,
    new_translatorID int  NULL,
    new_date datetime  NOT NULL,
    new_price money  NOT NULL,
    new_linkToMeet varchar(max)  NOT NULL,
    new_description varchar(max)  NOT NULL CHECK (LEN(new_description) <= 100),
    CONSTRAINT WebinarsDataChangeHistory_pk PRIMARY KEY  (webinarID,dateOfChange)
);

-- Table: WebinarsHistory
CREATE TABLE WebinarsHistory (
    webinarID int  NOT NULL,
    webinarTeacherID int  NOT NULL,
    translatorID int  NULL,
    date datetime  NOT NULL,
    price money  NOT NULL,
    linkToRecord varchar(max)  NOT NULL,
    description varchar(max)  NOT NULL CHECK (LEN(description) <= 100),
    isAvailible int  NOT NULL CHECK (isAvailible = 0 OR isAvailible =1),
    CONSTRAINT WebinarsHistory_pk PRIMARY KEY  (webinarID)
);

-- Table: WebinarsShoppingItem
CREATE TABLE WebinarsShoppingItem (
    webinarID int  NOT NULL,
    webinarUserID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    hasTookPlace int  NOT NULL CHECK (hasTookPlace = 0 OR hasTookPlace = 1),
    isPayed int  NOT NULL CHECK (isPayed = 0 OR isPayed = 1),
    CONSTRAINT WebinarsShoppingItem_pk PRIMARY KEY  (webinarID,webinarUserID)
);

-- Table: WebinarsShoppingItemHistory
CREATE TABLE WebinarsShoppingItemHistory (
    mainOrderID int  NOT NULL,
    webinarID int  NOT NULL,
    webinarUserID int  NOT NULL,
    addedDate datetime  NOT NULL,
    price money  NOT NULL,
    hasTookPlace int  NOT NULL CHECK (hasTookPlace = 0 OR hasTookPlace = 1),
    isPayed int  NOT NULL CHECK (isPayed = 0 OR isPayed = 1),
    CONSTRAINT WebinarsShoppingItemHistory_pk PRIMARY KEY  (webinarID,webinarUserID,mainOrderID)
);

-- Table: WebinarsToUserAssignment
CREATE TABLE WebinarsToUserAssignment (
    webinarID int  NOT NULL,
    webinarUserID int  NOT NULL,
    payed money  NOT NULL,
    toPay money  NOT NULL,
    haveAccess int  NOT NULL CHECK (haveAccess = 0 OR haveAccess = 1),
    haveParticipated int  NOT NULL CHECK (haveParticipated = 0 OR haveParticipated =1),
    accessGainedDate datetime  NOT NULL,
    CONSTRAINT WebinarsToUserAssignment_pk PRIMARY KEY  (webinarID,webinarUserID)
);