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
    old_image VARCHAR(100) NOT NULL,
    new_image VARCHAR(100) NOT NULL,
    creationTime TIMESTAMP NOT NULL
);

create table ImageLikes (
    imageID INT(11) NOT NULL,
    userWhoLikedImage VARCHAR(100) NOT NULL,
    unique(imageID, userWhoLikedImage)
);