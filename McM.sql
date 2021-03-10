create database McM;
show databases;
use McM;
show tables;

CREATE TABLE Candidate (
    Candidate_ID INT AUTO_INCREMENT,
    Name VARCHAR(30) NOT NULL,
    Age INT,
    State VARCHAR(50),
    Email VARCHAR(50),
    Experience int,
    Status VARCHAR(10) default 'TBD',
    Ad_Type VARCHAR(10),
    PRIMARY KEY (Candidate_ID),
    CHECK(Age>14)
);

CREATE TABLE Entry (
    Entry_ID INT,
    File_Type VARCHAR(500) NOT NULL,
    URL VARCHAR(500) NOT NULL,
    Candidate_ID INT REFERENCES Candidate (Candidate_ID)
    ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(Entry_ID,Candidate_ID)
);

CREATE TABLE Panelist (
	Panelist_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Phone_Number VARCHAR(10),
    Email varchar(50),
    Experience int,
    Association int);
    
CREATE TABLE Music_group (
	Group_Number INT AUTO_INCREMENT PRIMARY KEY,
    G_Type varchar(20) NOT NULL
);

CREATE TABLE Album (
	Album_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Type VARCHAR(10) NOT NULL,
    Date_of_release DATE,
    IsApproved varchar(10) default'TBD',
    Number_Of_Likes INT,
    Number_Of_Dislikes INT,
    Number_Of_Visits INT,
    Price INT,
    Group_Number INT REFERENCES Music_group(Group_Number)
);

CREATE TABLE Member (
	Member_ID INT AUTO_INCREMENT PRIMARY KEY,
    Role VARCHAR(50),
    Candidate_ID INT REFERENCES Candidate(Candidate_ID)
);

CREATE TABLE Distributor (
	D_ID INT AUTO_INCREMENT PRIMARY KEY,
    URL VARCHAR(500) UNIQUE
);

CREATE TABLE Downloads (
	Downloads_ID INT AUTO_INCREMENT PRIMARY KEY,
    Status VARCHAR(10),
    Date date,
    URL VARCHAR(500) REFERENCES Distributor(URL),
    D_ID INT REFERENCES Distributor(D_ID),
    Album_ID INT REFERENCES Album(Album_ID),
    CHECK(Status in('Success','Failure'))
);

CREATE TABLE Judge (
	Panelist_ID INT REFERENCES Panelist(Panelist_ID),
    Candidate_ID INT REFERENCES Candidate(Candidate_ID),
    Result varchar(10),
    PRIMARY KEY(Panelist_ID,Candidate_ID)
);

CREATE TABLE Negotiate (
	Album_ID INT REFERENCES Album(Album_ID),
    D_ID INT REFERENCES Distributor(D_ID),
    Final_Price INT,
    PRIMARY KEY(Album_ID,D_ID)
);

CREATE TABLE Alb_Mem (
	Album_ID INT REFERENCES Album(Album_ID),
    Member_ID INT REFERENCES Group_member(Member_ID),
    Role VARCHAR(20),
    PRIMARY KEY(Album_ID,Member_ID)
);

CREATE TABLE Group_Join (
	Member_ID INT REFERENCES Group_member(Member_ID),
    Group_Number INT REFERENCES Music_group(Group_Number),
    PRIMARY KEY(Member_ID,Group_Number)
);

CREATE TABLE Phone_Numbers (
	Candidate_ID INT REFERENCES Candidate(Candidate_ID),
    Phone_Number VARCHAR(10),
    PRIMARY KEY(Candidate_ID,Phone_Number)
);