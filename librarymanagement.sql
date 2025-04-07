CREATE DATABASE IF NOT EXISTS LibraryManagement;

USE LibraryManagement;

CREATE TABLE IF NOT EXISTS Nationalities (
	id BIGINT NOT NULL AUTO_INCREMENT,
    nationality VARCHAR(50) NOT NULL,
		PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Authors (
	id BIGINT NOT NULL AUTO_INCREMENT,
    firstN VARCHAR(30) NOT NULL,
    lastN VARCHAR(30) NOT NULL,
    nationality BIGINT NOT NULL,
    description TEXT,
		PRIMARY KEY(id),
        FOREIGN KEY(nationality) REFERENCES Nationalities(id)
);

CREATE TABLE IF NOT EXISTS Publishers (
	id BIGINT NOT NULL AUTO_INCREMENT,
    publisher VARCHAR(50) NOT NULL,
		PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS BookInfo (
	id BIGINT NOT NULL AUTO_INCREMENT,
    isbn VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    author_id BIGINT NOT NULL,
    book_ed INT NOT NULL,
    genre ENUM("Graphic Novel", "Terror", "Classic") NOT NULL,
    publish_date DATE NOT NULL,
    publisher_id BIGINT NOT NULL,
		PRIMARY KEY(id),
		FOREIGN KEY(publisher_id) REFERENCES Publishers(id)
);

ALTER TABLE BookInfo ADD UNIQUE(isbn);

CREATE TABLE IF NOT EXISTS BookAuthors(
	book_id BIGINT NOT NULL,
    author_id BIGINT NOT NULL,
		PRIMARY KEY(book_id, author_id),
        FOREIGN KEY(book_id) REFERENCES BookInfo(id),
        FOREIGN KEY(author_id) REFERENCES Authors(id)
); 

CREATE TABLE IF NOT EXISTS BookCopy(
	id BIGINT NOT NULL AUTO_INCREMENT,
    acquisition_date DATE NOT NULL,
    status ENUM("Available", "Borrowed", "Lost") NOT NULL,
    isbn VARCHAR(50) NOT NULL,
		PRIMARY KEY(id),
        FOREIGN KEY(isbn) REFERENCES BookInfo(isbn)
);

CREATE TABLE IF NOT EXISTS Clients (
	id BIGINT NOT NULL AUTO_INCREMENT,
    firstN VARCHAR(30) NOT NULL,
    lastN VARCHAR(30) NOT NULL,
	email VARCHAR(60) NOT NULL,
    cellphone VARCHAR(30) NOT NULL,
		PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Checkout(
	id INT NOT NULL AUTO_INCREMENT,
    checkout_date DATE NOT NULL,
    exp_checkin DATE NOT NULL,
    checkin_date DATE NOT NULL,
    status BOOLEAN NOT NULL,
    copy_id BIGINT NOT NULL,
    client_id BIGINT NOT NULL,
		PRIMARY KEY(id),
        FOREIGN KEY(copy_id) REFERENCES BookCopy(id),
        FOREIGN KEY(client_id) REFERENCES Clients(id)
);

SELECT c.id AS client_id, CONCAT(c.firstN, ' ', c.lastN) AS ClientName, COUNT(ch.id) AS total_checkouts
	FROM Checkout AS ch
	JOIN Clients AS c ON c.id = ch.client_id
	GROUP BY c.id, ClientName;








