create database McM;
show databases;
use McM;
show tables;

select * from Album Where (YEAR(Date_of_release)='2020' AND Type='Audio');
select * from Member where Member_ID in (select Member_ID from Group_Join group by Member_ID having count(*)>1);
select * from Member where(select Member_ID in(select Member_ID from Group_Join where Group_Number in(select Group_Number from Music_Group where G_Type='POP' ) )and  Member_ID in(select Member_ID from Group_Join Group by Member_ID having count(*)=1));
select * from Candidate where (Candidate_ID in(select Candidate_ID from Entry where File_Type='Audio' ) and  Candidate_ID in (select Candidate_ID from Entry where File_Type='Video')); 
select Ad_Type, COUNT(*) AS val FROM Entry, Candidate WHERE Candidate.Candidate_ID = Entry.Candidate_ID GROUP BY Candidate.Ad_Type ORDER BY COUNT(*) DESC LIMIT 1;

select A.State,COUNT(A.Candidate_ID) FROM Candidate as A, Entry as B WHERE A.Candidate_ID = B.Candidate_ID GROUP BY A.State;
select COUNT(File_Type) FROM Entry GROUP BY File_Type;
select SUM(CASE WHEN Age BETWEEN 15 AND 20 THEN 1 ELSE 0 END ) AS val1, SUM(CASE WHEN Age BETWEEN 21 AND 25 THEN 1 ELSE 0 END ) AS val2, SUM(CASE WHEN Age BETWEEN 26 AND 30 THEN 1 ELSE 0 END ) AS val3, SUM(CASE WHEN Age BETWEEN 31 AND 40 THEN 1 ELSE 0 END ) AS val4, SUM(CASE WHEN Age BETWEEN 41 AND 100 THEN 1 ELSE 0 END ) AS val5 FROM Candidate;



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