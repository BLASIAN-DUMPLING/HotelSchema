USE hotel;

CREATE TABLE roomType (
roomTypeId INT NOT NULL auto_increment,
roomTypeName VARCHAR (15) NOT NULL,
standardOccupancy INT NOT NULL,
maximumOccupancy INT NOT NULL,
extraPersonCost DECIMAL(10, 2),
CONSTRAINT PK_roomtype PRIMARY KEY (roomTypeId)
);

CREATE TABLE room (
roomId INT NOT NULL , 
roomTypeId INT NOT NULL, 
basePrice DECIMAL(10, 2),
adaAccessible BOOLEAN NOT NULL,
roomAmenities VARCHAR (50)NOT NULL,
CONSTRAINT pk_room  PRIMARY KEY (roomId),
CONSTRAINT fk_room_roomType FOREIGN KEY (roomTypeId)
REFERENCES roomType(roomTypeId)
);

CREATE TABLE guest (
guestId INT NOT NULL auto_increment,
guestName VARCHAR (100) NOT NULL,
address VARCHAR (200) NOT NULL,
city VARCHAR (100) NOT NULL,
stateAbbr VARCHAR (2) NOT NULL,
zipCode CHAR (5) NOT NULL,
phoneNumber VARCHAR (15) NOT NULL,
CONSTRAINT pk_guest PRIMARY KEY (guestId) );

CREATE TABLE reservations (
reservationId INT NOT NULL auto_increment,
roomTypeId INT NOT NULL,
guestName VARCHAR (100) NOT NULL,
startDate DATE NOT NULL,
endDate DATE NOT NULL,
CONSTRAINT pk_reservations PRIMARY KEY (reservationId)
);

CREATE TABLE  reservationinfo (
reservationId INT NOT NULL, 
quantityAdult INT NOT NULL,
quantityChildren INT NOT NULL,
totalCost DECIMAL (10 , 2) NOT NULL,
CONSTRAINT PK_reservationinfo PRIMARY KEY (reservationId),
CONSTRAINT fk_reservations_reservationinfo FOREIGN KEY (reservationID) 
REFERENCES reservations(reservationId)
);











