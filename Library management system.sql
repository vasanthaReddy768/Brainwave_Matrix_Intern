CREATE DATABASE Librarydb;
USE Librarydb;
CREATE TABLE Book (
    Book_ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Category VARCHAR(100),
    Publisher VARCHAR(255),
    Copies_Available INT DEFAULT 1
);
INSERT INTO Book (Title, Author, ISBN, Category, Publisher, Copies_Available) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 'Fiction', 'Scribner', 5),
('1984', 'George Orwell', '9780451524935', 'Dystopian', 'Signet Classics', 4);
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    Membership_Date DATE
);
INSERT INTO Member (Name, Email, Phone, Address, Membership_Date)
VALUES ('Alice Johnson', 'alice@email.com', '1234567890', '123 Main St', CURDATE());
CREATE TABLE Librarian (
    Librarian_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Password VARCHAR(255) NOT NULL
);
INSERT INTO Librarian (Name, Email, Phone, Password) VALUES
('John Doe', 'john.librarian@email.com', '5551234567', 'securepassword');

CREATE TABLE Borrow (
    Borrow_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Book_ID INT,
    Borrow_Date DATE,  -- Remove DEFAULT CURDATE()
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE
);
INSERT INTO Borrow (Member_ID, Book_ID, Borrow_Date, Due_Date)
VALUES (1, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));
CREATE TABLE Fine (
    Fine_ID INT PRIMARY KEY AUTO_INCREMENT,
    Borrow_ID INT UNIQUE,
    Amount DECIMAL(5,2) NOT NULL CHECK (Amount >= 0),
    Status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (Borrow_ID) REFERENCES Borrow(Borrow_ID) ON DELETE CASCADE
);

INSERT INTO Fine (Borrow_ID, Amount, Status) VALUES
(1, 10.00, 'Unpaid');

SELECT * FROM Borrow WHERE Borrow_ID = 1;
INSERT INTO Borrow (Member_ID, Book_ID, Borrow_Date, Due_Date)
VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));
SELECT * FROM Book WHERE Copies_Available > 0;

SELECT b.Title, br.Borrow_Date, br.Due_Date
FROM Borrow br
JOIN Book b ON br.Book_ID = b.Book_ID
WHERE br.Member_ID = 1;

SELECT m.Name, f.Amount
FROM Fine f
JOIN Borrow br ON f.Borrow_ID = br.Borrow_ID
JOIN Member m ON br.Member_ID = m.Member_ID
WHERE f.Status = 'Unpaid';





