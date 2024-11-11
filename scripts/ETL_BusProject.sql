-- ETL Process : 
CREATE DATABASE IF NOT EXISTS  Bus_Database;
USE Bus_Database;


CREATE TABLE IF NOT EXISTS PublicTransitRoutesData (
    BusID INT,
    RouteID VARCHAR(7),
    Q INT,
    Year VARCHAR(7),
    RouteDirection INT,
    DailyRides_Tuesday INT,
    WeeklyRides INT,
    DailyPassengers FLOAT,
    WeeklyPassengers FLOAT,
    AVGCommutersPerRide_Weekly FLOAT,
    AverageTripDuration FLOAT,
    OperatingCostPerPassenger FLOAT(5, 2),
    PRIMARY KEY (BusID)
);



-- Creating Wanted Table:
CREATE TABLE IF NOT EXISTS GeoLocation (
    OriginCityName VARCHAR(100),
    DestinationCityName VARCHAR(100),
    OriginCityName_Latitude DECIMAL(10, 7),
    OriginCityName_Longitude DECIMAL(10, 7),
    DestinationCityName_Latitude DECIMAL(10, 7),
    DestinationCityName_Longitude DECIMAL(10, 7),
    WeeklyPassengers FLOAT,
    DailyPassengers FLOAT,
    BusID INT,
    OriginDistrict VARCHAR(100),
    DestinationDistrict VARCHAR(100),
    Country VARCHAR(50),
    PRIMARY KEY(BusID),
    FOREIGN KEY (BusID) REFERENCES PublicTransitRoutesData(BusID)
);
-- Bus Passneger TimeSlots Table
CREATE TABLE IF NOT EXISTS BusPassengerTimeSlots (
    BusID INT,
    RouteID VARCHAR(7),
    AgencyName VARCHAR(100),
    ClusterName VARCHAR(100),
    Metropolin VARCHAR(100),
    OriginCityName VARCHAR(100),
    DestinationCityName VARCHAR(100),
    RouteType VARCHAR(50),
    ServiceType VARCHAR(50),
    RouteParticular VARCHAR(50),
    BusType VARCHAR(50),
    BusSize VARCHAR(50),
    Q INT,
    TimeSlot VARCHAR(20),
    Passengers FLOAT,
    Category VARCHAR(50),
    DayHour VARCHAR(50),
    FOREIGN KEY (BusID) REFERENCES PublicTransitRoutesData(BusID)
);

-- Loading the Data:
-- PublicTransitRoutesData Table
LOAD DATA INFILE 'C:/Users/Amir/Desktop/Courses/Data Analysis -Appleseeds/Final Project/PublicTransitRoutesData2.csv'
INTO TABLE PublicTransitRoutesData
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(BusID, RouteID, Q, Year, RouteDirection, DailyRides_Tuesday, WeeklyRides, 
 DailyPassengers, WeeklyPassengers, AVGCommutersPerRide_Weekly, 
 AverageTripDuration, OperatingCostPerPassenger);



-- GeoLocation Table
LOAD DATA INFILE 'C:/Users/Amir/Desktop/Courses/Data Analysis -Appleseeds/Final Project/GeoLocation.csv'
INTO TABLE GeoLocation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OriginCityName, DestinationCityName, OriginCityName_Latitude, OriginCityName_Longitude, 
 DestinationCityName_Latitude, DestinationCityName_Longitude, WeeklyPassengers, 
 DailyPassengers, BusID, OriginDistrict, DestinationDistrict, Country);
-- BusTimeSlots Table:
LOAD DATA INFILE 'C:/Users/Amir/Desktop/Courses/Data Analysis -Appleseeds/Final Project/BusPassengerTimeSlots.csv'
INTO TABLE BusPassengerTimeSlots
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(BusID, RouteID, AgencyName, ClusterName, Metropolin, OriginCityName, 
 DestinationCityName, RouteType, ServiceType, RouteParticular, BusType, BusSize, 
 Q, TimeSlot, Passengers, Category, DayHour);

-- Checking The data if works

SELECT * FROM bus_database.BusPassengerTimeSlots;
SELECT * FROM GeoLocation;
SELECT * FROM PublicTransitRoutesData;

-- Data Cleaning :
DELETE FROM bus_database.buspassengertimeslots
WHERE BusID IN (SELECT BusID FROM bus_database.publictransitroutesdata WHERE OperatingCostPerPassenger >= 999);

DELETE FROM bus_database.geolocation 
WHERE BusID IN (SELECT BusID FROM bus_database.publictransitroutesdata WHERE OperatingCostPerPassenger >= 999);

DELETE FROM bus_database.publictransitroutesdata
WHERE OperatingCostPerPassenger >= 999;



   


