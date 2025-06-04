-- Script SQL pour la base FanfareHub
DROP TABLE IF EXISTS AppUser;
DROP TABLE IF EXISTS UserGroup;
DROP TABLE IF EXISTS BelongsToGroup;
DROP TABLE IF EXISTS InstrumentSection;
DROP TABLE IF EXISTS PlaysInSection;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Participation;

CREATE TABLE AppUser (
    userId VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    passwordHash VARCHAR(255) NOT NULL,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'other')),
    dietaryRestriction VARCHAR(20) CHECK (dietaryRestriction IN ('none', 'vegetarian', 'vegan', 'pork-free')),
    creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lastLogin TIMESTAMP NULL,
    isAdmin BOOLEAN DEFAULT FALSE
);

CREATE TABLE UserGroup (
    groupName VARCHAR(100) PRIMARY KEY CHECK (
        groupName IN (
            'commission_prestation',
            'commission_artistique',
            'commission_logistique',
            'commission_communication_interne'
        )
    )
);

CREATE TABLE BelongsToGroup (
    userId VARCHAR(50),
    groupName VARCHAR(100),
    PRIMARY KEY (userId, groupName),
    FOREIGN KEY (userId) REFERENCES AppUser(userId),
    FOREIGN KEY (groupName) REFERENCES UserGroup(groupName)
);

CREATE TABLE InstrumentSection (
    sectionName VARCHAR(100) PRIMARY KEY CHECK (
        sectionName IN (
            'clarinette',
            'saxophone_alto',
            'euphonium',
            'percussion',
            'basse',
            'trompette',
            'saxophone_baryton',
            'trombone'
        )
    )
);

CREATE TABLE PlaysInSection (
    userId VARCHAR(50),
    sectionName VARCHAR(100),
    PRIMARY KEY (userId, sectionName),
    FOREIGN KEY (userId) REFERENCES AppUser(userId),
    FOREIGN KEY (sectionName) REFERENCES InstrumentSection(sectionName)
);

CREATE TABLE Event (
    eventId SERIAL PRIMARY KEY,
    eventName VARCHAR(100) NOT NULL,
    datetime TIMESTAMP NOT NULL,
    duration INTEGER,
    location VARCHAR(100),
    description TEXT,
    userId VARCHAR(50) NOT NULL,
    FOREIGN KEY (userId) REFERENCES AppUser(userId)
);

CREATE TABLE Participation (
    userId VARCHAR(50),
    eventId INTEGER,
    sectionName VARCHAR(100),
    status VARCHAR(10) CHECK (status IN ('present', 'absent', 'uncertain')),
    PRIMARY KEY (userId, eventId, sectionName),
    FOREIGN KEY (userId) REFERENCES AppUser(userId),
    FOREIGN KEY (eventId) REFERENCES Event(eventId),
    FOREIGN KEY (sectionName) REFERENCES InstrumentSection(sectionName)
);
