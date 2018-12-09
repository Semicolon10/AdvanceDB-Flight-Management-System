CREATE DATABASE Flight_Management_System

USE Flight_Management_System

CREATE TABLE Airport(
	AirportCode VARCHAR(20) NOT NULL,
	AirportName VARCHAR(30) NOT NULL,
	City VARCHAR(30) NOT NULL,
	Country VARCHAR(30) NOT NULL,
	EstablishedYear INT NOT NULL,
	CONSTRAINT pk_AirportCode PRIMARY KEY(AirportCode),
	CONSTRAINT uk_AirportName UNIQUE(AirportName)
);

CREATE TABLE Airline(
	AirlineCode VARCHAR(20) NOT NULL,
	AirlineName VARCHAR(30) NOT NULL,
	Owner VARCHAR(30) NOT NULL,
	FleetSize INT NOT NULL,
	Address VARCHAR(255) NOT NULL,
	NoOfDestinations INT NOT NULL,
	HeadOfficeEmail VARCHAR(150) NOT NULL,
	WebsiteURL VARCHAR(150) NOT NULL,
	CommencementYear DATE NOT NULL,
	CONSTRAINT pk_AirlineCode PRIMARY KEY(AirlineCode),
	CONSTRAINT uk_AirlineName UNIQUE(AirlineName)
);

CREATE TABLE Aircraft(
	AircraftCode VARCHAR(20) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Model VARCHAR(100) NOT NULL,
	Manufacturer VARCHAR(100) NOT NULL,
	MaxNoOfSeats INT NOT NULL,
	AirlineCode VARCHAR(20) NOT NULL,
	FlightNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_AircraftCode PRIMARY KEY(AircraftCode)
);

ALTER TABLE Aircraft
ADD CONSTRAINT fk_AirlineCode_Aircraft FOREIGN KEY(AirlineCode) REFERENCES Airline(AirlineCode);

ALTER TABLE Aircraft
ADD CONSTRAINT fk_FlightNo_Aircraft FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo);

CREATE TABLE Pilot(
	StaffID VARCHAR(20) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	PassportNo VARCHAR(30) NOT NULL,
	Address VARCHAR(60) NOT NULL,
	Gender CHAR(1) NOT NULL,
	Designation VARCHAR(30) NOT NULL,
	DateJoined DATE NOT NULL,
	AirlineTrainingDetails VARCHAR(500) NOT NULL,
	AcademicEducationDetails VARCHAR(500) NOT NULL,
	AircraftModel VARCHAR(30) NOT NULL,
	FlyingHours TIME NOT NULL,
	TotalFlyingHours TIME NOT NULL,
	CONSTRAINT pk_StaffID PRIMARY KEY(StaffID)
);

ALTER TABLE Pilot
ADD CONSTRAINT fk_StaffID_Pilot FOREIGN KEY(StaffID) REFERENCES Aircrew(StaffID);

ALTER TABLE Pilot
ADD CONSTRAINT fk_PassportNo_Pilot FOREIGN KEY(PassportNo) REFERENCES Aircrew(PassportNo);/*There is an error*/

CREATE TABLE FlightAttendant(
	StaffID VARCHAR(20) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	PassportNo VARCHAR(30) NOT NULL,
	Address VARCHAR(300) NOT NULL,
	Gender CHAR(1) NOT NULL,
	Designation VARCHAR(30) NOT NULL,
	DateJoined DATE NOT NULL,
	AirlineTrainingDetails VARCHAR(500) NOT NULL,
	AcademicEducationDetails VARCHAR(500) NOT NULL,
	TotalFlyingHours TIME NOT NULL,
	CONSTRAINT pk_FlightAttendant_StaffID PRIMARY KEY(StaffID)
);

ALTER TABLE FlightAttendant
ADD CONSTRAINT fk_PassportNo_FlightAttendant FOREIGN KEY(PassportNo) REFERENCES Aircrew(PassportNo);/*There is an error*/

ALTER TABLE FlightAttendant
ADD CONSTRAINT fk_StaffID_FlightAttendant FOREIGN KEY(StaffID) REFERENCES Aircrew(StaffID);

CREATE TABLE Passenger(
	PassportNo VARCHAR(30) NOT NULL,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Gender CHAR(1) NOT NULL,
	Nationality VARCHAR(20) NOT NULL,
	DOB DATE NOT NULL,
	PassportIssueDate DATE NOT NULL,
	PassportExpiryDate DATE NOT NULL,
	CONSTRAINT pk_PassportNo PRIMARY KEY(PassportNo)
);

CREATE TABLE SpecialRequirements(
	PassportNo VARCHAR(30) NOT NULL,
	RequirementDetails VARCHAR(100) NOT NULL,
	CONSTRAINT pk_PassportNo_SpecialRequirements PRIMARY KEY(PassportNo),
	CONSTRAINT fk_PassportNo FOREIGN KEY(PassportNo) REFERENCES Passenger(PassportNo) 
);

CREATE TABLE Minor(
	PassportNo VARCHAR(30) NOT NULL,
	AccompanyPassportNumber VARCHAR(30) NOT NULL,
	CONSTRAINT pk_PassportNo_Minor PRIMARY KEY(PassportNo)
);

ALTER TABLE Minor
ADD CONSTRAINT fk_PassportNo_Minor FOREIGN KEY(PassportNo) REFERENCES Passenger(PassportNo);

ALTER TABLE Minor
ADD CONSTRAINT fk_AccompanyPassportNumber_Minor FOREIGN KEY(AccompanyPassportNumber) REFERENCES Passenger(PassportNo);


CREATE TABLE Arrival(
	LegNo VARCHAR(20) NOT NULL,
	ArrivalTerminalNo VARCHAR(20) NOT NULL,
	ArrivalTime TIME NOT NULL,
	BaggageBeltNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_LegNo_Arrival PRIMARY KEY(LegNo)
);

ALTER TABLE Arrival
ADD CONSTRAINT fk_LegNo_Arrival FOREIGN KEY(LegNo) REFERENCES Flight_Leg(LegNo);

CREATE TABLE Departure(
	LegNo VARCHAR(20) NOT NULL,
	DepartureTerminalNo VARCHAR(20) NOT NULL,
	GateNo VARCHAR(20) NOT NULL,
	BoardingTime TIME NOT NULL,
	DepartureTime VARCHAR(20) NOT NULL,
	CONSTRAINT pk_LegNo_Departure PRIMARY KEY(LegNo)
);

ALTER TABLE Departure
ADD CONSTRAINT fk_LegNo_Departure FOREIGN KEY(LegNo) REFERENCES Flight_Leg(LegNo);

CREATE TABLE Delayed(
	LegNo VARCHAR(20) NOT NULL,
	Reason VARCHAR(500) NOT NULL,
	CONSTRAINT pk_LegNo_Delayed PRIMARY KEY(LegNo)
);

ALTER TABLE Delayed
ADD CONSTRAINT fk_LegNo_Delayed FOREIGN KEY(LegNo) REFERENCES Flight_Leg(LegNo);

CREATE TABLE Canceled(
	LegNo VARCHAR(20) NOT NULL,
	Reason VARCHAR(500) NOT NULL,
	CONSTRAINT pk_LegNo_Canceled PRIMARY KEY(LegNo)
);

ALTER TABLE Canceled
ADD CONSTRAINT fk_LegNo_Canceled FOREIGN KEY(LegNo) REFERENCES Flight_Leg(LegNo);

CREATE TABLE Provide_Services_Airline(
	AirlineCode VARCHAR(20) NOT NULL,
	AirlineName VARCHAR(50) NOT NULL,
	Owner VARCHAR(50) NOT NULL,
	FleetSize INT NOT NULL,
	Address VARCHAR(300) NOT NULL,
	NoOfDestinations INT NOT NULL,
	HeadOfficeEmail VARCHAR(150) NOT NULL,
	WebsiteURL VARCHAR(200) NOT NULL,
	CommencementYear DATE NOT NULL,
	CONSTRAINT pk_AirlineCode_Provide_Services_Airline PRIMARY KEY(AirlineCode),
	CONSTRAINT uk_AirlineName_Provide_Services_Airline UNIQUE(AirlineName)
);

CREATE TABLE Provide_Services_Airport(
	AirportCode VARCHAR(20) NOT NULL,
	AirportName VARCHAR(30) NOT NULL,
	City VARCHAR(30) NOT NULL,
	Country VARCHAR(30) NOT NULL,
	EstablishedYear INT NOT NULL,
	CONSTRAINT pk_AirportCode_Provide_Services_Airport PRIMARY KEY(AirportCode),
	CONSTRAINT uk_AirportName_Provide_Services_Airport UNIQUE(AirportName)
);

CREATE TABLE Airline_Contact_No(
	AirlineCode VARCHAR(20) NOT NULL,
	ContactNo VARCHAR(20) NOT NULL,
	/*CONSTRAINT fk_AirlineCode FOREIGN KEY(AirlineCode) REFERENCES Provide_Services_Airline(AirlineCode),*/
	CONSTRAINT pk_AirlineCode_ContactNo PRIMARY KEY(AirlineCode,ContactNo)
);

ALTER TABLE Airline_Contact_No
ADD CONSTRAINT fk_AirlineCode_Airline_Contact_No FOREIGN KEY(AirlineCode) REFERENCES Airline(AirlineCode);

/*CREATE TABLE Aircrew_Contact_No(
	StaffID VARCHAR(20) NOT NULL,
	ContactNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_StaffID_ContactNo PRIMARY KEY(StaffID,ContactNo),
	CONSTRAINT fk_StaffID FOREIGN KEY(StaffID) REFERENCES Aircrew(StaffID)
);*/

CREATE TABLE Passenger_Contact_No(
	PassportNo VARCHAR(30) NOT NULL,
	ContactNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_PassportNo_ContactNo PRIMARY KEY(PassportNo,ContactNo)
);

ALTER TABLE Passenger_Contact_No
ADD CONSTRAINT fk_PassportNo_Passenger_Contact_No FOREIGN KEY (PassportNo) REFERENCES Passenger(PassportNo);

CREATE TABLE Aircrew(
	StaffID VARCHAR(20) NOT NULL, 
	PassportNo VARCHAR(30) NOT NULL,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Gender CHAR(1) NOT NULL,
	Address VARCHAR(300) NOT NULL,
	Designation VARCHAR(100) NOT NULL,
	DateJoined DATE NOT NULL,
	AirlineTrainingDetails VARCHAR(500) NOT NULL,
	AcadamicEducationDetails VARCHAR(500) NOT NULL,
	AirlineCode VARCHAR(20) NOT NULL,
	LegNo VARCHAR(20) NOT NULL,
	CheckInTime TIME NOT NULL,
	CONSTRAINT pk_StaffID_Aircrew PRIMARY KEY(StaffID)
);

ALTER TABLE Aircrew
ADD CONSTRAINT fk_AirlineCode_Aircrew FOREIGN KEY(AirlineCode) REFERENCES Airline(AirlineCode);

ALTER TABLE Aircrew
ADD CONSTRAINT fk_LegNo_Aircrew FOREIGN KEY(LegNo) REFERENCES Flight_Leg(LegNo);

CREATE TABLE Flight(
	FlightNo VARCHAR(20) NOT NULL,
	FlightPath VARCHAR(500) NOT NULL,
	AirlineCode VARCHAR(20) NOT NULL,
	FlightType VARCHAR(100) NOT NULL,
	CONSTRAINT pk_FlightNo PRIMARY KEY(FlightNo)
);

ALTER TABLE Flight
ADD CONSTRAINT fk_AirlineCode_Flight FOREIGN KEY(AirlineCode) REFERENCES Airline(AirlineCode);

CREATE TABLE Pilot_Contact_No(
	StaffID VARCHAR(20) NOT NULL,
	ContactNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_StaffID_Pilot_Contact_No PRIMARY KEY(StaffID,ContactNo),
	CONSTRAINT fk_StaffID_Pilot_Contact_No FOREIGN KEY(StaffID) REFERENCES Aircrew(StaffID)
);

CREATE TABLE FlightAttendant_Contact_No(
	StaffID VARCHAR(20) NOT NULL,
	ContactNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_StaffID_FlightAttendant_Contact_No PRIMARY KEY(StaffID,ContactNo),
	CONSTRAINT fk_StaffID_FlightAttendant_Contact_No FOREIGN KEY(StaffID) REFERENCES Aircrew(StaffID)
);

CREATE TABLE Landing(
	FlightNo VARCHAR(20) NOT NULL,
	AirportName VARCHAR(30) NOT NULL,
	CONSTRAINT pk_FlightNo_AirportName_Landing PRIMARY KEY(FlightNo,AirportName),
	CONSTRAINT fk_FlightNo_Landing FOREIGN KEY (FlightNo) REFERENCES Flight(FlightNo)
);

ALTER TABLE Take_Off
ADD CONSTRAINT fk_AirportName_Landing FOREIGN KEY(AirportName) REFERENCES Airport(AirportName);

CREATE TABLE Take_Off(
	FlightNo VARCHAR(20) NOT NULL,
	AirportName VARCHAR(30) NOT NULL,
	CONSTRAINT pk_FlightNo_AirportName_Take_Off PRIMARY KEY(FlightNo,AirportName),
	CONSTRAINT fk_FlightNo_Take_Off FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo)
);

ALTER TABLE Take_Off
ADD CONSTRAINT fk_AirportName_Take_Off FOREIGN KEY(AirportName) REFERENCES Airport(AirportName);

CREATE TABLE Shedule_Days(
	FlightNo VARCHAR(20) NOT NULL,
	FlightDate DATE NOT NULL,
	EstimatedArrivaltime TIME NOT NULL,
	EstimatedDepatureTime TIME NOT NULL,
	CONSTRAINT pk_FlightNo_FlightDate_Shedule_Days PRIMARY KEY(FlightNo,FlightDate),
	CONSTRAINT fk_FlightNo_Shedule_Days FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo)
);

CREATE TABLE Flight_Leg(
	LegNo VARCHAR(20) NOT NULL,
	DateOfFlight DATE NOT NULL,
	FlightStatus VARCHAR(100) NOT NULL,
	AircraftCode VARCHAR(20) NOT NULL,
	FlightNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_LegNo PRIMARY KEY(leGNo)
);

ALTER TABLE Flight_Leg
ADD CONSTRAINT fk_FlightNo_Flight_Leg FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo);

ALTER TABLE Flight_Leg
ADD CONSTRAINT fk_AircraftCode_Flight_Leg FOREIGN KEY(AircraftCode) REFERENCES Aircraft(AircraftCode);

CREATE TABLE Reservation(
	TicketNo VARCHAR(100) NOT NULL,
	Class VARCHAR(50) NOT NULL,
	SeatNo VARCHAR(20) NOT NULL,
	CheckinTime TIME NOT NULL,
	BaggageWeight INT NOT NULL, 
	PassportNo VARCHAR(30) NOT NULL,
	LegNo VARCHAR(20) NOT NULL,
	CONSTRAINT pk_TicketNo PRIMARY KEY(TicketNo)
);
ALTER TABLE Reservation
ADD CONSTRAINT fk_PassportNo_Reservation FOREIGN KEY(PassportNo) REFERENCES Passenger(PassportNo);

ALTER TABLE Reservation
ADD CONSTRAINT fk_LegNo_Reservation FOREIGN KEY(LegNo) REFERENCES Flight_Leg(LegNo);

ALTER TABLE Reservation
ADD CONSTRAINT uq_SeatNo_Reservation UNIQUE(SeatNo);

ALTER TABLE Reservation
ADD CONSTRAINT uq_PassportNo_Reservation UNIQUE(PassportNo);