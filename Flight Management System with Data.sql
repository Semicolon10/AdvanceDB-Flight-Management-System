create database FlightManagementSystem;

use FlightManagementSystem;

create table Airport(
AirportCode varchar(25),
AirportName varchar(50),
City varchar(25),
Country varchar(50),
Established_Year int,
constraint pk_AirportCode primary key(AirportCode)
);

create table Airline(
AirlineCode varchar(25),
AirlineName varchar(50),
AirlineOwner varchar(50),
FleetSize int,
Address varchar(100),
NoOfDestinations int,
HeadOfficeEmail varchar(50),
WebsiteURL varchar(100),
CommensementYear int,
constraint pk_AirlineCode primary key(AirlineCode)
);

create table Aircraft(
AircraftCode varchar(25),
AircraftName varchar(25),
Model varchar(20),
Manufacturer varchar(20),
MaxNoOfSeats int,
AirlineCode varchar(25),
FlightNo varchar(25),
constraint pk_AircraftCode primary key(AircraftCode),
constraint fk_AirlineCode_Aircraft foreign key(AirlineCode) references Airline(AirlineCode),
constraint fk_FlightNo_Aircraft foreign key(FlightNo) references Flight(FlightNo)
);

create table Flight(
FlightNo varchar(25),
FlightPath varchar(100),
AirlineCode varchar(25),
FlightType varchar(20),
constraint pk_FlightNo primary key(FLightNo),
constraint fk_AirlineCode_Flight foreign key(AirlineCode) references Airline(AirlineCode)
);

create table Reservation(
TicketNo varchar(10),
class varchar(20),
SeatNo varchar(4),
CheckInTime date,
BaggageWeight float,
PassportNo varchar(50),
LegNo varchar(10),
constraint pk_TicketNo primary key(TicketNo),
constraint fk_LegNo_1 foreign key(LegNo) references Arrival(LegNo),
constraint fk_LegNo_2 foreign key(LegNo) references Departure(LegNo),
constraint fk_LegNo_3 foreign key(LegNo) references Delayed(LegNo),
constraint fk_LegNo_4 foreign key(LegNo) references Canceled(LegNo)
);

create table Passenger(
PassportNo varchar(50),
FirstName varchar(25),
LastName varchar(25),
Gender varchar(6),
Nationality varchar(50),
DOB date,
PassportIssueDate date,
PassportExpiryDate date,
TicketNo varchar(10),
constraint pk_PassportNo primary key(PassportNo),
constraint fk_TicketNo foreign key(TicketNo) references Reservation(TicketNo)
);

create table Arrival(
LegNo varchar(10),
ArrivalTerminalNo varchar(10),
ArrivalTime date,
BaggageBeltNo varchar(10),
FlightStatus varchar(20),
DateOfFlight date,
AircrewCheckInTime date,
AircraftCode varchar(25),
FlightNo varchar(25),
constraint pk_LegNoArrival primary key(LegNo),
constraint fk_AircraftCode_Arrival foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Arrival foreign key(FlightNo) references Flight(FlightNo)
);

create table Departure(
LegNo varchar(10),
DepartureTerminalNo varchar(10),
GateNo varchar(10),
BoardingTime date,
DepartureTime date,
FlightStatus varchar(20),
DateOfFlight date,
AircrewCheckInTime date,
AircraftCode varchar(25),
FlightNo varchar(25),
constraint pk_LegNoDeparture primary key(LegNo),
constraint fk_AircraftCode_Departure foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Departure foreign key(FlightNo) references Flight(FlightNo)
);

create table Delayed(
LegNo varchar(10),
Reason varchar(100),
FlightStatus varchar(20),
DateOfFlight date,
AircrewCheckInTime date,
AircraftCode varchar(25),
FlightNo varchar(25),
constraint pk_LegNoDelayed primary key(LegNo),
constraint fk_AircraftCode_Delayed foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Delayed foreign key(FlightNo) references Flight(FlightNo)
);

create table Canceled(
LegNo varchar(10),
Reason varchar(100),
FlightStatus varchar(20),
DateOfFlight date,
AircrewCheckInTime date,
AircraftCode varchar(25),
FlightNo varchar(25),
constraint pk_LegNoCanceled primary key(LegNo),
constraint fk_AircraftCode_Canceled foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Canceled foreign key(FlightNo) references Flight(FlightNo)
);

create table SpecialRequirements(
PassportNo varchar(50),
RequirementDetails varchar(200),
constraint pk_PassportNo_SpecialRequirements primary key(PassportNo)
);
create table Minor(
PassportNo varchar(50),
AccompanyPassportNo varchar(50),
constraint pk_PassportNo_Minor primary key(PassportNo)
);

create table AirlineContactNo(
AirlineCode varchar(25),
ContactNo int,
constraint pk_AirlineCode_ContactNo primary key(AirlineCode,ContactNo),
constraint fk_AirlineCode_AirlineContactNo foreign key(AirlineCode) references Airline(AirlineCode)
);

create table Landing(
FlightNo varchar(25),
AirportName varchar(50),
constraint pk_FlightNo_AirportName_Landing primary key(FlightNo,AirportName),
constraint fk_FlightNo_Landing foreign key(FlightNo) references Flight(FlightNo)
);

create table TakeOff(
FlightNo varchar(25),
AirportName varchar(50),
constraint pk_FlightNo_AirportName_TakeOff primary key(FlightNo,AirportName),
constraint fk_FlightNo_TakeOff foreign key(FlightNo) references Flight(FlightNo)
);

create table ScheduleDays(
FlightNo varchar(25),
FlightDate date,
EstimatedArrivalTime date,
EstimatedDepartureTime date,
constraint pk_FlightNo_FlightDate primary key(FlightNo,FlightDate),
constraint fk_FlightNo_ScheduleDays foreign key(FlightNo) references Flight(FlightNo)
);

create table PassengerContactNo(
PassportNo varchar(50),
ContactNo int,
constraint pk_PassportNo_ContactNo primary key(PassportNo,ContactNo),
constraint fk_PassportNo_PassengerContactNo foreign key(PassportNo) references Passenger(PassportNo)
);

create table Pilot(
StaffID varchar(25),
FirstName varchar(25),
LastName varchar(25),
PassportNo varchar(50),
Address varchar(100),
Gender varchar(7),
Designation varchar(25),
DateJoined date,
AirlineTrainingDetails varchar(200),
AcadamicEducationDetails varchar(200),
TotalFlyingHours int,
LegNo varchar(10),
AirlineCode varchar(25),
constraint pk_StaffID primary key(StaffID),
constraint fk_AirlineCode_Pilot foreign key(AirlineCode) references Airline(AirlineCode),
constraint fk_LegNo_1_Pilot foreign key(LegNo) references Arrival(LegNo),
constraint fk_LegNo_2_Pilot foreign key(LegNo) references Departure(LegNo),
constraint fk_LegNo_3_Pilot foreign key(LegNo) references Delayed(LegNo),
constraint fk_LegNo_4_Pilot foreign key(LegNo) references Canceled(LegNo)
);

create table PilotFlownAircrafts(
StaffID varchar(25),
AircraftModel varchar(25),
FlyingHours int,
constraint pk_StaffID_AircraftModel primary key(StaffID,AircraftModel),
constraint fk_StaffID_PilotFlownAircrafts foreign key(StaffID) references Pilot(StaffID)
);

create table FlightAttendant(
StaffID varchar(25),
FirstName varchar(25),
LastName varchar(25),
PassportNo varchar(50),
Address varchar(100),
Gender varchar(7),
Designation varchar(25),
DateJoined date,
AirlineTrainingDetails varchar(200),
AcadamicEducationDetails varchar(200),
TotalFlyingHours int,
LegNo varchar(10),
AirlineCode varchar(25),
constraint pk_StaffID_Attendant primary key(StaffID),
constraint fk_AirlineCode_FlightAttendant foreign key(AirlineCode) references Airline(AirlineCode),
constraint fk_LegNo_1_FlightAttendant foreign key(LegNo) references Arrival(LegNo),
constraint fk_LegNo_2_FlightAttendant foreign key(LegNo) references Departure(LegNo),
constraint fk_LegNo_3_FlightAttendant foreign key(LegNo) references Delayed(LegNo),
constraint fk_LegNo_4_FlightAttendant foreign key(LegNo) references Canceled(LegNo)
);
create table PilotContactNo(
StaffID varchar(25),
ContactNo varchar(10),
constraint pk_StaffID_ContactNo primary key(StaffID,ContactNo),
constraint fk_StaffID_PilotContactNo foreign key(StaffID) references Pilot(StaffId)
);

create table FlightAttendantContactNo(
StaffID varchar(25),
ContactNo varchar(10),
constraint pk_StaffID_ContactNo_Attendant primary key(StaffID,ContactNo),
constraint fk_StaffID_FlightAttendantContactNo foreign key(StaffID) references FlightAttendant(StaffId)
);

create table ProvideServices(
AirlineCode varchar(25),
AirportCode varchar(25),
AirlineName varchar(50),
AirlineOwner varchar(50),
FleetSize int,
Address varchar(100),
NoOfDestinations int,
HeadOfficeEmail varchar(50),
WebsiteURL varchar(100),
CommensementYear int,
AirportName varchar(50),
City varchar(25),
Country varchar(50),
Established_Year int,
constraint pk_AirlineCode_AirportCode primary key(AirlineCode,AirportCode),
constraint fk_AirportCode_ProvideServices foreign key(AirportCode) references Airport(AirportCode),
constraint fk_AirlineCode_ProvideServices foreign key(AirlineCode) references Airline(AirlineCode)
);

/*** Data Insert ***/

INSERT INTO Airport VALUES
('GOR','Goroka Airport','Goroka','Papua New Guinea',1965),
('MAD','Madang Airport','Madang','Papua New Guinea',1970),
('NAD','Nadzab Airport','Nadzab','Papua New Guinea',1975),
('WEW','Wewak International Airport','Wewak','Papua New Guinea',1980),
('FMC','Fort McMurray Airport','Fort Mcmurray','Canada',1985),
('MOS','Moosonee Airport','Moosonee','Canada',1990),
('MAN','Maniwaki Airport','Maniwaki','Canada',1995),
('MON','Montreal International Airport','Montreal','Canada',2000),
('NAT','Natashquan Airport','Natashquan','Canada',2005),
('GAT','Gatineau Airport','Gatineau','Canada',2010);

select * from Airport;

INSERT INTO Airline VALUES
('UL','Sri lankan Airlines','CALLSIGN SRILANKAN',17,'Airline Centre Bandaranaike International Airport, Katunayake, Sri Lanka',114,'flysmiles@srilankan.com','https://www.srilankan.com/','1998'),
('SQ','Singapore Airlines','Temasek Holdings',119,'Airline House,25 Airline Road,Singapore 819829',64,'us_reservations@singaporeair.com.sg','https://www.singaporeair.com','1972'),
('EK','Emirates',' The Emirates Group',254,'Garhoud, Dubai, United Arab Emirates',180,'ekuae@emirates.com','https://www.emirates.com','1985'),
('9W','Jet Airways','Tailwinds Private Limited',124,'Jet Airways (India) Limited,Siroya Centre,Sahar Airport Road,Andheri (East),Mumbai - 400099,India.',67,'guestrelations@jetairways.com','https://www.jetairways.com','1993'),
('QR','Qatar Airways','Government of Qatar',220,'Qatar Airways Tower 1, next to Al Manna Building, Airport Road Doha, Qatar',150,'qrmedia@qatarairways.com','https://www.qatarairways.com','1994'),
('MH','Malaysia Airlines','Malaysia Aviation Group',80,'Kuala Lumpur International Airport, Sepang, Malaysia',61,'mhlbag@malaysiaairlines.com','http://www.malaysiaairlines.com','1972'),
('WY','Oman Air','Government of Oman',53,'Muscat International Airport,Muscat, Oman',50,'wymctstn@omanair.com','https://www.omanair.com','1993'),
('AI','Air India','Air India Limited',118,'Airlines House, Delhi, India',94,'call.del@airindia.in','http://www.airindia.in','1946'),
('GF','Gulf Air','Government of Bahrain',34,'Muharraq, Bahrain',50,' ffp@gulfair.com','http://www.gulfair.com',1950),
('QF','QANTAS','Northern Territory Aerial Services Limited',131,'10 Bourke Road Mascot NSW 2020, Australia',85,'frequent_flyer@qantas.com.au','http://www.qantas.com.au/',1920);

select * from Airline;

/*UPDATE Airline
SET AirlineCode = '9W'
WHERE AirlineCode = 'JAI';*/

INSERT INTO Aircraft VALUES
('A7-SSB','','A350-1000','Airbus',327,'QR','QR3568'),
('A7-HJH','','A380-800','Airbus',517,'QR','QR8542'),
('4R-ABO','','A320-200','Airbus',269,'UL','UL852'),
('4R-KJH','','A321-neo','Airbus',188,'UL','UL905'),
('4R-SDD','','A330-200','Airbus',287,'UL','UL566'),
('9V-KKI','','A380-800','Airbus',443,'SQ','SQ67'),
('9V-SDF','','A350-900 ULR','Airbus',161,'SQ','SQ88'),
('9V-CDF','','A330-300','Airbus',285,'SQ','SQ87'),
('VT-KJH','','B737-900','Boeing',166,'9W','9W665'),
('A86','','B737-900','Boeing',183,'WY','WY4587');

select * from Aircraft;

INSERT INTO Flight VALUES
('QR3568','Innsbruck Airport, Austria (LOWI) - London Heathrow Airport, United Kingdom (EGLL)','QR','Departed'),
('QR8542','Montpellier-Méditerranée Airport, France (LFMT) - Lille-Lesquin Airport, France (LFQQ)','QR','Arrived'),
('UL852','Surgut Airport, Russia (USRR) - Koltsovo Airport, Russia (USSS)','UL','Arrived'),
('UL905','Nizhny Novgorod International Airport, Russia (UWGG) - Sochi International Airport, Russia (URSS)','UL','Departed'),
('UL566','Voronezh International Airport, Russia (UUOO) - Voronezh International Airport, Russia (UUOO)','UL','Arrived'),
('SQ67','Fort Lauderdale Hollywood International Airport- Cleveland Hopkins International Airport(KCLE)','SQ','Arrived'),
('SQ88','Vienna International Airport, Austria (LOWW) - Munich International Airport, Germany (EDDM)','SQ','Departed'),
('SQ87','Zürich Airport, Switzerland (LSZH) - Chek Lap Kok International Airport, Hong Kong (VHHH)','SQ','Arrived'),
('9W665','Gdansk Lech Walesa Airport, Poland (EPGD) - John Paul II International Airport, Poland (EPKK)','9W','Arrived'),
('WY4587','Nizhny Novgorod International Airport, Russia (UWGG) - Sochi International Airport, Russia (URSS)','WY','Arrived');

SELECT * FROM Flight; 

/*UPDATE Flight
SET FlightPath = 'Fort Lauderdale Hollywood International Airport- Cleveland Hopkins International Airport(KCLE)'
WHERE FlightNo = 'SQ67';*/

INSERT INTO Reservation VALUES
('1234567891234','Economy Class','10A','2018-01-10',30,'P4366918','1'),
('2345678912345','Economy Class','12A','2018-01-15',28,'P4135494','2'),
('3456789123456','First Class','20B','2018-01-20',29,'P4168431','3'),
('4567891234567','Economy Class','15A','2018-01-25',28.5,'P4689873','4'),
('5678912345678','First Class','18A','2018-01-30',26,'P9846247','5'),
('6789123456789','Economy Class','11A','2018-02-05',25,'P1568468','6'),
('7891234567891','Economy Class','10B','2018-02-10',15.6,'P9513572','7'),
('8912345678912','First Class','12B','2018-02-15',14,'P9854236','8'),
('9123456789123','Economy Class','20B','2018-02-20',15.6,'P9764315','9'),
('1234560789123','Economy Class','15B','2018-02-25',30,'P4569872','10');

/*Not Executed*/

INSERT INTO Passenger VALUES
('P4366918','Sewmal','Tharindu','Male','Sinhalese','1995-10-15','2000-01-05','2010-01-05','EK5750'),
('P4135494','Asiri','Iroshan','Male','Sinhalese','1996-08-10','2001-02-06','2011-02-06','EK5760'),
('P4168431','Indrajith','Ekanayaka','Male','Sinhalese','1997-09-11','2002-03-07','2012-03-07','EK5770'),
('P4689873','Piumi','Prabodhani','Female','Sinhalese','1996-10-12','2003-04-08','2013-04-08','EK5780'),
('P9846247','Ayesh','Dulanja','Male','Sinhalese','1997-04-21','2004-05-09','2014-05-09','EK5790'),
('P1568468','Kamal','Jayasinghe','Male','Sinhalese','1960-05-10','2006-06-11','2016-06-11','EK800'),
('P9513572','Vimal','Perera','Male','Sinhalese','1965-06-02','2007-07-12','2017-07-12','EK5810'),
('P9854236','Bimal','Nonis','Male','Sinhalese','1962-08-04','2008-08-13','2018-08-13','EK5820'),
('P9764315','Nimal','Jayakodi','Male','Sinhalese','1964-10-20','2009-09-14','2019-09-14','EK5830'),
('P9764315','Hasini','Samuel','Female','Sinhalese','1963-01-16','2010-10-15','2020-10-15','EK5840');

/*Not Excecuted*/