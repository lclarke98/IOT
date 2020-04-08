CREATE DATABASE if not exists climateSensor;

CREATE TABLE if not exists climateSensor.data(
  weatherDataID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  datetime timestamp NOT NULL,
  humidity VARCHAR(88) NOT NULL,
  tempC VARCHAR(88) NOT NULL,
)