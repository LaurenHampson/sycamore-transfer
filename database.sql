drop DATABASE if exists UserProfiles;
CREATE DATABASE UserProfiles;
USE UserProfiles;
CREATE TABLE Users (
    email VARCHAR(50) PRIMARY KEY NOT NULL, 
    username VARCHAR(50) NOT NULL,
    password VARCHAR (200) NOT NULL
);

create table Images (
    imageID INT(11) primary key auto_increment,
    username VARCHAR(50) NOT NULL,
    foreign key fkUsername (username) references Users(username)
    old_image VARCHAR(100) NOT NULL,
    new_image VARCHAR(100) NOT NULL,
    creationTime TIMESTAMP NOT NULL
);