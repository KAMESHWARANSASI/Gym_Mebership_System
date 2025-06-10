create database GYM_MEMBERSHIP_SYSTEM;
use GYM_MEMBERSHIP_SYSTEM;s

	-- create Member table
        
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender CHAR(1),
    DOB DATE,
    JoinDate DATE,
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

     -- create MembershipTypes table

CREATE TABLE MembershipTypes (
    MembershipTypeID INT PRIMARY KEY,
    TypeName VARCHAR(50),
    DurationMonths INT,
    Fee DECIMAL(10,2)
);

        -- create Subscriptions table
        
CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    MemberID INT,
    MembershipTypeID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (MembershipTypeID) REFERENCES MembershipTypes(MembershipTypeID)
);

		-- create  Payments table
 
 CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    MemberID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

      -- create  Trainers table
      
CREATE TABLE Trainers (
    TrainerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    HireDate DATE
);

 -- create TrainerAssignments table
 
 CREATE TABLE TrainerAssignments (
    AssignmentID INT PRIMARY KEY,
    MemberID INT,
    TrainerID INT,
    AssignedDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID)
);

--  create Attendance  table

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    MemberID INT,
    Date DATE,
    CheckInTime TIME,
    CheckOutTime TIME,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);








