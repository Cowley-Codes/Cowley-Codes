/*Creating Database and Tables*/
CREATE DATABASE crossFit_open;
USE crossfit_Open;

CREATE TABLE gyms(
Gym_id INT NOT NULL PRIMARY KEY,
Gname VARCHAR(200) NOT NULL,
City VARCHAR(100));

CREATE TABLE athletes(
Ath_id INT NOT NULL PRIMARY KEY,
Fname VARCHAR(100) NOT NULL,
Sname VARCHAR(100) NOT NULL,
Email VARCHAR(200),
Gender ENUM('f','m') NOT NULL);

CREATE TABLE ath_gym(
Ath_id INT NOT NULL,
Gym_id INT NOT NULL,
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id),
FOREIGN KEY (Gym_id) REFERENCES gyms(Gym_id));

CREATE TABLE wod1f(
Ath_id INT NOT NULL,
Category ENUM('RX','Ma','Sc') NOT NULL DEFAULT 'Sc',
Score1 TIME DEFAULT '00:12:01',
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id));

CREATE TABLE wod1m(
Ath_id INT NOT NULL,
Category ENUM('RX','Ma','Sc') NOT NULL DEFAULT 'Sc',
Score1 TIME DEFAULT '00:12:01',
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id));

CREATE TABLE wod2f(
Ath_id INT NOT NULL,
Category ENUM('RX','Ma','Sc') NOT NULL DEFAULT 'Sc',
Score2 INT DEFAULT 0,
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id));

CREATE TABLE wod2m(
Ath_id INT NOT NULL,
Category ENUM('RX','Ma','Sc') NOT NULL DEFAULT 'Sc',
Score2 INT DEFAULT 0,
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id));

CREATE TABLE wod3f(
Ath_id INT NOT NULL,
Category ENUM('RX','Ma','Sc') NOT NULL DEFAULT 'Sc',
Score3 DEC(5,2) DEFAULT '000.00',
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id));

CREATE TABLE wod3m(
Ath_id INT NOT NULL,
Category ENUM('RX','Ma','Sc') NOT NULL DEFAULT 'Sc',
Score3 DEC(5,2) DEFAULT '000.00',
FOREIGN KEY (Ath_id) REFERENCES athletes(Ath_id));

/* Populating Tables */

INSERT INTO gyms
(Gym_id, Gname, City)
VALUES
(1, 'MSquared Fitness', 'Manchester'),
(2, 'Box CrossFit', 'Birmingham'),
(3, 'BRICK', 'Cardiff'),
(4, 'CrossFit Queens', 'Nottingham'),
(5, 'Trinity', 'Leeds'),
(6, '1st Rep', 'Portsmouth'),
(7, 'CrossFit 2000', 'Bath'),
(8, 'RH10 Crossfit', 'London'),
(9, 'SweatShed', 'Kent'),
(10, 'CrossFit Ancoats', 'Manchester'),
(11, 'Gorilla Warfare', 'Sheffield'),
(12, 'The Workshop', 'Liverpool');

INSERT INTO Athletes
(Ath_id, Fname, Sname, Email, Gender)
VALUES
(1, 'Adam', 'Dowdall', 'adamd@gmail.com','m'),
(2, 'Lee', 'Davis', 'leed@hotmail.com','m'),
(3, 'Chloe', 'Brady', 'chloeee@gmail.com','f'),
(4, 'Alannah', 'Cowley', 'alannahbanana@gmail.com','f'),
(5, 'Co', 'McClure', null,'m'),
(6, 'Flora', 'Barton', 'fbarton@gmail.com','f'),
(7, 'Joey', 'Russell', 'joeyr@hotmail.com','f'),
(8, 'Joe', 'Taylor', 'jtaylor@gmail.com','m'),
(9, 'Anna', 'Penny', 'apenny321@msn.com','f'),
(10, 'Stef', 'Hartley', 'stefh@hotmail.com','f'),
(11, 'Mike', 'Edwards', 'medwards@gmail.com','m'),
(12, 'Mike', 'Warden', 'bigmike@hotmail.com','m'),
(13, 'Holly', 'Shanor', 'hollysss@hotmail.com','f'),
(14, 'Eric', 'Apton', 'notthateric@gmail.com','m'),
(15, 'James', 'McGolfin', 'jmcgolf@gmail.com','m'),
(16, 'Lisa', 'Kordek', 'lisak@hotmail.com','f'),
(17, 'Alice', 'Forman', 'alicef@gmail.com','f'),
(18, 'Andy', 'Rivers', 'andyr@hotmail.com','m'),
(19, 'Ruth', 'Rivers', 'riversruth@yahoo.com','f'),
(20, 'Gabriel', 'Angel', 'angelgabriel@talktalk.com','m'),
(21, 'Mel', 'Gatherer', 'melgath@hotmail.com','f'),
(22, 'Ash', 'Podman', 'ashhhhp@hotmail.com','m'),
(23, 'Kate', 'Stables', 'kateloveshorses@hotmail.com','f'),
(24, 'Chris', 'Burton', 'Chrislovesburpees@gmail.com','m'),
(25, 'Roisin', 'Burton', 'RoshBHair@hotmail.com','f'),
(26, 'James', 'Anderson', 'OhJimmyJimmy@gmail.com','m'),
(27, 'Stuart', 'Broad', 'Broady@hotmail.com','m'),
(28, 'Olly', 'Pope', 'ollysinnings@hotmail.com','m'),
(29, 'Mark', 'Wood', 'woody@hotmail.com','m'),
(30, 'Ben', 'Stokes', 'stokesy@gmail.com','m'),
(31, 'Zak', 'Crawley', 'crawley@gmail.com','m'),
(32, 'Ben', 'Duckett', 'benbats@hotmail.com','m'),
(33, 'Joe', 'Root', 'rootscoops@hotmail.com','m'),
(34, 'Jonny', 'Bairstow', 'gingerscanbat@hotmail.com','m'),
(35, 'Ben', 'Foakes', 'foakesisakeeper@hotmail.com','m'),
(36, 'Rehan', 'Ahmed', 'rehangetswickets@hotmail.com','m'),
(37, 'Tom', 'Hartley', 'tombowls@gmail.com','m'),
(38, 'Shoaib', 'Bashir', 'shoaibspins@hotmail.com','m'),
(39, 'Fi', 'Doin', 'fidoin@gmail.com','f'),
(40, 'Tess', 'Doin', 'tdoin@gmail.com','f'),
(41, 'Emma', 'Fage', 'swimwods@gmail.com','f'),
(42, 'Emma', 'Valley', 'mumwods@gmail.com','f'),
(43, 'Em', 'Savage', 'emcoach@gmail.com','f'),
(44, 'James', 'Wilson', 'coachscouse12@hotmail.com','m'),
(45, 'Sam', 'Dale', 'samdale@yahoo.com','m'),
(46, 'Dale', 'Samson', 'dalesamson@gmail.com','m'),
(47, 'Paolo', 'Soprano', 'psoprano@sky.com','m'),
(48, 'Rita', 'Soprano', 'rsoprano@sky.com','f'),
(49, 'Laura', 'Burns', 'laurab@yahoo.com','f'),
(50, 'Laura', 'Richman', 'lrichman@gmail.com','f'),
(51, 'Dan', 'Richman', 'drichman@gmail.com','m'),
(52, 'Klare', 'Osbourne', 'klos@hotmail.com','f'),
(53, 'Maddy', 'Hunstman', 'mhunts@hotmail.com','f'),
(54, 'Afshin', 'Sia', 'afshinoperates@gmail.com','m'),
(55, 'Kian', 'Sia', 'kianstudies@gmail.com','m'),
(56, 'Moni', 'Sia', 'monis@gmail.com','f'),
(57, 'Lucy', 'Truman', 'lucyyyyyt@hotmail.com','f'),
(58, 'Lisa', 'Casper', 'lisacasper@gmail.com','f'),
(59, 'Paul', 'Casper', 'paulcasper@gmail.com','m'),
(60, 'Lance', 'Spinner', 'djlance@hotmail.com','m');

INSERT INTO Ath_Gym
(Ath_id, Gym_id)
VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(9,2),
(10,2),
(11,2),
(12,2),
(13,2),
(14,3),
(15,3),
(16,3),
(17,3),
(7,7),
(8,7),
(18,12),
(19,12),
(20,12),
(21,12),
(22,12),
(23,12),
(24,12),
(25,12),
(26,9),
(27,9),
(28,9),
(29,9),
(30,9),
(31,9),
(32,9),
(33,9),
(34,9),
(35,9),
(36,9),
(37,9),
(38,9),
(39,11),
(40,11),
(41,11),
(42,11),
(43,11),
(44,11),
(45,8),
(46,8),
(47,10),
(48,10),
(49,10),
(50,5),
(51,5),
(52,5),
(53,4),
(54,5),
(55,5),
(56,5),
(57,4),
(58,6),
(59,6),
(60,6);

INSERT INTO WOD1M
(Ath_id, Category, Score1)
VALUES
(1, 'RX', '00:09:52'),
(2, 'RX', '00:10:14'),
(5, 'Ma', '00:11:59'),
(11, 'Ma', '00:11:09'),
(12, 'Sc', '00:09:14'),
(8,'RX', '00:11:54'),
(14,'RX', '00:10:51'),
(15, 'RX','00:09:44'),
(18, 'Ma','00:11:17'),
(20,'RX','00:11:21'),
(22,'Sc', '00:09:37'),
(24,'Sc', '00:09:12'),
(26,'RX', '00:10:38'),
(27,'RX', '00:10:01'),
(28,'RX', '00:08:56'),
(29,'RX', '00:09:17'),
(30,'RX','00:10:32'),
(31, 'Sc','00:10:32'),
(32, 'Sc', '00:11:01'),
(33,'Ma', '00:11:22'),
(34,'Sc', '00:10:36'),
(35,'Ma','00:10:02'),
(36,'Sc', '00:11:19'),
(37, 'Sc', '00:10:49'),
(38, 'Sc','00:09:54'),
(44,'RX', '00:09:52'),
(45,'RX', '00:10:14'),
(46, 'RX', '00:11:54'),
(51,'RX', '00:10:27'),
(54,'Ma', '00:11:58'),
(55, 'Sc', '00:10:29'),
(59,'Ma','00:11:11'),
(60,'RX','00:10:04');

/*Paolo's no score for this workout demonstrates the need for the default to be longer than the timecap, so that in later ranking he is placed last for this round.*/ 

INSERT INTO WOD1M
(Ath_id, Category)
VALUES
(47,'Sc');

INSERT INTO WOD2M
(Ath_id, Category, Score2)
VALUES
(1, 'RX', 140),
(2, 'RX', 129),
(5, 'Ma', 130),
(8,'RX', 134),
(11, 'Ma', 132),
(12, 'Ma', 141),
(14,'RX', 128),
(15, 'RX',149),
(18, 'Ma', 139),
(20,'RX', 128),
(22,'Sc', 141), 
(24,'Sc', 145),
(26,'RX', 119),
(27,'RX', 124),
(28,'RX', 139),
(29,'RX', 133),
(30,'RX', 148),
(31, 'Sc',159),
(32, 'Sc',108),
(33,'Ma', 119),
(34,'RX', 130),
(35,'Sc', 129),
(36,'Sc', 135),
(37, 'Sc', 138),
(38, 'Sc',139),
(44,'RX', 120),
(45,'RX', 140),
(46, 'RX', 143),
(47,'Sc', 120),
(51,'Ma', 148), 
(54,'Ma', 109),
(55, 'Sc', 141),
(59,'RX', 137),
(60,'RX',136);

INSERT INTO WOD3M
(Ath_id, Category, Score3)
VALUES
(1, 'RX', 85.75), 
(2, 'Sc', 90),
(5, 'Ma', 75), 
(8,'RX', 95),
(11, 'Ma', 62.5),
(12, 'Ma', 67.25),
(14,'Sc', 82.5), 
(15, 'RX', 102.5),
(18, 'Ma', 87.25),
(20,'RX', 92.5),
(22,'Sc', 77.5),
(24,'Sc', 72.75),
(26,'Ma', 75), 
(27,'Ma', 72.5), 
(28,'RX', 73.75),
(29,'RX', 62.25),
(30,'RX',97.25),
(31, 'Sc', 67.5),
(32, 'Sc',57.75),
(33,'Ma', 81.25),
(34,'Sc', 82.5),
(35,'Ma', 77.5),
(36,'Sc', 52.5),
(37, 'Sc', 60),
(38, 'Sc', 52.5),
(44,'RX', 100),
(45,'RX', 82.5), 
(46, 'RX', 82),
(47,'Ma', 83.75),
(51,'RX', 97.5),
(54,'Ma', 77.5),
(55, 'Sc', 80),
(59,'Ma', 92.5),
(60,'RX',105);

INSERT INTO WOD1F
(Ath_id, Category, Score1)
VALUES
(3, 'Sc', '00:11:01'),
(4, 'Sc', '00:11:10'),
(6, 'Ma', '00:11:07'),
(9, 'RX', '00:11:19'),
(10, 'RX', '00:10:49'),
(13, 'Sc', '00:10:52'),
(7, 'Sc', '00:11:48'),
(16, 'RX', '00:09:50'),
(17, 'RX', '00:09:50'),
(19, 'Ma', '00:12:00'),
(21, 'RX', '00:10:05'),
(23, 'RX', '00:10:29'),
(25, 'Sc', '00:11:21'),
(39, 'RX', '00:10:08'),
(40, 'RX', '00:10:58'),
(41, 'Sc', '00:11:15'),
(42, 'RX', '00:10:40'),
(43, 'RX', '00:09:46'),
(48, 'Sc', '00:11:41'),
(49, 'Ma', '00:11:01'),
(50, 'Sc', '00:10:59'),
(52, 'RX', '00:08:49'),
(53, 'RX', '00:09:29'),
(56, 'Sc', '00:11:49'),
(57, 'RX', '00:10:21'),
(58,'Ma', '00:10:21');

INSERT INTO WOD2F
(Ath_id, Category, Score2)
VALUES
(3, 'Sc', 142),
(4, 'RX', 138),
(6, 'Ma', 143),
(9, 'Sc', 151),
(10, 'RX', 138),
(13, 'Sc', 140),
(16, 'RX', 139),
(17, 'RX', 142),
(7, 'Sc', 130),
(19, 'Ma', 112),
(21, 'RX', 143),
(23, 'RX', 139),
(25, 'Sc', 135),
(39, 'RX', 134),
(40, 'RX', 137),
(41, 'RX', 122),
(42, 'RX', 123),
(43, 'RX', 138),
(48, 'RX', 124),
(49, 'Ma', 138),
(50, 'Sc', 129),
(52, 'RX', 145),
(53, 'RX', 140),
(56, 'Sc', 117),
(57, 'RX', 137),
(58,'RX', 129);


INSERT INTO WOD3F
(Ath_id, Category, Score3)
VALUES
(3, 'Sc', 52.5),
(4, 'Sc', 60),
(6, 'Ma', 50),
(9, 'Sc', 62.5),
(10, 'RX', 72.25),
(13, 'RX', 70.5),
(17, 'RX', 75),
(16, 'RX', 72.5),
(7, 'Sc', 55.75),
(19, 'Sc', 75),
(21, 'RX', 77.5),
(23, 'RX', 72.5),
(25, 'Sc', 57.25),
(39, 'RX', 77.75),
(40, 'RX', 68.5),
(41, 'Sc', 65),
(42, 'Sc', 72.5),
(43, 'RX', 75.25),
(48, 'Sc', 65.25),
(49, 'Ma', 58.5),
(50, 'Sc', 47.5),
(52, 'RX', 62.5),
(53, 'RX', 72.5),
(56, 'Sc', 42.25),
(57, 'RX', 67.5),
(58,'Ma', 60);

/* Views */

/* For 3NF Athlete and Gym Details are stored in separate tables, however it is useful for podium announcements etc to view full athlete and gym details together.*/

CREATE VIEW Athlete_Registration AS
SELECT 
	a.Ath_id, 
    a.FName, 
    a.SName, 
    a.Email, 
    a.Gender, 
    g.GName, 
    g.City, 
    g.Gym_id
FROM 
Athletes a
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id;

/* The following views allow athletes to see their score and rank in each workout, they are ranked both within category and overall. Contact details are not included here for privacy.*/

CREATE VIEW MWOD3 AS
SELECT
	a.Ath_id, 
	a.FName, 
	a.SName, 
    g.GName,
    g.City,
	3m.Category, 
	3m.Score3,
	DENSE_RANK()
		OVER (PARTITION BY 3m.Category ORDER BY 3m.Category,3m.Score3 DESC)
		AS Rankc3m,
	DENSE_RANK() 
		OVER (ORDER BY 3m.Category,3m.Score3 DESC)
        AS Ranka3m
FROM Athletes a
LEFT JOIN WOD3M 3m
ON a.Ath_id=3m.Ath_id
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id
WHERE a.Gender='m'
ORDER BY Category,Ranka3m;


CREATE VIEW FWOD3 AS
SELECT
	a.Ath_id, 
	a.FName, 
	a.SName, 
    g.GName,
    g.City,
	3f.Category, 
	3f.Score3,
	DENSE_RANK()
		OVER (PARTITION BY 3f.Category ORDER BY 3f.Category,3f.Score3 DESC)
		AS Rankc3f,
	DENSE_RANK() 
		OVER (ORDER BY 3f.Category,3f.Score3 DESC)
        AS Ranka3f
FROM Athletes a
LEFT JOIN WOD3F 3f
ON a.Ath_id=3f.Ath_id
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id
WHERE a.Gender='f'
ORDER BY Category,Ranka3f;

CREATE VIEW MWOD2 AS
SELECT
	a.Ath_id, 
	a.FName, 
	a.SName, 
    g.GName,
    g.City,
	2m.Category, 
	2m.Score2,
	DENSE_RANK()
		OVER (PARTITION BY 2m.Category ORDER BY 2m.Category,2m.Score2 DESC)
		AS Rankc2m,
	DENSE_RANK() 
		OVER (ORDER BY 2m.Category,2m.Score2 DESC)
        AS Ranka2m
FROM Athletes a
LEFT JOIN WOD2M 2m
ON a.Ath_id=2m.Ath_id
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id
WHERE a.Gender='m'
ORDER BY Category,Ranka2m;


CREATE VIEW FWOD2 AS
SELECT
	a.Ath_id, 
	a.FName, 
	a.SName, 
    g.GName,
    g.City,
	2f.Category, 
	2f.Score2,
	DENSE_RANK()
		OVER (PARTITION BY 2f.Category ORDER BY 2f.Category,2f.Score2 DESC)
		AS Rankc2f,
	DENSE_RANK() 
		OVER (ORDER BY 2f.Category,2f.Score2 DESC)
        AS Ranka2f
FROM Athletes a
LEFT JOIN WOD2F 2f
ON a.Ath_id=2f.Ath_id
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id
WHERE a.Gender='f'
ORDER BY Category,Ranka2f;

CREATE VIEW MWOD1 AS
SELECT
	a.Ath_id, 
	a.FName, 
	a.SName, 
    g.GName,
    g.City,
	1m.Category, 
	1m.Score1,
	DENSE_RANK()
		OVER (PARTITION BY 1m.Category ORDER BY 1m.Category,1m.Score1 ASC)
		AS Rankc1m,
	DENSE_RANK() 
		OVER (ORDER BY 1m.Category,1m.Score1 ASC)
        AS Ranka1m
FROM Athletes a
LEFT JOIN WOD1M 1m
ON a.Ath_id=1m.Ath_id
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id
WHERE a.Gender='m'
ORDER BY Category,Ranka1m;


CREATE VIEW FWOD1 AS
SELECT
	a.Ath_id, 
	a.FName, 
	a.SName, 
    g.GName,
    g.City,
	1f.Category, 
	1f.Score1,
	DENSE_RANK()
		OVER (PARTITION BY 1f.Category ORDER BY 1f.Category,1f.Score1 ASC)
		AS Rankc1f,
	DENSE_RANK() 
		OVER (ORDER BY 1f.Category,1f.Score1 ASC)
        AS Ranka1f
FROM Athletes a
LEFT JOIN WOD1F 1f
ON a.Ath_id=1f.Ath_id
LEFT JOIN Ath_Gym ag
ON a.Ath_id=ag.Ath_id
LEFT JOIN Gyms g
ON ag.Gym_id=g.Gym_id
WHERE a.Gender='f'
ORDER BY Category,Ranka1f;

/* These views allow the athletes to see how they rank within category and overall for the workout e.g. */

SELECT* 
FROM
FWOD1;

/* The following views allow Gyms to see how they rank in each WOD for women & men */

CREATE VIEW Gyms_Rank_3M AS
SELECT 
	GName,
	SUM(Ranka3m) AS Gym_Points_3M,
	COUNT(*) AS Entries3M,
	RANK () OVER (ORDER BY Gym_Points_3M/Entries3M) AS Gyms_3M_Rank
FROM 
MWOD3
GROUP BY GName;


CREATE VIEW Gyms_Rank_2M AS
SELECT 
	GName,
	SUM(Ranka2m) AS Gym_Points_2M,
	COUNT(*) AS Entries2M,
	RANK () OVER (ORDER BY Gym_Points_2M/Entries2M) AS Gyms_2M_Rank
FROM 
MWOD2
GROUP BY GName;

CREATE VIEW Gyms_Rank_1M AS
SELECT 
	GName,
	SUM(Ranka1m) AS Gym_Points_1M,
	COUNT(*) AS Entries1M,
	RANK () OVER (ORDER BY Gym_Points_1M/Entries1M) AS Gyms_1M_Rank
FROM 
MWOD1
GROUP BY GName;

CREATE VIEW Gyms_Rank_3F AS
SELECT 
	GName,
	SUM(Ranka3f) AS Gym_Points_3F,
	COUNT(*) AS Entries3F,
	RANK () OVER (ORDER BY Gym_Points_3F/Entries3F) AS Gyms_3F_Rank
FROM 
FWOD3
GROUP BY GName;

CREATE VIEW Gyms_Rank_2F AS
SELECT 
	GName,
	SUM(Ranka2f) AS Gym_Points_2F,
	COUNT(*) AS Entries2F,
	RANK () OVER (ORDER BY Gym_Points_2F/Entries2F) AS Gyms_2F_Rank
FROM 
FWOD2
GROUP BY GName;

CREATE VIEW Gyms_Rank_1F AS
SELECT 
	GName,
	SUM(Ranka1f) AS Gym_Points_1F,
	COUNT(*) AS Entries1F,
	RANK () OVER (ORDER BY Gym_Points_1F/Entries1F) AS Gyms_1F_Rank
FROM 
FWOD1
GROUP BY GName;

/* Gyms can then analyse their performance across the 3 workouts to see whether their strengths are what they thought and how they can adjust programming to improve on weaknesses*/

SELECT a.GName, a.Gyms_1F_Rank, f.Gyms_1M_Rank, b.Gyms_2F_Rank, e.Gyms_2M_Rank, c.Gyms_3F_Rank, d.Gyms_3M_Rank
FROM 
Gyms_Rank_1f a
LEFT JOIN
Gyms_Rank_2f b
ON a.GName=b.GName
LEFT JOIN
Gyms_Rank_3f c
ON b.GName=c.GName
LEFT JOIN
Gyms_Rank_3m d
ON d.GName=c.GName
LEFT JOIN
Gyms_Rank_2m e
ON d.GName=e.GName
LEFT JOIN
Gyms_Rank_1m f
ON f.GName=e.GName;

/* The following views show the overall Open ranking for Athletes, there is no category filtering as an athlete may not keep the same category throughout*/

CREATE VIEW Open_F AS
SELECT
	f1.Ath_id,
	f1.FName,
	f1.SName,
	f1.GName,
	f1.City,
	f1.Ranka1f,
	f2.Ranka2f,
	f3.Ranka3f,
	DENSE_RANK() OVER (ORDER BY f1.Ranka1f+f2.Ranka2f+f3.Ranka3f) AS Open_Rank
FROM
FWOD1 f1
LEFT JOIN
FWOD2 f2
ON f1.Ath_id=f2.Ath_id
LEFT JOIN
FWOD3 f3
ON f2.Ath_id=f3.Ath_id;

CREATE VIEW Open_M AS
SELECT
	m1.Ath_id,
	m1.FName,
	m1.SName,
	m1.GName,
	m1.City,
	m1.Ranka1m,
	m2.Ranka2m,
	m3.Ranka3m,
	DENSE_RANK() OVER (ORDER BY m1.Ranka1m+m2.Ranka2m+m3.Ranka3m) AS Open_Rank
FROM
MWOD1 m1
LEFT JOIN
MWOD2 m2
ON m1.Ath_id=m2.Ath_id
LEFT JOIN
MWOD3 m3
ON m2.Ath_id=m3.Ath_id;

SELECT*
FROM
Open_F;

/* Finally, these views allow Gyms to see how they score overall in the Open for men and women.*/

CREATE VIEW Gyms_Open_F AS
SELECT 
GName,
SUM(Open_Rank) AS Gym_Points_Open,
COUNT(*) AS EntriesO,
RANK () OVER (ORDER BY Gym_Points_Open/EntriesO) AS Open_Rank
FROM Open_F
GROUP BY GName;

CREATE VIEW Gyms_Open_M AS
SELECT 
GName,
SUM(Open_Rank) AS Gym_Points_Open,
COUNT(*) AS EntriesO,
RANK () OVER (ORDER BY Gym_Points_Open/EntriesO) AS Open_Rank
FROM Open_M
GROUP BY GName;

/* Stored Procdure - so that I can easily access the 'score to beat' for any athlete enquiring after the current highest score in their category for a given workout.*/

DELIMITER //

CREATE PROCEDURE Score_To_Beat
(in_WOD CHAR(2), in_category ENUM('RX', 'Ma', 'Sc'))
BEGIN
	IF in_WOD='1F'
    THEN
	SELECT 
		MIN(Score1) AS Score_To_Beat
	FROM 
	WOD1F
	WHERE WOD1F.Category = in_category;
    ELSE IF in_WOD='1M'
    THEN
	SELECT 
		MIN(Score1) AS Score_To_Beat
	FROM 
	WOD1M
	WHERE WOD1M.Category = in_category;
    ELSE IF
    in_WOD='2F'
    THEN
	SELECT 
		MAX(Score2) AS Score_To_Beat
	FROM 
	WOD2F
	WHERE WOD2F.Category = in_category;
    ELSE IF
    in_WOD='2M'
    THEN
	SELECT 
		MAX(Score2) AS Score_To_Beat
	FROM 
	WOD2M
	WHERE WOD2M.Category = in_category;
	ELSE IF
    in_WOD='3F'
    THEN
	SELECT 
		MAX(Score3) AS Score_To_Beat
	FROM 
	WOD3F
	WHERE WOD3F.Category = in_category;
	ELSE IF
    in_WOD='3M'
    THEN
	SELECT 
		MAX(Score3) AS Score_To_Beat
	FROM 
	WOD3M
	WHERE WOD3M.Category = in_category;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END//

DELIMITER ;

/* Example, to find the current fastest time by a female masters athlete in WOD1 */

CALL Score_To_Beat('1F', 'Ma');

/* 10:21 is the fastest time to beat for female masters athletes in WOD1.*/

/* Stored Procedure - so that I can find the current minimum score in RX for any workout, to inform the top Masters and Scaled athletes what they need to aim for in order to be competitive in the field above. Some may choose to re-do the workout in RX.*/

DELIMITER //

CREATE PROCEDURE Score_To_Reach
(in_WOD CHAR(2))
BEGIN
	IF in_WOD='1F'
    THEN
	SELECT 
		MAX(Score1) AS Score_To_Reach
	FROM 
	WOD1F
	WHERE WOD1F.Category = 'RX';
    ELSE IF in_WOD='1M'
    THEN
	SELECT 
		MAX(Score1) AS Score_To_Reach
	FROM 
	WOD1M
	WHERE WOD1M.Category = 'RX';
    ELSE IF
    in_WOD='2F'
    THEN
	SELECT 
		MIN(Score2) AS Score_To_Reach
	FROM 
	WOD2F
	WHERE WOD2F.Category = 'RX';
    ELSE IF
    in_WOD='2M'
    THEN
	SELECT 
		MIN(Score2) AS Score_To_Reach
	FROM 
	WOD2M
	WHERE WOD2M.Category = 'RX';
	ELSE IF
    in_WOD='3F'
    THEN
	SELECT 
		MIN(Score3) AS Score_To_Reach
	FROM 
	WOD3F
	WHERE WOD3F.Category = 'RX';
	ELSE IF
    in_WOD='3M'
    THEN
	SELECT 
		MIN(Score3) AS Score_To_Reach
	FROM 
	WOD3M
	WHERE WOD3M.Category = 'RX';
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END//

DELIMITER ;

/* Example - find the top scaled score in the men's WOD2 and the score to reach for RX to help this athlete decide whether he can make the reps in the higher weight category.*/

CALL Score_To_Beat('2M', 'Sc'); /* His score is 159 reps */
CALL Score_To_Reach('2M'); /* The least score in RX is 119 reps, so he should definitely give it a go at RX weight.*/

/* For rapid sign up of new athletes */

DELIMITER //

CREATE PROCEDURE New_Athlete(
IN Ath_id INT, 
IN FName VARCHAR(100),
IN SName VARCHAR(100),
IN Email VARCHAR(200),
IN Gender ENUM('M','F'))
BEGIN
INSERT INTO Athletes (Ath_id, FName, SName, Email, Gender)
VALUES(Ath_id, FName, SName, Email, Gender);
END//

DELIMITER ;

/* Trigger to set up new row ready for entry in each applicable workout when a new athlete registers.*/

DELIMITER //

CREATE TRIGGER New_Ath1
AFTER INSERT
ON Athletes
FOR EACH ROW
BEGIN
    IF NEW.Gender = 'f' THEN
		INSERT INTO WOD1F (Ath_id) VALUES (NEW.Ath_id);
    ELSEIF NEW.Gender = 'm' THEN
		INSERT INTO WOD1M (Ath_id) VALUES (NEW.Ath_id);
    END IF;
END;
//

CREATE TRIGGER New_Ath2
AFTER INSERT
ON Athletes
FOR EACH ROW
BEGIN
    IF NEW.Gender = 'f' THEN
		INSERT INTO WOD2F (Ath_id) VALUES (NEW.Ath_id);
    ELSEIF NEW.Gender = 'm' THEN
		INSERT INTO WOD2M (Ath_id) VALUES (NEW.Ath_id);
    END IF;
END;
//

CREATE TRIGGER New_Ath3
AFTER INSERT
ON Athletes
FOR EACH ROW
BEGIN
    IF NEW.Gender = 'f' THEN
		INSERT INTO WOD3F (Ath_id) VALUES (NEW.Ath_id);
    ELSEIF NEW.Gender = 'm' THEN
		INSERT INTO WOD3M (Ath_id) VALUES (NEW.Ath_id);
    END IF;
END;
//

/*Example - new athletes Emma & Ian */

DELIMITER ;

CALL New_Athlete (61, 'Emma', 'McWheat', 'emmamcw@hotmail.com', 'f');
CALL New_Athlete (62, 'Ian', 'McWheat', 'ianmcw@hotmail.com', 'm');

INSERT INTO Ath_Gym
(Ath_id, Gym_id)
VALUES
(61, 7),
(62, 7);

SELECT*
FROM
Athletes;

/* Emma & Ian are now visible in the Athletes table now, and they each have had a row inserted into workouts 1,2 & 3 which take the default values and so place them bottom of the table until they update with scores.*/

/* Stored Function - So that I can find the athletes in podium places in each category for each workout */
/* I want to send podium congratulations 
out and so need to find the email 
addresses of the top 3 male athletes for 
each category in WOD3. I can apply the stored 
function Placed to a subquery using the 
category ranked scores. */ 

DELIMITER //

//
CREATE FUNCTION 
	Placed
	(Rankc INT)
RETURNS VARCHAR(30)
DETERMINISTIC 
BEGIN 
	DECLARE Placed VARCHAR(30);
    IF Rankc>3 THEN
		SET Placed='No Podium';
	ELSE IF Rankc=3 THEN
		SET Placed='Bronze in category';
	ELSE IF Rankc=2 THEN 
		SET Placed='Silver in category';
	ELSE IF Rankc=1 THEN
		SET Placed='Gold in category';
	END IF;
    END IF;
    END IF;
    END IF;
RETURN (Placed);
END //

DELIMITER ;

SELECT*,
	Placed(Rankc)
FROM
	(SELECT
	m3.Ath_id, 
	m3.FName, 
	m3.SName, 
    ag.Email,
    ag.GName,
    ag.City,
	m3.Category, 
	m3.Score3,
	Rankc3m AS Rankc
	FROM
	MWOD3 m3
    LEFT JOIN Athlete_Registration ag
    ON m3.Ath_id=ag.Ath_id
    WHERE Rankc3m<4) AS r
ORDER BY GName;

/*There are 11 emails to send to athletes from 8 different gyms worthy of a social media shout-out*/

/* To display cities taking part by number of athletes, so I can see the popularity of the competition & which areas are being reached */

SELECT City, COUNT(Ath_id) AS Ath_by_City
FROM Athlete_Registration
GROUP BY City
ORDER BY COUNT(Ath_id) DESC;

/* Queries with GROUP BY and HAVING */

/* In order to give social media shout-outs to Gyms with the most (and at least three as minimal entries can skew a gym's reputation) athletes competing*/

SELECT GName, COUNT(Ath_id) AS No_Athletes
FROM Athlete_Registration
GROUP BY GName
HAVING COUNT(Ath_id)>2
ORDER BY COUNT(Ath_id) DESC;

/* To display no of female and male entries by Gym, for gyms to examine the inclusivity of their approach to the competition - this would need comparing internally with their athlete population*/

SELECT GName, Gender, COUNT(Ath_id) AS Nof_Athletes
FROM Athlete_Registration
GROUP BY GName, Gender
HAVING Gender='f'
ORDER BY COUNT(Ath_id) DESC;

SELECT GName, Gender, COUNT(Ath_id) AS Nom_Athletes
FROM Athlete_Registration
GROUP BY GName, Gender
HAVING Gender='m'
ORDER BY COUNT(Ath_id) DESC;

/* Top performers in the Open will be invited to compete again in the next round. Such athletes must compete at the RX level in every workout and achieve a particular benchmark score. This year the benchmark is at least 138 reps in WOD2. For instance, this query identifies the women qualifying for the next round */ 

		
        SELECT d.Ath_id, d.FName, d.SName, d.GName, d.Score2
        FROM FWOD2 d
        WHERE d.Score2>=138 AND d.Ath_id IN(
			SELECT t.Ath_id FROM(
				SELECT a.Ath_id, a.FName, a.SName, a.GName, a.Category AS CAT
				FROM
				FWOD2 a
				LEFT JOIN FWOD1 b
				ON a.Ath_id=b.Ath_id
				LEFT JOIN FWOD3 c
				ON b.Ath_id=c.Ath_id
				WHERE a.Category=b.Category AND b.Category=c.Category AND a.Category IN
					(SELECT d.Category 
					FROM FWOD1 d
					WHERE d.Category='RX')) AS t);
                    
                    
/* To feedback to the open about athlete perception of difficulty and which movements cap athletes at certain levels, we can see how athletes attempting RX changes throughout the workouts. */

SET sql_mode = 'TRADITIONAL';

SELECT Category, COUNT(*) AS CatCount
FROM WOD1F 
GROUP BY Category;

SELECT Category, COUNT(*) AS CatCount
FROM WOD2F 
GROUP BY Category;

SELECT Category, COUNT(*) AS CatCount
FROM WOD3F 
GROUP BY Category;

SELECT Category, COUNT(*) AS CatCount
FROM WOD1M 
GROUP BY Category;

SELECT Category, COUNT(*) AS CatCount
FROM WOD2M
GROUP BY Category;

SELECT Category, COUNT(*) AS CatCount
FROM WOD3M
GROUP BY Category;


