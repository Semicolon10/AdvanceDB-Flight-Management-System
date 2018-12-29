create database FlightManagementSystem;

use FlightManagementSystem; 

create table Airport(
AirportCode char(3) not null,
AirportName varchar(50) not null,
City varchar(25) not null,
Country varchar(50) not null,
Established_Year int not null,
constraint pk_AirportCode primary key(AirportCode)
);

create table Airline(
AirlineCode varchar(5) not null,
AirlineName varchar(50) not null,
AirlineOwner varchar(50) not null,
FleetSize int not null,
Address varchar(100) not null,
NoOfDestinations int not null,
HeadOfficeEmail varchar(50) not null,
WebsiteURL varchar(100) not null,
CommensementYear int not null,
constraint pk_AirlineCode primary key(AirlineCode)
);

create table Aircraft(
AircraftCode varchar(6) not null,
AircraftName varchar(25) not null,
Model varchar(15) not null,
Manufacturer varchar(20) not null,
MaxNoOfSeats int not null,
AirlineCode varchar(5) not null,
FlightNo varchar(10) not null,
constraint pk_AircraftCode primary key(AircraftCode),
constraint fk_AirlineCode_Aircraft foreign key(AirlineCode) references Airline(AirlineCode),
constraint fk_FlightNo foreign key(FlightNo) references Flight(FlightNo)
);

create table Flight(
FlightNo varchar(10) not null,
FlightPath varchar(100) not null,
AirlineCode varchar(5) not null,
FlightType varchar(10) not null,
constraint pk_FlightNo primary key(FLightNo),
constraint fk_AirlineCode foreign key(AirlineCode) references Airline(AirlineCode)
);

create table Reservation(
TicketNo varchar(25) not null,
class varchar(20) not null,
SeatNo varchar(4) not null,
CheckInTime time not null,
BaggageWeight float not null,
PassportNo varchar(50) not null,
LegNo varchar(10) not null,
constraint pk_TicketNo primary key(TicketNo),
constraint fk_LegNo_1_Reservation foreign key(LegNo) references Arrival(LegNo),
constraint fk_LegNo_2_Reservation foreign key(LegNo) references Departure(LegNo),
constraint fk_LegNo_3_Reservation foreign key(LegNo) references Delayed(LegNo),
constraint fk_LegNo_4_Reservation foreign key(LegNo) references Canceled(LegNo)
);

create table Passenger(
PassportNo varchar(50) not null,
FirstName varchar(25) not null,
LastName varchar(25) not null,
Gender varchar(7) not null,
Nationality varchar(50) not null,
DOB date not null,
PassportIssueDate date not null,
PassportExpiryDate date not null,
TicketNo varchar(25) not null,
constraint pk_PassportNo primary key(PassportNo),
constraint fk_TicketNo_Passenger foreign key(TicketNo) references Reservation(TicketNo)
);

create table Arrival(
LegNo varchar(10) not null,
ArrivalTerminalNo varchar(5) not null,
ArrivalTime time not null,
BaggageBeltNo varchar(5) not null,
FlightStatus varchar(20) not null,
DateOfFlight date not null,
AircrewCheckInTime time not null,
AircraftCode varchar(6) not null,
FlightNo varchar(10) not null,
constraint pk_LegNoArrival primary key(LegNo),
constraint fk_AircraftCode foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Arrival foreign key(FlightNo) references Flight(FlightNo)
);

create table Departure(
LegNo varchar(10) not null,
DepartureTerminalNo varchar(5) not null,
GateNo varchar(5) not null,
BoardingTime time not null,
DepartureTime time not null,
FlightStatus varchar(20) not null,
DateOfFlight date not null,
AircrewCheckInTime time not null,
AircraftCode varchar(6) not null,
FlightNo varchar(10) not null,
constraint pk_LegNoDeparture primary key(LegNo),
constraint fk_AircraftCode_Depature foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Depature foreign key(FlightNo) references Flight(FlightNo)
);

create table Delayed(
LegNo varchar(10) not null,
Reason varchar(100) not null,
FlightStatus varchar(20) not null,
DateOfFlight date not null,
AircrewCheckInTime time not null,
AircraftCode varchar(6) not null,
FlightNo varchar(10) not null,
constraint pk_LegNoDelayed primary key(LegNo),
constraint fk_AircraftCode_Delayed foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Delayed foreign key(FlightNo) references Flight(FlightNo)
);

create table Canceled(
LegNo varchar(10) not null,
Reason varchar(100) not null,
FlightStatus varchar(20) not null,
DateOfFlight date not null,
AircrewCheckInTime time not null,
AircraftCode varchar(6) not null,
FlightNo varchar(10) not null,
constraint pk_LegNoCanceled primary key(LegNo),
constraint fk_AircraftCode_Canceled foreign key(AircraftCode) references Aircraft(AircraftCode),
constraint fk_FlightNo_Canceled foreign key(FlightNo) references Flight(FlightNo)
);

create table SpecialRequirements(
PassportNo varchar(50) not null,
RequirementDetails varchar(200) not null,
constraint pk_PassportNo_SpecialRequirements primary key(PassportNo)
);

create table Minor(
PassportNo varchar(50) not null,
AccompanyPassportNo varchar(50) not null,
constraint pk_PassportNo_Minor primary key(PassportNo)
);

create table AirlineContactNo(
AirlineCode varchar(5) not null,
ContactNo int not null,
constraint pk_AirlineCode_ContactNo primary key(AirlineCode,ContactNo),
constraint fk_AirlineCode_AirlineContactNo foreign key(AirlineCode) references Airline(AirlineCode)
);

create table Landing(
FlightNo varchar(10) not null,
AirportName varchar(50) not null,
constraint pk_FlightNo_AirportName_Landing primary key(FlightNo,AirportName),
constraint fk_FlightNo_Landing foreign key(FlightNo) references Flight(FlightNo)
);

create table TakeOff(
FlightNo varchar(10) not null,
AirportName varchar(50) not null,
constraint pk_FlightNo_AirportName_TakeOff primary key(FlightNo,AirportName),
constraint fk_FlightNo_TakeOff foreign key(FlightNo) references Flight(FlightNo)
);

create table ScheduleDays(
FlightNo varchar(10) not null,
FlightDate date not null,
EstimatedArrivalTime time not null,
EstimatedDepartureTime time not null,
constraint pk_FlightNo_FlightDate primary key(FlightNo,FlightDate),
constraint fk_FlightNo_ScheduleDays foreign key(FlightNo) references Flight(FlightNo)
);

create table PassengerContactNo(
PassportNo varchar(50) not null,
ContactNo int not null,
constraint pk_PassportNo_ContactNo primary key(PassportNo,ContactNo),
constraint fk_PassportNo foreign key(PassportNo) references Passenger(PassportNo)
);

create table Pilot(
StaffID varchar(25) not null,
FirstName varchar(25) not null,
LastName varchar(25) not null,
PassportNo varchar(50) not null,
Address varchar(100) not null,
Gender varchar(7) not null,
Designation varchar(25) not null,
DateJoined date not null,
AirlineTrainingDetails varchar(200) not null,
AcadamicEducationDetails varchar(200) not null,
TotalFlyingHours int not null,
LegNo varchar(10) not null,
AirlineCode varchar(5) not null,
constraint pk_StaffID primary key(StaffID),
constraint fk_AirlineCode_Pilot foreign key(AirlineCode) references Airline(AirlineCode),
constraint fk_LegNo_1 foreign key(LegNo) references Arrival(LegNo),
constraint fk_LegNo_2 foreign key(LegNo) references Departure(LegNo),
constraint fk_LegNo_3 foreign key(LegNo) references Delayed(LegNo),
constraint fk_LegNo_4 foreign key(LegNo) references Canceled(LegNo)
);

create table PilotFlownAircrafts(
StaffID varchar(25) not null,
AircraftModel varchar(15) not null,
FlyingHours int not null,
constraint pk_StaffID_AircraftModel primary key(StaffID,AircraftModel),
constraint fk_StaffID foreign key(StaffID) references Pilot(StaffID)
);

create table FlightAttendant(
StaffID varchar(25) not null,
FirstName varchar(25) not null,
LastName varchar(25) not null,
PassportNo varchar(50) not null,
Address varchar(100) not null,
Gender varchar(7) not null,
Designation varchar(25) not null,
DateJoined date not null,
AirlineTrainingDetails varchar(200) not null,
AcadamicEducationDetails varchar(200) not null,
TotalFlyingHours int not null,
LegNo varchar(10) not null,
AirlineCode varchar(5) not null,
constraint pk_StaffID_Attendant primary key(StaffID),
constraint fk_AirlineCode_FlightAttendant foreign key(AirlineCode) references Airline(AirlineCode),
constraint fk_LegNo_1_FlightAttendant foreign key(LegNo) references Arrival(LegNo),
constraint fk_LegNo_2_FlightAttendant foreign key(LegNo) references Departure(LegNo),
constraint fk_LegNo_3_FlightAttendant foreign key(LegNo) references Delayed(LegNo),
constraint fk_LegNo_4_FlightAttendant foreign key(LegNo) references Canceled(LegNo)
);

create table PilotContactNo(
StaffID varchar(25) not null,
ContactNo varchar(10) not null,
constraint pk_StaffID_ContactNo primary key(StaffID,ContactNo),
constraint fk_StaffID_PilotContactNo foreign key(StaffID) references Pilot(StaffId)
);

create table FlightAttendantContactNo(
StaffID varchar(25) not null,
ContactNo varchar(10) not null,
constraint pk_StaffID_ContactNo_Attendant primary key(StaffID,ContactNo),
constraint fk_StaffID_FlightAttendantContactNo foreign key(StaffID) references FlightAttendant(StaffId)
);

create table ProvideServices(
AirlineCode varchar(5) not null,
AirportCode char(3) not null,
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

SELECT * FROM Airport;

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

SELECT * FROM Airline;

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

SELECT * FROM Aircraft;

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

SELECT * FROM Reservation;

INSERT INTO Passenger VALUES
('P4366918','Sewmal','Tharindu','Male','Sinhalese','1995-10-15','2000-01-05','2010-01-05','1234567891234'),
('P4135494','Asiri','Iroshan','Male','Sinhalese','1996-08-10','2001-02-06','2011-02-06','2345678912345'),
('P4168431','Indrajith','Ekanayaka','Male','Sinhalese','1997-09-11','2002-03-07','2012-03-07','3456789123456'),
('P4689873','Piumi','Prabodhani','Female','Sinhalese','1996-10-12','2003-04-08','2013-04-08','4567891234567'),
('P9846247','Ayesh','Dulanja','Male','Sinhalese','1997-04-21','2004-05-09','2014-05-09','5678912345678'),
('P1568468','Kamal','Jayasinghe','Male','Sinhalese','1960-05-10','2006-06-11','2016-06-11','6789123456789'),
('P9513572','Vimal','Perera','Male','Sinhalese','1965-06-02','2007-07-12','2017-07-12','7891234567891'),
('P9854236','Bimal','Nonis','Male','Sinhalese','1962-08-04','2008-08-13','2018-08-13','8912345678912'),
('P9764315','Nimal','Jayakodi','Male','Sinhalese','1964-10-20','2009-09-14','2019-09-14','9123456789123'),
('P9764314','Hasini','Samuel','Female','Sinhalese','1963-01-16','2010-10-15','2020-10-15','1234560789123');

SELECT * FROM Passenger;

INSERT INTO Arrival VALUES
('1','N1','8:10','10','Active','2010-01-05','1:20','A7-SSB','QR3568'),
('2','E2','9:20','11','Landed','2010-01-10','2:30','A7-HJH','QR8542'),
('3','W3','10:30','12','Cancelled','2010-01-15','3:40','4R-ABO','UL852'),
('4','S4','11:40','13','Active','2010-01-16','4:50','4R-KJH','UL905'),
('5','N5','12:50','14','Cancelled','2010-01-17','5:00','4R-SDD','UL566'),
('6','E1','1:00','15','Landed','2010-01-18','6:10','9V-KKI','SQ67'),
('7','W2','2:10','16','Active','2010-01-19','7:20','9V-SDF','SQ88'),
('8','S3','3:20','17','Cancelled','2010-01-20','8:30','9V-CDF','SQ87'),
('9','N4','4:30','18','Landed','2010-01-25','9:40','VT-KJH','9W665'),
('10','E5','5:40','19','Active','2010-01-30','10:50','A86','WY4587');

SELECT * FROM Arrival;

INSERT INTO Departure VALUES
('1','N1','A1','1:20','2:10','Cancelled','2018-01-5','2:00','A7-SSB','QR3568'),
('2','E2','B2','2:30','3:20','Active','2018-01-10','2:10','A7-HJH','QR8542'),
('3','W3','C3','3:40','4:30','Landed','2018-01-15','2:30','4R-ABO','UL852'),
('4','S4','A4','4:50','5:40','Cancelled','2018-01-20','2:40','4R-KJH','UL905'),
('5','N5','B1','5:00','6:50','Active','2018-01-25','2:50','4R-SDD','UL566'),
('6','E1','C2','6:10','7:00','Landed','2018-01-30','3:00','9V-KKI','SQ67'),
('7','W2','A3','7:20','8:10','Cancelled','2018-02-5','3:10','9V-SDF','SQ88'),
('8','S3','B4','8:30','9:20','Landed','2018-02-10','3:20','9V-CDF','SQ87'),
('9','N4','C1','9:40','10:30','Active','2018-02-15','3:30','VT-KJH','9W665'),
('10','E5','A2','10:50','11:40','Cancelled','2018-02-20','3:40','A86','WY4587');

SELECT * FROM Departure;

INSERT INTO Delayed VALUES
('1','Waiting for Cargo','Landed','2018-03-20','4:30','A7-SSB','QR3568'),
('2','Due to bad weather','Landed','2018-03-25','4:30','A7-HJH','QR8542'),
('3','Mechanical Delay','Landed','2018-03-30','4:30','4R-ABO','UL852'),
('4','Waiting for Cargo','Landed','2018-04-05','4:30','4R-KJH','UL905'),
('5','Mechanical Delay','Landed','2018-04-10','4:30','4R-SDD','UL566'),
('6','Due to bad weather','Landed','2018-05-25','4:30','9V-KKI','SQ67'),
('7','Mechanical Delay','Landed','2018-05-30','4:30','9V-SDF','SQ88'),
('8','Waiting for Cargo','Landed','2018-05-15','4:30','9V-CDF','SQ87'),
('9','Mechanical Delay','Landed','2018-04-20','4:30','VT-KJH','9W665'),
('10','Due to bad weather','Landed','2018-04-02','4:30','A86','WY4587');

SELECT * FROM Delayed;

INSERT INTO Canceled VALUES
('1','Inclement Weather','Cancelled','2018-04-02','5:30','A7-SSB','QR3568'),
('2','Computer Glitch','Cancelled','2018-04-04','5:30','A7-HJH','QR8542'),
('3','Mechanical Issue','Cancelled','2018-04-06','5:30','4R-ABO','UL852'),
('4','Inclement Weather','Cancelled','2018-04-08','5:30','4R-KJH','UL905'),
('5','Mechanical Issue','Cancelled','2018-04-10','5:30','4R-SDD','UL566'),
('6','Computer Glitch','Cancelled','2018-04-12','5:30','9V-KKI','SQ67'),
('7','Inclement Weather','Cancelled','2018-04-14','5:30','9V-SDF','SQ88'),
('8','Computer Glitch','Cancelled','2018-04-16','5:30','9V-CDF','SQ87'),
('9','Mechanical Issue','Cancelled','2018-04-18','5:30','VT-KJH','9W665'),
('10','Inclement Weather','Cancelled','2018-04-20','5:30','A86','WY4587');

SELECT * FROM Canceled;

INSERT INTO SpecialRequirements VALUES
('P4366918','Requires wheelchair'),
('P4135494','Meet and Assist'),
('P4168431','Requires wheelchair'),
('P4689873','Requires wheelchair'),
('P9846247','Meet and Assist'),
('P9854236','Meet and Assist'),
('P9712346','Requires wheelchair'),
('P9513572','Meet and Assist'),
('P9764314','Meet and Assist'),
('P1568468','Requires wheelchair');

SELECT * FROM SpecialRequirements;

INSERT INTO Minor VALUES
('P1568468','P1568001'),
('P9513572','P1568002'),
('P9854236','P1568003'),
('P9764315','P1568004'),
('P9764314','P1568005'),
('P9513680','P1568469'),
('P9516789','P4366910'),
('P9584240','P9854250'),
('P9715046','P4802346'),
('P7123461','P0971346');

SELECT * FROM Minor;

INSERT INTO AirlineContactNo VALUES
('UL',117771979),
('SQ',800742333),
('EK',114704070),
('9W',223989333),
('QR',115570000),
('MH',115570000),
('WY',968245311),
('AI',914461455),
('GF',112475396),
('QF',180274500);

SELECT * FROM AirlineContactNo;

INSERT INTO Landing VALUES
('QR3568','Sri lankan Airlines'),
('QR8542','Singapore Airlines'),
('UL852','Emirates'),
('UL905','Jet Airways'),
('UL566','Qatar Airways'),
('SQ67','Malaysia Airlines'),
('SQ88','Oman Air'),
('SQ87','Air India'),
('9W665','Gulf Air'),
('WY4587','QANTAS');

SELECT * FROM Landing;

INSERT INTO TakeOff VALUES
('QR3568','Sri lankan Airlines'),
('QR8542','Singapore Airlines'),
('UL852','Emirates'),
('UL905','Jet Airways'),
('UL566','Qatar Airways'),
('SQ67','Malaysia Airlines'),
('SQ88','Oman Air'),
('SQ87','Air India'),
('9W665','Gulf Air'),
('WY4587','QANTAS');

SELECT * FROM TakeOff;

INSERT INTO ScheduleDays VALUES
('QR3568','2018-05-01','1:00','5:00'),
('QR8542','2018-05-02','1:30','5:30'),
('UL852','2018-05-03','2:00','6:00'),
('UL905','2018-05-04','2:30','6:30'),
('UL566','2018-05-05','3:00','7:00'),
('WY4587','2018-05-04','3:30','7:30'),
('SQ87','2018-05-08','4:00','8:00'),
('SQ88','2018-05-08','5:00','8:30'),
('SQ67','2018-05-10','5:00','9:00'),
('9W665','2018-05-12','5:30','10:00');

SELECT * FROM ScheduleDays;

INSERT INTO PassengerContactNo VALUES
('P4366918',0766638903),
('P4135494',0761234567),
('P4168431',0779876543),
('P4689873',0779513574),
('P9846247',0778451623),
('P1568468',0763219874),
('P9513572',0769871475),
('P9854236',0773699877),
('P9764315',0779516237),
('P9764314',0769988774);

SELECT * FROM PassengerContactNo;

INSERT INTO Pilot VALUES
('12345A','John','Smith','P1234567','6649 N Blue Gum St','Male','Captain','2010-02-15','-','-',1000,'1','UL'),
('67891A','Melanie','Grech','P8912345','4 B Blue Ridge Blvd','Female','Captain','2010-03-20','-','-',1500,'2','SQ'),
('23456B','Jason','Boling','P6789123','639 Main St','Male','Captain','2010-04-20','-','-',1000,'3','EK'),
('78912B','Joe','Vella','P4567891','34 Center St','Male','Captain','2010-05-25','-','-',1500,'4','9W'),
('34567A','Samantha','Marie','P2345678','98 Connecticut Ave Nw','Female','-','2010-06-30','-','-',1500,'5','QR'),
('98765A','Phillip','Aguiar','P9123456','62B Rockville Ave','Male','Captain','2010-07-10','-','-',1000,'6','MH'),
('87654B','Elden','Harren','P7891234','Beverly, MA 01915','Female','Captain','2010-08-15','-','-',1500,'7','WY'),
('76543A','Ike','Combes','P5678912','State College, PA 16801','Male','Captain','2010-09-20','-','-',1000,'8','AI'),
('65432B','Nicky','Hand','P3456789','Matthews, NC 28104','Female','Captain','2010-10-25','-','-',1500,'9','GF'),
('54321A','Darryl','Privett','P0123456','Wyandotte, MI 48192','Male','Captain','2010-11-30','-','-',1000,'10','QF');

SELECT * FROM Pilot;

/*UPDATE Pilot
SET Designation = 'Captain'
WHERE StaffID = '34567A';*/

INSERT INTO PilotFlownAircrafts VALUES
('12345A','A380',1000),
('67891A','A380',1500),
('23456B','A380',1000),
('78912B','A380',1500),
('34567A','A380',1500),
('98765A','A7-HJH',1000),
('87654B','4R-KJH',1200),
('65432B','4R-SDD',1050),
('76543A','A7-HJH',1560),
('54321A','4RKJH',1420);

SELECT * FROM PilotFlownAircrafts;

INSERT INTO FlightAttendant VALUES
('12345A','John','Smith','P1234567','6649 N Blue Gum St','Male','Captain','2010-02-15','','',1000,'1','UL'),
('67891A','Melanie','Grech','P8912345','4 B Blue Ridge Blvd','Female','','2010-03-20','','',1500,'2','SQ'),
('23456B','Jason','Boling','P6789123','639 Main St','Male','Captain','2010-04-20','','',1000,'3','EK'),
('78912B','Joe','Vella','P4567891','34 Center St','Male','Captain','2010-05-25','','',1500,'4','9W'),
('34567A','Samantha','Marie','P2345678','98 Connecticut Ave Nw','Female','Captain','2010-06-30','','',1500,'5','QR'),
('15555A','Smith','Mendis','P0987654','356 Center St','Male','Captain','2010-02-02','','',1300,'6','UL'),
('24444B','Paul','Shawn','P1876543','345 Main St','Male','Captain','2010-02-09','','',1200,'7','EK'),
('33355B','Harry','Parker','P2765432','678 Main St','Male','Captain','2010-02-10','','',1300,'8','9W'),
('91234A','Messy','Lousifer','P3098765','1234 B Blue Gun ST','Male','Captain','2010-02-23','','',1500,'9','9W'),
('78992B','Tony','Binz','P4654321','34 C Blue Gun ST','Male','Captain','2010-02-25','','',1700,'10','QR');

SELECT * FROM FlightAttendant;

/*UPDATE FlightAttendant
SET Designation = 'Captain'
WHERE StaffID = '78912B';*/

INSERT INTO PilotContactNo VALUES
('12345A','0781234567'),
('67891A','0787894561'),
('23456B','0711234567'),
('78912B','0718912345'),
('34567A','0779876543'),
('98765A','0713122657'),
('54321A','0789002089'),
('76543A','0764567216'),
('87654B','0782578265'),
('87654B','0715692543');

SELECT * FROM PilotContactNo;

INSERT INTO FlightAttendantContactNo VALUES
('12345A','0781234567'),
('67891A','0787894561'),
('23456B','0711234567'),
('78912B','0718912345'),
('34567A','0779876543'),
('24444B','0718934567'),
('24444B','0756789345'),
('15555A','0789561345'),
('91234A','0704445621'),
('91234A','0715559032');

SELECT * FROM FlightAttendantContactNo;

INSERT INTO ProvideServices VALUES
('UL','GOR'),
('SQ','MAD'),
('EK','NAD'),
('9W','WEW'),
('QR','FMC'),
('MH','MOS'),
('WY','MAN'),
('AI','MON'),
('GF','NAT'),
('QF','GAT');

SELECT * FROM ProvideServices;