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
    OperatingCostPerPassenger DOUBLE,
    PRIMARY KEY (BusID)
);



-- Creating Wanted Table:
CREATE TABLE IF NOT EXISTS GeoLocation (
    OriginCityName VARCHAR(100),
    DestinationCityName VARCHAR(100),
    OriginCityName_Latitude FLOAT,
    OriginCityName_Longitude FLOAT,
    DestinationCityName_Latitude FLOAT,
    DestinationCityName_Longitude FLOAT,
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

-- Update the database that supports languages like hebrew:
ALTER DATABASE Bus_Database CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
ALTER TABLE GeoLocation CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE PublicTransitRoutesData CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE BusPassengerTimeSlots CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



-- Data Cleaning After Loading Data in python script that integrated with S3 boto3:
-- DELETE FROM bus_database.buspassengertimeslots
-- WHERE BusID IN (SELECT BusID FROM bus_database.publictransitroutesdata WHERE OperatingCostPerPassenger >= 999);
-- 
-- DELETE FROM bus_database.geolocation 
-- WHERE BusID IN (SELECT BusID FROM bus_database.publictransitroutesdata WHERE OperatingCostPerPassenger >= 999);
-- 
-- DELETE FROM bus_database.publictransitroutesdata
-- WHERE OperatingCostPerPassenger >= 999;