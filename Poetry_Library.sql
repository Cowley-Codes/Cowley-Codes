CREATE DATABASE Poetry_Library;
USE Poetry_Library;

-- This DB stores records of poetry books, their authors and whether the books are out on loan to readers.
-- For normalisation, the author, book and borrowing details are stored in separate tables.

CREATE TABLE Authors
(a_id INT NOT NULL AUTO_INCREMENT,
auth_name VARCHAR(50) NOT NULL,
auth_surname VARCHAR(50) NOT NULL,
PRIMARY KEY (a_id) );

CREATE TABLE Books
(b_id INT NOT NULL AUTO_INCREMENT,
a_id INT NOT NULL,
title VARCHAR(200),
PRIMARY KEY (b_id),
FOREIGN KEY (a_id) REFERENCES Authors(a_id));

CREATE TABLE Borrowing
(b_id INT NOT NULL,
borrow_date DATE NOT NULL,
return_date DATE NOT NULL,
reader_name VARCHAR(100) NOT NULL);

INSERT INTO Authors
(auth_name, auth_surname)
VALUES
('Henry', 'Normal'),
('Lemn', 'Sissay'),
('Seamus', 'Heaney'),
('Patrick', 'Kavanagh'),
('James', 'Joyce'),
('Mary', 'Oliver'),
('Maya', 'Angelou'),
('Carol Ann', 'Duffy'),
('Rupi', 'Kaur'),
('Audre', 'Lorde');

-- Checking Author inserts
-- SELECT* FROM Authors; 

INSERT INTO Books
(a_id, title)
VALUES
(1, 'The Fire Hills'),
(1, 'Raning Upwards'),
(1, 'The Beauty Within Shadow'),
(1, 'Travelling Second Class Through Hope'),
(2, 'Let the Light Pour In'),
(2, 'Gold from the Stone'),
(2, 'Something Dark'),
(3, 'Eleven Poems'),
(3, 'Death of a Naturalist'),
(3, 'Human Chain'),
(3, 'Electric Light'),
(3, 'North'),
(3, 'Opened Ground'),
(4, 'The Green Fool'),
(4, 'The Great Hunger'),
(4, 'Innocence'),
(4, 'The Complete Poems'),
(5, 'Ulysses'),
(5, 'Pomes Penyeach'),
(5, 'Poems & Exiles'),
(6, 'A Poetry Handbook'),
(6, 'Devotions'),
(6, 'Blue Horses'),
(6, 'Upstream'),
(6, 'Owls and other Fantasies'),
(6, 'Rules for the Dance'),
(6, 'Dog Songs'),
(7, 'I Know Why the Caged Bird Sings'),
(7, 'Life doesnt frighten me'),
(7, 'And Still I Rise'),
(7, 'The Heart of a Woman'),
(7, 'Mother'),
(8, 'Rapture'),
(8, 'Armistice'),
(8, '101 Poems for Children'),
(9, 'the sun and her flowers'),
(9, 'milk and honey'),
(9, 'healing through words'),
(9, 'home body'),
(10, 'Your Silence Will Not Protect You'),
(10, 'The Black Unicorn'),
(10, 'A Burst of Light'),
(10, 'Sister Outsider');

-- It needs to be possible to determine whether a book is available to be borrowed by a reader.
-- This will be so if the return date for the book is in the past or if the book does not feature in the Borrowing table.
-- The below function therefore returns whether a book with given b_id is available.

DELIMITER //

CREATE FUNCTION availability(b_id INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
DECLARE availability VARCHAR(20);
		IF (SELECT return_date FROM Borrowing as B WHERE B.b_id = b_id) < CURDATE() 
        OR (SELECT return_date FROM Borrowing as B WHERE B.b_id = b_id) IS NULL 
        THEN
			SET availability = 'Available now';
		ELSE
			SET availability = 'On loan';
END IF;
RETURN availability;
END//

DELIMITER ;

-- It needs to be possible to query book, author and availability info without displaying reader info.
-- The below view uses a join and calls the above function to make such querying straightforward.

CREATE VIEW books_availability AS (
SELECT k.b_id, k.a_id, k.title, availability(k.b_id) AS availability
FROM Books AS k
LEFT JOIN Borrowing AS w
ON k.b_id = w.b_id);

-- Checking view

-- SELECT*
-- FROM books_availability; 

-- Use this query to check interactions with post/delete have worked as expected.
SELECT* FROM Borrowing;
