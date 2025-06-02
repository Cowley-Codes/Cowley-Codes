/* 
This database is to aid organisers in the planning of a large greenfield music festival - along the lines of Glastonbury.
There are multiple stages with hundreds of artists due to perform.
Some stages have full construction plans already, some are not yet fully determined.
Artists are continuing to be confirmed as the planning progresses.
Organisers are mindful of the different demographics & music tastes in attendance.
The aim is to keep fans of different genres happy without splitting core audiences for similar bands.
Aspects of the festival will be broadcast via TV and Radio to promote the breadth of entertainment.
The broadcast schedule must be mindful of family-friendly/watershed considerations. 
*/

CREATE DATABASE Festival;
USE Festival;

-- Construction of stages still being planned so capacity & shelter are not always yet determined.

CREATE TABLE Stages (
s_id INT NOT NULL PRIMARY KEY,
s_name VARCHAR(100) NOT NULL,
capacity INT, 
shelter BOOLEAN, 
daily_budget FLOAT(2)
);

-- Genres info will allow organisers to track audience demographics around the festival, ensuirng there is enough on offer.

CREATE TABLE Genres (
g_id CHAR(4) NOT NULL PRIMARY KEY,
g_desc VARCHAR(50) NOT NULL,
core_dem VARCHAR(35) NOT NULL
);

-- Broadcast info allows organisers to plan schedules with TV & radio channels, meeting their requirements. 

CREATE TABLE Broadcast (
b_id CHAR(4) NOT NULL PRIMARY KEY,
television BOOL NOT NULL,
radio BOOL NOT NULL,
family_friendly BOOL NOT NULL,
watershed ENUM("pre", "post") NOT NULL
);

-- Acts info has foreign keys of genre and broadcast ids to prevent repeating information.

CREATE TABLE Acts (
a_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
a_name VARCHAR(150) NOT NULL,
fee FLOAT(2) CHECK(fee<=70000), -- Max fee for any artist.
g_id CHAR(4),
b_id CHAR(4) DEFAULT "0000", -- This default is important as it ensures no accidental broadcasting of inappropriate material.
FOREIGN KEY (g_id) REFERENCES Genres (g_id),
FOREIGN KEY (b_id) REFERENCES Broadcast (b_id)
);

-- Acts can perform multiple times, so sets have unique IDs which are stored separately for normalisation.

CREATE TABLE Sets (
set_id VARCHAR(10) NOT NULL PRIMARY KEY,
show_length time NOT NULL,
roadie_pre time,
roadie_post time,
set_fee FLOAT(2),
a_id INT NOT NULL,
FOREIGN KEY (a_id) REFERENCES Acts (a_id)
);

-- Program of performances is put together, organising the artists' sets across the stages

CREATE TABLE Performances (
p_id VARCHAR(10) NOT NULL PRIMARY KEY,
s_id INT NOT NULL,
set_id CHAR(10) NOT NULL,
date DATE NOT NULL CHECK (date BETWEEN "2025-07-31" AND "2025-08-03"), -- within festival dates
start_time TIME NOT NULL,
end_time TIME NOT NULL,
FOREIGN KEY (s_id) REFERENCES Stages (s_id),
FOREIGN KEY (set_id) REFERENCES Sets (set_id)
);

-- Populating the different broadcastability options.

INSERT INTO Broadcast
(b_id, television, radio, family_friendly, watershed)
VALUES
("0000", 0, 0, 0, "post"),
("0001", 0, 0, 0, "pre"),
("0011", 0, 0, 1, "pre"),
("0110", 0, 1, 1, "post"),
("1000", 1, 0, 0, "post"),
("1001", 1, 0, 0, "pre"),
("1011", 1, 0, 1, "pre"),
("0100", 0, 1, 0, "post"),
("0101", 0, 1, 0, "pre"),
("0111", 0, 1, 1, "pre"),
("1100", 1, 1, 0, "post"),
("1101", 1, 1, 0, "pre"),
("1110", 1, 1, 1, "post"),
("1111", 1, 1, 1, "pre");

/* Checking all inserts correct

SELECT* 
FROM Broadcast;

*/

-- Populating Stages info, as far as is known, using UNION ALL method for insert.

INSERT INTO Stages
(s_id, s_name, capacity, shelter, daily_budget)
SELECT 100, 'Century', 90000, 0, 240000
UNION ALL
SELECT 101, 'Prime', 50000, 0, 230000
UNION ALL
SELECT 102, 'Powers', 30000, 0, 220000
UNION ALL
SELECT 103, 'Roots', 15000, 1, 220000
UNION ALL
SELECT 104, 'Radius', 12000, 1, 45000
UNION ALL
SELECT 314, 'Circumference', 10000, NULL, NULL 
UNION ALL
SELECT 106, 'Matrix', 10000, 0, 45000
UNION ALL
SELECT 576, 'Square', 4000, 1, 22000
UNION ALL
SELECT 111, 'Angles', 800, 1, 35000;

-- I realised the daily budget of the stage 'Circumference' is known, but the capacity and shelter not yet determined as under construction planning.
-- Table updated to reflect this. 

UPDATE Stages
SET capacity = NULL, daily_budget = 70000
WHERE s_id = 314;

/* Queries to check inserts and key values for total capacity & budget.

SELECT*
FROM Stages;

SELECT SUM(capacity)
FROM Stages;

SELECT SUM(daily_budget)*4 as total_budget
FROM Stages;

*/

-- Populating genres info.

INSERT INTO Genres
(g_id, g_desc, core_dem)
VALUES
('POP1', 'Mainstream pop', 'gen alpha, gen z, millenials'),
('POP2', 'Nostalgic pop', 'millenials'),
('POP3', 'Baby pop', 'gen alpha'),
('FLKI', 'Irish folk', 'gen x, millenials'),
('FLKA', 'American folk', 'gen x, millenials'),
('CTRY', 'Country', 'gen x, millenials'),
('WLSH', 'Welsh rock', 'millenials'),
('CMDY', 'Comedy', 'gen x, millenials'),
('ACST', 'Acoustic', 'gen x, millenials'),
('HPH1', 'Modern hiphop', 'gen z, gen alpha'),
('HPH2', 'Nostalgic hiphop', 'millenials'),
('RAP1', 'Modern rap', 'gen z, gen alpha'),
('RAP2', 'Nostalgic rap', 'millenials'),
('LAT1', 'Mainstream DJ', 'gen z, gen alpha, millenials'),
('LAT2', '90s DJ', 'millenials'),
('LAT3', 'Early Dance', 'gen x, millenials'),
('RCK1', 'Mainstream rock', 'gen x, millenials, gen z, gen alpha'),
('RCK2', 'Old-school rock', 'gen x'),
('RCK3', 'Indie rock', 'millenials');


/* Check genres with the following queries.

SELECT*
FROM Genres;

SELECT*
FROM Genres
WHERE core_dem LIKE '%x%';

SELECT*
FROM Genres
WHERE core_dem LIKE '%mill%';

SELECT*
FROM Genres
WHERE core_dem LIKE '%alpha%';

SELECT*
FROM Genres
WHERE core_dem LIKE '%z%';

*/

-- Most acts will perform a standard set length with changeover time based on their genre.
-- For efficiency, a trigger automatically enters this info into the sets table each time a new act is added.
-- Sets table is then updated later for those acts playing longer or additional sets.

DELIMITER //

CREATE TRIGGER New_Act_Set
AFTER INSERT
ON Acts
FOR EACH ROW
BEGIN
	CASE
		WHEN NEW.g_id = 'CMDY' THEN INSERT INTO Sets (set_id, show_length, roadie_pre, roadie_post, set_fee, a_id) 
		VALUES (CONCAT(LEFT(NEW.a_name, 9), '1'), '00:30:00', '00:05:00', '00:05:00', NEW.fee, NEW.a_id); 
				-- Comedy sets are 30 mins with 5 mins changeover.
				-- left and concat string functions used to automatically name first set by artist
                
		WHEN NEW.g_id LIKE 'LAT_' THEN INSERT INTO Sets (set_id, show_length, roadie_pre, roadie_post, set_fee, a_id)
		VALUES (CONCAT(LEFT(NEW.a_name, 9), '1'), '01:30:00', '00:00:00', '00:00:00', NEW.fee, NEW.a_id);
			-- Late night sets are longer with 0 perceptible changeover between DJs.
   
		ELSE INSERT INTO Sets (set_id, show_length, roadie_pre, roadie_post, set_fee, a_id)
		VALUES (CONCAT(LEFT(NEW.a_name, 9), '1'), '00:50:00', '00:10:00', '00:10:00', NEW.fee, NEW.a_id);
        -- Standard music shows are 50 mins with 10 minutes changeover time for sound/stage teams.
	END CASE;
END;

//

DELIMITER ;

-- Inserting Acts data. Auto-increment means a_id does not need to be entered manually.
-- As each new act is confirmed, the next ID number is generated for them automatically.

INSERT INTO Acts 
(a_name, fee, g_id, b_id)
VALUES
('James Bay', 40000, 'ACST', '1111'),
('Dolly Parton', 65000, 'CTRY', '1111');

-- Quick check that the autoincrement of a_id and trigger for sets has worked before adding the rest of the artists.

SELECT*
FROM Acts;

SELECT*
FROM Sets;

INSERT INTO Acts 
(a_name, fee, g_id, b_id)
VALUES
('Shania Twain', 55000, 'CTRY', '1111'), 
('Luke Bryan', 25000, 'CTRY', '1111'),
('Jordan Davis', 30000, 'CTRY', '1111'),
('Josh Turner', 25000, 'CTRY', '1111'),  
('Nathaniel Rateliff & The Night Sweats', 50000, 'FLKA', '1100'),
('Lady A', 38000, 'CTRY', '1100'),
('Cody Johnson', 27000, 'CTRY', '1111'),
('Carly Pearce', 29000, 'CTRY', '1111'),
('NOASIS', 4000, 'RCK3', '1100'),
('The Maccabees', 48000, 'RCK3', '1100'),
('Courteeners', 39000, 'RCK3', '1100'),
('OASIS', 67000, 'RCK3', '1100'),
('Arctic Monkeys', 68000, 'RCK3', '1100'),
('Elbow', 55000, 'RCK1', '1111'),
('Pulp', 45000, 'RCK2', '1100'),
('James', 38000, 'RCK2', '1101'),
('The Pogues', 45000, 'RCK3', '1100'),
('Orla Gartland', 11000, 'FLKI', '1100'),
('Amble', 6000, 'FLKI', '1111'),
('Kingfishr', 5000, 'FLKI', '1111'),
('Randy Newman', 4000, 'ACST', '1111'),
('Gabrielle Aplin', 19000, 'ACST', '1111'),
('Hozier', 20000, 'FLKI', '1111'),
('Jamie XX', 29000, 'LAT1', '0000'),
('Caribou', 29000, 'LAT1', '1100'),
('Chemical Brothers', 44000, 'LAT2', '1100'),
('Daft Punk', 35000, 'LAT1', '1000'),
('Carl Cox', 19000, 'LAT3', '0000'),
('Pete Tong', 18000, 'LAT3', '0000'),
('Yadda', 4000, 'LAT1', '1100'),
('Gina Breeze', 3000, 'LAT1', '1100'),
('Gorkys Zygotic Mynci', 14000, 'WLSH', '1101'),
('Catatonia', 24000, 'WLSH', '1100'),
('Paolo Nutini', 39000, 'ACST', '1110'),
('Robbie Williams', 40000, 'POP2', '1111'),
('David Gray', 30000, 'ACST', '1111'),
('Catfish and the Bottlemen', 7000, 'RCK2', '1100'),
('DMAs', 8000, 'RCK1', '1100'),
('Fontaines D.C.', 38000, 'RCK1', '1100'),
('Kneecap', 19000, 'HPH1', '1100'),
('Kendrick Lamar', 54000, 'HPH1', '1100'),
('Lauryn Hill', 29000, 'HPH2', '1110'),
('Missy Elliot', 14000, 'HPH2', '1100'),
('Duffy', 13000, 'POP2', '1111'),
('Lily Allen', 33000, 'POP1', '1110'),
('Paloma Faith', 14000, 'POP2', '1111'),
('Kate Nash', 13000, 'POP2', '1100'),
('Bonnie Tyler', 23000, 'POP2', '1111'),
('Laura Marling', 19000, 'ACST', '1111'),
('Alexandra Burke', 3000, 'POP3', '1111'), 
('James Arthur', 5000, 'POP3', '1111'),
('Matt Cardle', 2500, 'POP3', '1111'),
('Shayne Ward', 3000, 'POP3', '1111'), 
('Zayn', 5000, 'POP3', '1111'),
('Jedward', 2500, 'POP3', '1111'),
('Dave', 4000, 'RAP1', '0100'),
('Slowthai', 3000, 'RAP1', '1100'),
('Idles', 40000, 'RCK2', '1100'),
('Public Enemy', 8000, 'RAP2', '0100'),
('Ashlee Simpson', 9500, 'POP2', '1111'),
('Atomic Kitten', 7000, 'POP2', '1111'),
('The Pussycat Dolls', 9500, 'POP2', '1111'),
('Rachel Stevens', 5000, 'POP2', '1111'),
('JoJo', 4500, 'POP2', '1111'),
('The Wolfe Tones', 6000, 'FLKI', '1111'),
('The Kooks', 9500, 'RCK2', '1100'),
('Franz Ferdinand', 5000, 'RCK2', '1111'),
('Al Murray', 3500, 'CMDY', '1000'),
('Aisling Bea', 4500, 'CMDY', '1000'),
('John Robins', 2500, 'CMDY', '1000'),
('Elis James', 2500, 'CMDY', '1000'),
('Isy Suttie', 2500, 'CMDY', '1000'),
('Dancing with Dave', 4000, 'LAT1', '0100'),
('Rhod Gilbert', 2500, 'CMDY', '1000'),
('Sarah Millican', 2500, 'CMDY', '1000'),
('Jon Richardson', 2800, 'CMDY', '1000'),
('Rob Brydon', 2900, 'CMDY', '1000'),
('Peter Kay', 2950, 'CMDY', '1000'),
('Stephen Fry', 3000, 'CMDY', '1000'),
('Dawn French', 1500, 'CMDY', '1000'),
('Greg Davies', 2500, 'CMDY', '1000'),
('Alex Horne', 2500, 'CMDY', '1000'),
('Lou Sanders', 2500, 'CMDY', '1000'),
('Shagged, Married, Annoyed', 4000, 'CMDY', '1000'),
('Marcus Mumford', 12500, 'ACST', '1111'),
('Picture This', 13000, 'FLKI', '1111'),
('Passenger', 9000, 'ACST', '0110'),
('Tom Baxter', 7000, 'ACST', '1111'),
('Keaton Henson', 3000, 'ACST', '0100'),
('The Vaccines', 7000, 'RCK2', '1100'),
('Jamie T', 11000, 'RCK2', '1100'),
('Rooster', 5000, 'RCK2', '1100'),
('Tribes', 6000, 'RCK2', '1100'),
('Self Esteem', 29000, 'POP1', '1100'),
('The Lumineers', 17000, 'FLKA', '1111'),
('Caamp', 11000, 'FLKA', '1111'),
('Fat Boy Slim', 15000, 'LAT1', '0100'),
('Groove Armada', 15000, 'LAT2', '0100'),
('Louie, Louie', 8000, 'LAT1', '0100'),
('Roxanne Roll', 7000, 'LAT1', '0100'),
('Acid Joe', 4000, 'LAT1', '0000'),
('DJ Nicky Nicky', 3000, 'LAT1', '0100'),
('Sports Team', 2500, 'RCK1', '1100'),
('Phoebe Bridgers', 38000, 'ACST', '1111'),
('George Ezra', 45000, 'RCK1', '1100'),
('CHIC', 65000, 'POP1', '1111'),
('Alabama Shakes', 4000, 'FLKA', '1111'),
('First Aid Kit', 13000, 'ACST', '1100'),
('Gorillaz', 19000, 'RCK1', '1100'),
('Keane', 18000, 'RCK1', '1110'),
('Madness', 20000, 'RCK1', '1100');

-- Updating Sets table to increase show length and prep time for headline acts.

UPDATE Sets
SET show_length = '1:30:00', roadie_pre = '00:20:00', roadie_post='00:00:00'
WHERE a_id IN(
	SELECT a_id
	FROM Acts
	WHERE a_name IN('The Maccabees', 'Arctic Monkeys', 'Idles', 'OASIS', 'Fontaines D.C.', 'Paolo Nutini', 'The Pogues', 'Elbow', 'Gorillaz', 'Kneecap', 'Kendrick Lamar', 'Shania Twain', 'Dolly Parton', 'Hozier', 'Nathaniel Rateliff & the Night Sweats', 'Lauryn Hill', 'Lilly Allen', 'Kate Nash', 'Public Enemy', 'Gabrielle Aplin', 'Caamp', 'Marcus Mumford')
	ORDER BY a_id);
    
-- Adding to sets table to include additional sets for artists making a second performance.
-- Since adding an additional set is a repeated process, a stored procedure is used.
-- Acts' fees are agreed in total, so a second performance has no fee.

DELIMITER //

CREATE PROCEDURE Extra_Set(a_name VARCHAR(150), a_id INT)
BEGIN
	INSERT INTO Sets
	(set_id, show_length, roadie_pre, roadie_post, set_fee, a_id)
	VALUES
	(CONCAT(LEFT(a_name, 9), '2'), '00:50:00', '00:10:00', '00:10:00', 0, a_id);
END;

//

DELIMITER ;

-- To see the artists due for a second set.

SELECT a_id, a_name
FROM Acts
WHERE a_name IN
('Nathaniel Rateliff & The Night Sweats','Paolo Nutini', 'Gabrielle Aplin', 'Caamp', 'Lilly Allen', 'The Maccabees', 'The Pogues', 'Hozier');

-- Call the stored procedure to add an extra set for each of the above artists.

CALL Extra_Set('Nathaniel Rateliff & The Night Sweats', 7);
CALL Extra_Set('Paolo Nutini', 36);
CALL Extra_Set('Caamp', 98);
CALL Extra_Set('Hozier', 25);
CALL Extra_Set('Gabrielle Aplin', 24);
CALL Extra_Set('The Maccabees', 12);
CALL Extra_Set('The Pogues', 19);

/* Checking that sets are as they should be.

SELECT*
FROM Sets
WHERE set_id LIKE '%2';

SELECT*
FROM Sets
ORDER BY show_length DESC, a_id;

*/

-- If an artist should pull out of performing, it is important that their sets are also removed from the database so cannot be scheduled by mistake.
-- A parallel trigger is therefore necessary for deletion of an act.

DELIMITER //

CREATE TRIGGER Act_Out
AFTER DELETE
ON Acts
FOR EACH ROW
BEGIN
	DELETE 
    FROM Sets 
    WHERE a_id = OLD.a_id;
END//

DELIMITER ;

SELECT* FROM Acts;

-- Jedward's agent has discovered that they are being paid less than other duo acts and has consequently pulled them from performing.
-- Jedward must be deleted from the Acts table.

SELECT a_name, a_id -- to retrieve a_id so can use primary key in delete statement
FROM Acts
WHERE a_name = 'Jedward';

SET FOREIGN_KEY_CHECKS=0; -- necessary to allow the deletion

DELETE 
FROM Acts
WHERE a_id=57;

SET FOREIGN_KEY_CHECKS=1;

-- Check that the trigger has worked and no Jedward sets remain in the table.

SELECT*
FROM Sets
WHERE a_id=57;

-- NULL response, so the trigger has correctly removed their sets from the table.


-- Different stages will have different start times, which I have realised need to be stored before the performance scheduling takes place.
-- Altering stages table accordingly, then updating each row which requires disabling safe mode.

ALTER TABLE Stages
ADD COLUMN opens TIME;

SET SQL_SAFE_UPDATES = 0;

UPDATE Stages
SET opens = 
CASE
	WHEN s_id IN (100, 101, 102, 103, 111) THEN '12:00:00'
	WHEN s_id IN (104, 314) THEN '16:00:00'
    WHEN s_id = 576 THEN '11:00:00'
	ELSE '17:00:00'
END;

SET SQL_SAFE_UPDATES = 1;

-- Checking stages data as it should be.
-- SELECT*
-- FROM Stages;

-- For normalisation, sets scheduled in the performance table have their time constraints stored in the sets table.
-- The next planning stage will require organisers to calculate start and end times for sets as they are logged in the performances table.
-- Therefore, the performances and sets tables must be joined together, I have stored this as a view for ease of re-use.

CREATE VIEW vw_scheduled_sets
AS
SELECT 
	p.p_id, 
	p.s_id, 
    p.set_id, 
    p.date, 
    p.start_time, 
    p.end_time, 
    s.show_length, 
    s.roadie_pre, 
    s.roadie_post, 
    s.set_fee,
    s.a_id
FROM
Performances AS p
LEFT JOIN
Sets AS s
ON
p.set_id = s.set_id;

-- SELECT* FROM vw_scheduled_sets;

-- The following sequence of functions allows organisers to identify the next possible start time for an act on a given date and stage.

-- The first function finds the latest finish currently for that stage and date.

DELIMITER //

CREATE FUNCTION Find_Latest_Finish (s_id INT, date DATE)
RETURNS TIME
READS SQL DATA
BEGIN
    DECLARE Latest_Finish TIME; 
    
    SELECT MAX(v.end_time) 
    INTO Latest_Finish 
    FROM vw_scheduled_sets AS v 
    WHERE v.s_id = s_id AND v.date = date;
    
    RETURN Latest_Finish;
END //

DELIMITER ;

-- This second function then finds the id for the act playing that latest finish.

DELIMITER //

CREATE FUNCTION Find_Last_Band (s_id INT, date DATE)
RETURNS VARCHAR(150)
READS SQL DATA
BEGIN
    DECLARE Last_Band VARCHAR(150); 
    
    SELECT v.a_id
    INTO Last_Band 
    FROM vw_scheduled_sets AS v 
    WHERE v.s_id = s_id 
    AND v.date = date 
    AND v.end_time = Find_Latest_Finish(s_id,date);
    
    RETURN Last_Band;
END //

DELIMITER ;

-- This third function then calculates the next available start time by adding the latest finish and the roadie-post time for the last act.

DELIMITER //

CREATE FUNCTION Next_Stage_Time (s_id INT, date DATE)
RETURNS TIME
READS SQL DATA
BEGIN
    DECLARE Stage_Time TIME;
    
    -- Firstly a check to see if the latest time is null, if so returning stage opening time since the day is currently empty.
    IF Find_Latest_Finish(s_id, date) IS NULL
	THEN SELECT s.Opens
			 INTO Stage_Time
			 FROM Stages AS s 
			 WHERE s.s_id=s_id;
             
	-- Otherwise, the previous finish time and required roadie time are added to give the available start time for the next act.
	ELSE
			SELECT ADDTIME(
			Find_Latest_Finish(s_id, date),             -- Using first function to find previous act finish time
											(SELECT v.roadie_post 
											FROM vw_scheduled_sets AS v 
											WHERE v.a_id = Find_Last_Band(s_id, date)    -- Using second function to find id for that act 
											AND v.set_id IN (SELECT set_id                -- Further check that set id matches stage and date, as some acts have multiple set IDs.
															FROM Performances AS p 
															WHERE p.date = date 
															AND p.s_id=s_id))
			) INTO Stage_Time;
            
	END IF;

RETURN Stage_Time;

END //

DELIMITER ;

-- Check that this works, at the moment returning stage opening time as performances table empty.

SELECT Next_Stage_Time(100, "25-08-01");

-- I realised the constraint of 10 characters for performance ID is unhelpful for building them based on 10 character set IDs.
-- Altering table to accommodate this.

ALTER TABLE Performances
MODIFY COLUMN p_id CHAR(11);

-- Adding a set to the performances table is a repeated process, so a stored procedure is used.

DELIMITER //

CREATE PROCEDURE Schedule_Set(set_id CHAR(10), s_id INT, date DATE)
BEGIN
	INSERT INTO Performances
    (p_id, s_id, set_id, date, start_time, end_time)
    VALUES(
    CONCAT('p', set_id),
    s_id,
    set_id,
    date,
    ADDTIME(Next_Stage_Time(s_id, date), (SELECT s.roadie_pre        -- Adds set-up time to the stage availability time found by above functions.
										 FROM Sets AS s
                                         WHERE s.set_id = set_id)),
	ADDTIME(start_time, (SELECT s.show_length                      -- Adds show length time for the set to the above calculated start time.
						 FROM Sets AS s
						 WHERE s.set_id = set_id))
    );
END//

DELIMITER ;

-- Organisers can now call the above sproc to build the performance schedule for the stages.

-- Before doing so, there are several joins which will be helpful to organisers to see data that was separated for normalisation.
-- I will create these now and store as views so they can be easily accessed.

-- This view is useful for simplifying future queries involving artist genre & broadcastability

CREATE VIEW vw_acts_genre_broad
AS
SELECT a.a_id,
	   a.a_name,
       a.fee,
       g.g_id,
       g.g_desc,
       g.core_dem,
       b.television,
       b.radio,
       b.family_friendly,
       b.watershed
FROM
Acts AS a
LEFT JOIN
Genres AS g
ON a.g_id = g.g_id
LEFT JOIN
Broadcast AS b
ON a.b_id = b.b_id;

SELECT*
FROM vw_acts_genre_broad;

-- This view is helpful to observe appropriate choices based on the genre desired for each stage.

CREATE VIEW vw_unscheduled_sets
AS
SELECT s.set_id, 
    s.show_length, 
    s.roadie_pre, 
    s.roadie_post,
    s.set_fee,
    s.a_id,
    v.a_name,
	v.g_id,
	v.g_desc,
	v.core_dem,
	v.television,
	v.radio,
	v.family_friendly,
	v.watershed
FROM 
Sets AS s
LEFT JOIN
vw_acts_genre_broad AS v
ON s.a_id = v.a_id
ORDER BY v.g_id, v.fee ASC; -- This way genres are grouped together with higher fee headline acts left for scheduling later in the days.

-- This view can now be used, for example if the organisers are looking for a family friendly country or folk artist to play early at the Roots stage:

SELECT*
FROM vw_unscheduled_sets
WHERE (g_id='CTRY' OR g_id LIKE 'FLK_')
AND family_friendly=1
ORDER BY set_fee ASC;

-- Querying this view as above to view the options for each stage, organisers can then call the sproc to schedule sets.

CALL Schedule_Set('Bonnie Ty1', 100, '25-07-31');
CALL Schedule_Set('First Aid1', 101, '25-07-31');
CALL Schedule_Set('Alexandra1', 102, '25-07-31');
CALL Schedule_Set('James Art1', 104, '25-07-31');
CALL Schedule_Set('Missy Ell1', 314, '25-07-31');
CALL Schedule_Set('DJ Nicky 1', 106, '25-07-31');
CALL Schedule_Set('Isy Sutti1', 576, '25-07-31');
CALL Schedule_Set('Orla Gart1', 111, '25-07-31');
CALL Schedule_Set('Cody John1', 103, '25-07-31');
CALL Schedule_Set('Keaton He1', 111, '25-07-31');

-- Festival dates are 25-07-31 to 25-08-03.
-- Check constraint in the Performances table means that this next call to insert will cause an error.
-- Example here to demonstrate that oprganisers will be prohibited from making the mistake of scheduling outside of festival dates.

CALL Schedule_Set('Dave1', 314, '25-08-31');

-- This view is helpful for simplifying future queries as it joins the set details to the relevant stage information.

CREATE VIEW vw_scheduled_sets_on_stage
AS
SELECT v.p_id, 
	   v.date, 
       v.start_time, 
       v.end_time, 
       v.s_id, 
       s.s_name,
       s.capacity,
       s.shelter,
       v.set_id,
       v.set_fee,
       v.a_id
FROM
vw_scheduled_sets AS v
LEFT JOIN
Stages AS s
ON 
v.s_id = s.s_id;

-- Similarly, this view joins set details with artist details, for simplifying future queries e.g. building programs with stage and artist names included.

CREATE VIEW vw_scheduled_acts_on_stage
AS
SELECT s.p_id, 
	   s.date, 
       s.start_time, 
       s.end_time, 
       s.s_id, 
       s.s_name, 
       s.set_id,
       s.set_fee,
	   a.a_id, 
       a.a_name
FROM
vw_scheduled_sets_on_stage AS s
LEFT JOIN
Acts AS a
ON 
s.a_id = a.a_id;

-- This final view is helpful for queries tracking genre and broadcastability around the stages, as it joins performance info with full artist details.

CREATE VIEW vw_schedule_full_details
AS
SELECT s.p_id, 
	   s.date, 
       s.start_time, 
       s.end_time, 
       s.s_id, 
       s.s_name, 
       s.set_id,
       s.set_fee,
	   s.a_id, 
       s.a_name,
       a.g_id,
       a.g_desc,
       a.core_dem,
       a.television,
       a.radio,
       a.family_friendly,
       a.watershed
FROM 
vw_scheduled_acts_on_stage AS s
LEFT JOIN
vw_acts_genre_broad AS a
ON s.a_id = a.a_id;

/* Checking views of joins work as expected.

SELECT*
FROM vw_scheduled_sets;

SELECT*
FROM vw_scheduled_sets_on_stage;

SELECT*
FROM vw_scheduled_acts_on_stage;

SELECT*
FROM vw_schedule_full_details;

*/

SELECT* FROM vw_unscheduled_sets; -- I exported this table as CSV to keep open as choosing the sets to add to the line-up for each stage.

-- This query can be used repeatedly to keep an eye on the developing program of acts.

SELECT p_id, s_id, date, start_time, end_time
FROM vw_scheduled_sets
ORDER BY s_id, start_time;

-- These calls schedule sets to fill the first day of the festival, populating the performances table.

CALL Schedule_Set('Hozier2', 100, '25-07-31');
CALL Schedule_Set('Matt Card1', 100, '25-07-31');
CALL Schedule_Set('James1', 100, '25-07-31');
CALL Schedule_Set('Franz Fer1', 100, '25-07-31');
CALL Schedule_Set('DMAs1', 100, '25-07-31');
CALL Schedule_Set('The Kooks1', 100, '25-07-31');
CALL Schedule_Set('Catatonia1', 100, '25-07-31');
CALL Schedule_Set('The Macca1', 100, '25-07-31');
CALL Schedule_Set('Madness1', 101, '25-07-31');
CALL Schedule_Set('Sports Te1', 101, '25-07-31');
CALL Schedule_Set('NOASIS1', 101, '25-07-31');
CALL Schedule_Set('Tribes1', 101, '25-07-31');
CALL Schedule_Set('Rooster1', 101, '25-07-31');
CALL Schedule_Set('Jamie T1', 101, '25-07-31');
CALL Schedule_Set('Fontaines1', 101, '25-07-31');
CALL Schedule_Set('Ashlee Si1', 102, '25-07-31');
CALL Schedule_Set('Self Este1', 102, '25-07-31');
CALL Schedule_Set('Slowthai1', 102, '25-07-31');
CALL Schedule_Set('The Pussy1', 102, '25-07-31');
CALL Schedule_Set('CHIC1', 102, '25-07-31');
CALL Schedule_Set('Daft Punk1', 102, '25-07-31');
CALL Schedule_Set('Kendrick 1', 102, '25-07-31');
CALL Schedule_Set('Amble1', 103, '25-07-31');
CALL Schedule_Set('The Lumin1', 103, '25-07-31'); 
CALL Schedule_Set('Picture T1', 103, '25-07-31');
CALL Schedule_Set('Carly Pea1', 103, '25-07-31');
CALL Schedule_Set('Josh Turn1', 103, '25-07-31');
CALL Schedule_Set('Passenger1', 103, '25-07-31');
CALL Schedule_Set('Luke Brya1', 103, '25-07-31');
CALL Schedule_Set('Dolly Par1', 103, '25-07-31');
CALL Schedule_Set('JoJo1', 104, '25-07-31');
CALL Schedule_Set('Rachel St1', 104, '25-07-31');
CALL Schedule_Set('Zayn1', 104, '25-07-31');
CALL Schedule_Set('Atomic Ki1', 104, '25-07-31');
CALL Schedule_Set('Paloma Fa1', 104, '25-08-01');
CALL Schedule_Set('Dave1', 314, '25-07-31');
CALL Schedule_Set('Gina Bree1', 314, '25-07-31');
CALL Schedule_Set('Jamie XX1', 314, '25-07-31');
CALL Schedule_Set('Public En1', 314, '25-07-31');
CALL Schedule_Set('Acid Joe1', 106, '25-07-31');
CALL Schedule_Set('Pete Tong1', 106, '25-07-31');
CALL Schedule_Set('Groove Ar1', 106, '25-07-31');
CALL Schedule_Set('Caamp2', 111, '25-07-31');
CALL Schedule_Set('Phoebe Br1', 111, '25-07-31');
CALL Schedule_Set('Gabrielle1', 111, '25-07-31');
CALL Schedule_Set('Elis Jame1', 576, '25-07-31');
CALL Schedule_Set('Sarah Mil1', 576, '25-07-31');
CALL Schedule_Set('John Robi1', 576, '25-07-31');
CALL Schedule_Set('Alex Horn1', 576, '25-07-31');
CALL Schedule_Set('Lou Sande1', 576, '25-07-31');
CALL Schedule_Set('Dawn Fren1', 576, '25-07-31');

-- At this point, organisers can query the data to make certain checks on their day's shceduling & aid other areas of planning.

-- The first query checks that the total spend on each stage is below the daily budget. 

SELECT *, daily_budget - spent_on_sets AS left_to_spend
FROM (
		SELECT v.s_id,
			   v.s_name,
			   SUM(v.set_fee) AS spent_on_sets,
			   s.daily_budget
		FROM vw_scheduled_sets_on_stage AS v
		LEFT JOIN Stages AS s
		ON v.s_id = s.s_id
		WHERE date = '25-07-31'
		GROUP BY s_id                       -- This means the sum of set fees is taken over each individual stage
		ORDER BY s_id
        ) AS budget_calcs;
        
-- Running this query shows that the Angles stage with ID 111 has massively over-spent (36000) on the first day. 
-- To address this, organisers can inspect the sets and find appropriate replacements using the following queries.

SELECT p_id,
	   s_id,
       set_id,
       start_time,
       end_time,
       show_length,
       set_fee,
       a_id
FROM vw_scheduled_sets
WHERE date = '25-07-31'
AND s_id=111
ORDER BY set_fee DESC;

-- This result shows that Phoebe Bridgers 50 min set at 15:40 is the most expensive at 38000. 
-- Organisers can delete her set from the performances table using her p_id 106 and replace with a cheaper set to re-balance the budget.

DELETE
FROM Performances
WHERE s_id = 111 AND p_id = 'pPhoebe Br1';

-- Running the budget inspection query again shows that the stage now has 2000 left to spend on a replacement act.


-- This next query finds a list of replacement 50 min sets that are an appropriate genre for this stage and under 2000 in fees.

SELECT set_id, show_length, set_fee, a_id, g_id
FROM vw_unscheduled_sets
WHERE g_id IN ('CTRY', 'ACST', 'FLKA', 'FLKI')
AND show_length = '00:50:00'
AND set_fee < 2000;

-- One of these choices is then inserted into the Performances table, with the same timings as the deleted Phoebe Bridgers set.

INSERT INTO Performances
(p_id, s_id, set_id, date, start_time, end_time)
VALUES
('pNathaniel2', 111, 'Nathaniel2', '25-07-31', '15:40:00', '16:30:00');

-- Organisers can double-check that the performances of the day for this stage still run smoothly by running the following query.

SELECT *
FROM Performances
WHERE s_id = 111
AND date = '25-07-31'
ORDER BY start_time;

-- Another run of the budget inspection query confirms the stage is back under budget for this day.


-- The next query finds the headline acts on each stage, which need to be printed for the poster.

SELECT s_name AS Stage,
	   a_name AS Headliner,
       start_time AS Beginning
FROM
		(SELECT s_name,
				a_name,
                start_time,
			   MAX(start_time) OVER (PARTITION BY s_id) AS latest_time -- this subquery finds the latest start time at each stage
		FROM vw_scheduled_acts_on_stage
        ORDER BY s_id) AS finding_latest
WHERE start_time = latest_time
ORDER BY start_time;

-- BBC radio has some concerns about non-family-friendly acts being broadcast, due to complaints after other festivals.
-- Therefore, organisers must provide a briefing leaflet to all such acts who are due to be broadcast on radio.
-- The following query provides a full list of the acts who need to have the briefing given to them.

SELECT a_id,
	   a_name,
	   radio,
       family_friendly
FROM vw_acts_genre_broad
WHERE radio = 1 AND family_friendly = 0
ORDER BY a_id;

-- Organisers need to provide the pre-watershed TV options to broadcasters, for live transmission before 9pm.
-- The next query finds all appropriate scheduled sets, including their timings and audience info, from which the channels can build their programs.

SELECT p_id,
	   s_name,
	   start_time,
       end_time,
       a_name,
       g_desc,
       core_dem,
       television,
       watershed
FROM vw_schedule_full_details
WHERE television = 1 
AND watershed = 'pre'
AND date = '25-07-31'
AND start_time < '21:00:00'
ORDER BY start_time, s_id;

-- Organisers wish to ensure there is enough entertainment for key audience demographics throughout the day.
-- This is an example of a query which allows organisers to track the day for a specific demographic, inspecting for gaps.

SELECT p_id,
	   start_time,
       end_time,
       a_name,
       s_name,
       g_desc,
       core_dem
FROM vw_schedule_full_details
WHERE core_dem LIKE '%alpha%'
ORDER BY start_time, s_id;

-- Organisers also wish to track the festival day by considering where a particular music fan might be at a given time.
-- For instance, the below queries return the options for a rock fan at 4pm on 31st July and a pop fan at 6pm the same day.

SELECT p_id,
	   start_time,
       end_time,
       a_name,
       s_name,
       g_id,
       g_desc,
       core_dem
FROM vw_schedule_full_details
WHERE date = '25-07-31'
AND start_time <= '16:00:00'
AND '16:00:00' <= end_time 
AND g_id LIKE 'RCK_'
ORDER BY start_time, s_id;


SELECT p_id,
	   start_time,
       end_time,
       a_name,
       s_name,
       g_id,
       g_desc,
       core_dem
FROM vw_schedule_full_details
WHERE date = '25-07-31'
AND start_time <= '18:00:00'
AND '18:00:00' <= end_time 
AND g_id LIKE 'POP_'
ORDER BY start_time, s_id;

-- I realised the organisers would need to use this process a lot.
-- So the following procedure finds the options for a fan of a particular genre for a given date and time.

DELIMITER //

CREATE PROCEDURE find_fans(genre VARCHAR(4), date DATE, time TIME)
BEGIN
	SELECT v.p_id,
	   v.start_time,
       v.end_time,
       v.a_name,
       v.s_name,
       v.g_id,
       v.g_desc,
       v.core_dem
	FROM vw_schedule_full_details AS v
	WHERE v.date = date
	AND v.start_time <= time
	AND time <= v.end_time 
	AND g_id LIKE genre
	ORDER BY v.start_time, v.s_id;
END//

DELIMITER ;

-- An example of how the procedure speeds up the process of finding genre options for a date & time of the festival.
-- This time looking for a DJ fan at 8.30pm on the first day of the festival.

CALL find_fans('LAT_', '25-07-31', '20:30:00');

