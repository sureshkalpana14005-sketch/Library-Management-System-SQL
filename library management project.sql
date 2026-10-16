CREATE DATABASE library_management;
# create author table #
USE library_management;
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);
DESC authors;
SELECT * FROM authors;

# create categories table #
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

# create books table #
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category_id INT,
    published_year YEAR,
    quantity INT,
    FOREIGN KEY (author_id)
    REFERENCES authors(author_id),
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);
# create members table #
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    join_date DATE
);

# create librarian table #
CREATE TABLE librarians (
    librarian_id INT PRIMARY KEY AUTO_INCREMENT,
    librarian_name VARCHAR(100),
    phone VARCHAR(15)
);

# create book issue table #
CREATE TABLE issued_books (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    librarian_id INT,
    issue_date DATE,
    return_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (book_id)
    REFERENCES books(book_id),
    FOREIGN KEY (member_id)
    REFERENCES members(member_id),
    FOREIGN KEY (librarian_id)
    REFERENCES librarians(librarian_id)
);

# create fine table #
CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    issue_id INT,
    fine_amount DECIMAL(10,2),
    FOREIGN KEY (issue_id)
    REFERENCES issued_books(issue_id)
);

# insert authoer name #
INSERT INTO authors(author_name)
VALUES
('Abdul Kalam'),
('kalki'),
('Chetan bhagat'),
('J.K.Rowling'),
('Shakespeare'),
('Daisy'),
('Jayagandhan'),
('Vairamuthu'),
('leo tolstoy'),
('kalki');
SELECT * FROM authors;

# insert the catagories name #
INSERT INTO categories(category_name)
VALUES
('Science'),
('Fantasy'),
('Novel'),
('Fantasy'),
('Novel'),
('Psychology'),
('Poem'),
('Poem'),
('Fiction'),
('Fantasy');
SELECT * FROM categories;

# insert books table #
INSERT INTO books
(title, author_id, category_id, published_year, quantity)
VALUES
('Wings of Fire', 1, 1, 1999, 10),
('Ponniyin Selvan',2,2,1989,25),
('Half Girlfriend', 3, 3, 2014, 5),
('Harry Potter', 4, 4, 2001, 8),
('Bold Man',5,5,2005,56),
('Psychology of money',6,6,1999,20),
('tamil poem',7,7,1989,34),
('kalikattu ithikasam',8,8,1967,256),
('life of pi',9,9,1998,45),
('nadhapurathu nayagi',10,10,1998,45);
select * from books;

SELECT
    books.title,
    authors.author_name
FROM books
JOIN authors
ON books.author_id = authors.author_id;

SELECT
    members.member_name,
    books.title,
    issued_books.issue_date
FROM issued_books
JOIN members
ON issued_books.member_id = members.member_id
JOIN books
ON issued_books.book_id = books.book_id;

SELECT COUNT(*) AS total_books
FROM books;

SELECT SUM(quantity)
FROM books;

UPDATE books
SET quantity = 15
WHERE book_id = 1;

DELIMITER //

CREATE PROCEDURE show_books()
BEGIN
    SELECT * FROM books;
END //

DELIMITER ;
CALL show_books();