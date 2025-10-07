CREATE TABLE Customers(
	customer_id int NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	payment_number char(16) NOT NULL
);
CREATE TABLE Lines(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	x1 float NOT NULL,
	y1 float NOT NULL,
	x2 float NOT NULL,
	y2 float NOT NULL,
 CONSTRAINT PK_Lines PRIMARY KEY (id));

CREATE TABLE Minions(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	"name" varchar(50) NULL,
	age int NULL
);

CREATE TABLE People(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	email varchar(255) NOT NULL,
	first_name VARCHAR(50) NULL,
	last_name VARCHAR(50) NULL,
	salary money NULL,
PRIMARY KEY(id));

CREATE TABLE Products(
	id int NOT NULL,
	"name" varchar(50) NOT NULL,
	quantity int NOT NULL,
	box_capacity int NOT NULL,
	pallet_capacity int NOT NULL,
 CONSTRAINT PK_Products PRIMARY KEY (id));

CREATE TABLE Rectangles(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	A float NOT NULL,
	B float NOT NULL,
 CONSTRAINT PK_Rectangles PRIMARY KEY(id));

CREATE TABLE Towns(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	"name" varchar(50) NULL,
PRIMARY KEY (id));

CREATE TABLE Triangles(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	A float NOT NULL,
	B float NOT NULL,
	C float NOT NULL,
 CONSTRAINT PK_Triangles PRIMARY KEY (id));

CREATE TABLE Triangles2(
	id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	A float NOT NULL,
	H float NOT NULL
);

INSERT INTO customers (customer_id, first_name, last_name, payment_number) 
VALUES
(1, 'Guy', 'Gilbert', '5645322227179083'),
(2, 'Kevin', 'Brown', '4417937746396076'),
(3, 'Thomas', 'Smith', '3530111333300000'),
(4, 'Maria', 'Alonso', '5555555555554444'),
(5, 'Laurence', 'Lebihan', '5100170000000005'),
(6, 'Elizabeth', 'Lincoln', '4024007143542583'),
(7, 'Victoria', 'Ashworth', '340000000000009'),
(8, 'Patricio', 'Simpson', '5105105105105100'),
(9, 'Francisco', 'Chang', '4111111111111111'),
(10, 'Yang', 'Wang', '378282246310005'),
(11, 'Pedro', 'Afonso', '6011000990139424'),
(12, 'Carlos', 'Hernandez', '30569309025904'),
(13, 'Yoshi', 'Latimer', '5555555555554444'),
(14, 'Helen', 'Bennett', '4111111111111111'),
(15, 'Philip', 'Cramer', '6011111111111117'),
(16, 'Daniel', 'Tonini', '3530111333300000'),
(17, 'Ann', 'Devon', '5555555555554444'),
(18, 'Roland', 'Mendel', '378734493671000'),
(19, 'Lino', 'Rodriguez', '5105105105105100'),
(20, 'George', 'Taylor', '4111111111111111'),
(21, 'Sue', 'Turner', '340000000000009'),
(22, 'Jaime', 'Yorres', '6011000990139424'),
(23, 'Carlos', 'Gonzalez', '30569309025904'),
(24, 'Carlos', 'Diaz', '5555555555554444'),
(25, 'Felipe', 'Garcia', '4111111111111111'),
(26, 'Francisco', 'Andrade', '6011111111111117'),
(27, 'Giovanni', 'Rovelli', '3530111333300000'),
(28, 'Marie', 'Bertrand', '5555555555554444'),
(29, 'Roland', 'Keitel', '378734493671000'),
(30, 'Peter', 'Franken', '5105105105105100'),
(31, 'Henriette', 'Pfalzheim', '4111111111111111'),
(32, 'Luc', 'Vandebroek', '340000000000009'),
(33, 'George', 'Pipps', '6011000990139424'),
(34, 'Thomas', 'Hardy', '30569309025904'),
(35, 'Christina', 'Berglund', '5555555555554444'),
(36, 'Hanna', 'Moos', '4111111111111111'),
(37, 'Frederique', 'Citeaux', '6011111111111117'),
(38, 'Martin', 'Sommer', '3530111333300000'),
(39, 'Laurence', 'Lebihan', '5555555555554444'),
(40, 'Elizabeth', 'Lincoln', '378734493671000'),
(41, 'Victoria', 'Ashworth', '5105105105105100'),
(42, 'Patricio', 'Simpson', '4111111111111111'),
(43, 'Francisco', 'Chang', '340000000000009'),
(44, 'Yang', 'Wang', '6011000990139424'),
(45, 'Pedro', 'Afonso', '30569309025904'),
(46, 'Carlos', 'Hernandez', '5555555555554444'),
(47, 'Yoshi', 'Latimer', '4111111111111111'),
(48, 'Helen', 'Bennett', '6011111111111117'),
(49, 'Philip', 'Cramer', '3530111333300000'),
(50, 'Daniel', 'Tonini', '5555555555554444'),
(51, 'Ann', 'Devon', '378734493671000'),
(52, 'Roland', 'Mendel', '5105105105105100'),
(53, 'Lino', 'Rodriguez', '4111111111111111'),
(54, 'George', 'Taylor', '340000000000009'),
(55, 'Sue', 'Turner', '6011000990139424'),
(56, 'Jaime', 'Yorres', '30569309025904'),
(57, 'Carlos', 'Gonzalez', '5555555555554444'),
(58, 'Carlos', 'Diaz', '4111111111111111'),
(59, 'Felipe', 'Garcia', '6011111111111117'),
(60, 'Francisco', 'Andrade', '3530111333300000'),
(61, 'Giovanni', 'Rovelli', '5555555555554444'),
(62, 'Marie', 'Bertrand', '378734493671000'),
(63, 'Roland', 'Keitel', '5105105105105100'),
(64, 'Peter', 'Franken', '4111111111111111'),
(65, 'Henriette', 'Pfalzheim', '340000000000009'),
(66, 'Luc', 'Vandebroek', '6011000990139424'),
(67, 'George', 'Pipps', '30569309025904'),
(68, 'Thomas', 'Hardy', '5555555555554444'),
(69, 'Christina', 'Berglund', '4111111111111111'),
(70, 'Hanna', 'Moos', '6011111111111117'),
(71, 'Frederique', 'Citeaux', '3530111333300000'),
(72, 'Martin', 'Sommer', '5555555555554444'),
(73, 'Laurence', 'Lebihan', '378734493671000'),
(74, 'Elizabeth', 'Lincoln', '5105105105105100'),
(75, 'Victoria', 'Ashworth', '4111111111111111'),
(76, 'Patricio', 'Simpson', '340000000000009'),
(77, 'Francisco', 'Chang', '6011000990139424'),
(78, 'Yang', 'Wang', '30569309025904'),
(79, 'Pedro', 'Afonso', '5555555555554444'),
(80, 'Carlos', 'Hernandez', '4111111111111111'),
(81, 'Yoshi', 'Latimer', '6011111111111117'),
(82, 'Helen', 'Bennett', '3530111333300000'),
(83, 'Philip', 'Cramer', '5555555555554444'),
(84, 'Daniel', 'Tonini', '378734493671000'),
(85, 'Ann', 'Devon', '5105105105105100'),
(86, 'Roland', 'Mendel', '4111111111111111'),
(87, 'Lino', 'Rodriguez', '340000000000009'),
(88, 'George', 'Taylor', '6011000990139424'),
(89, 'Sue', 'Turner', '30569309025904'),
(90, 'Jaime', 'Yorres', '5555555555554444'),
(91, 'Carlos', 'Gonzalez', '4111111111111111'),
(92, 'Carlos', 'Diaz', '6011111111111117'),
(93, 'Felipe', 'Garcia', '3530111333300000'),
(94, 'Francisco', 'Andrade', '5555555555554444'),
(95, 'Giovanni', 'Rovelli', '378734493671000'),
(96, 'Marie', 'Bertrand', '5105105105105100'),
(97, 'Roland', 'Keitel', '4111111111111111'),
(98, 'Peter', 'Franken', '340000000000009'),
(99, 'Henriette', 'Pfalzheim', '6011000990139424'),
(100, 'Luc', 'Vandebroek', '30569309025904');


INSERT INTO Lines (Id, x1, y1, x2, y2)
OVERRIDING SYSTEM VALUE
VALUES
    (1, 0, 0, 10, 0),
    (2, 0, 0, 5, 3),
    (4, -1, 5, 8, -3),
    (5, 18, 23, 8882, 134);


INSERT INTO Products (Id, "name", quantity, box_capacity, pallet_capacity)
OVERRIDING SYSTEM VALUE
VALUES
    (1, 'Perlenbacher 500ml', 108, 6, 18),
    (2, 'Perlenbacher 500ml', 10, 6, 18),
    (3, 'Chocolate Chips', 350, 24, 3),
    (4, 'Oil Pump', 100, 1, 12),
    (5, 'OLED TV 50-Inch', 13, 1, 5),
    (6, 'Penny', 1, 2239488, 1);


INSERT INTO Rectangles (Id, A, B)
OVERRIDING SYSTEM VALUE
VALUES
    (1, 2, 4),
    (2, 1, 18),
    (3, 4.5, 3),
    (4, 8, 12),
    (5, 3, 5);


INSERT INTO Triangles (Id, A, B, C)
OVERRIDING SYSTEM VALUE
VALUES
    (1, 3, 4, 5),
    (2, 2, 5, 4),
    (3, 1.5, 1.5, 2),
    (4, 3.5, 4.15, 6),
    (5, 4, 2, 4);

INSERT INTO Triangles2 (Id, A, H)
OVERRIDING SYSTEM VALUE
VALUES
    (1, 2, 4),
    (2, 1, 18),
    (3, 4.5, 3),
    (4, 8, 12),
    (5, 3, 5);


ALTER TABLE People ADD UNIQUE (email);