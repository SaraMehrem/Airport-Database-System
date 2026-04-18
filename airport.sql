-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2023 at 04:21 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airport`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `airplaine` ()   BEGIN
SELECT COUNT(*),id FROM airplane 
GROUP BY model
HAVING COUNT(*) >= 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `passengerInfo` (IN `SSN` CHARACTER)   BEGIN
 SELECT passenger.fname AS 'First Name', 
 passenger.lname AS 'Last Name',
 passenger.email AS 'Email', address.address AS 'Address'
 FROM passenger 
 JOIN address ON address.passenger_SSN = passenger.SSN
 WHERE passenger.SSN = SSN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `passenger_num` ()   BEGIN
 SELECT COUNT(*) FROM passenger;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_airplanes` ()   BEGIN
 SELECT * FROM airplane;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_passengerInfo` (IN `SSN` CHARACTER)   BEGIN
 SELECT passenger.fname AS 'First Name', 
 passenger.lname AS 'Last Name',
 passenger.email AS 'Email', address.address AS 'Address'
 FROM passenger 
 JOIN address ON address.passenger_SSN = passenger.SSN
 WHERE passenger.SSN = SSN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_salary` (IN `emp_id` CHARACTER)   BEGIN
 UPDATE employee SET salary = salary + 100
 WHERE id = emp_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `passenger_SSN` char(9) NOT NULL,
  `address` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`passenger_SSN`, `address`) VALUES
('002345678', 'irbid'),
('012345678', 'amman'),
('111111111', 'amman'),
('111111111', 'salt');

-- --------------------------------------------------------

--
-- Table structure for table `airplane`
--

CREATE TABLE `airplane` (
  `id` char(8) NOT NULL,
  `model` varchar(25) DEFAULT 'unknown',
  `capacity` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airplane`
--

INSERT INTO `airplane` (`id`, `model`, `capacity`, `status`) VALUES
('1', 'airbus', 195, 'active'),
('2', 'Boening', 410, 'active'),
('3', 'embraer', 145, 'active'),
('5', 'unknown', 200, 'in maintenance');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` char(8) NOT NULL,
  `fname` varchar(15) NOT NULL,
  `lname` varchar(15) NOT NULL,
  `email` varchar(40) NOT NULL,
  `emp_password` varchar(8) NOT NULL,
  `salary` decimal(6,2) DEFAULT NULL,
  `phone_number` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `fname`, `lname`, `email`, `emp_password`, `salary`, `phone_number`) VALUES
('12345678', 'sally', 'A', 'sallya@gmail.com', '123', 1400.00, '790000000'),
('23456789', 'ali', 'B', 'alib@gmail.com', '1234', 1700.00, '790000001'),
('34567891', 'rose', 'C', 'rosec@gmail.com', '12345', 2500.00, '790000002');

-- --------------------------------------------------------

--
-- Stand-in structure for view `emp_info`
-- (See below for the actual view)
--
CREATE TABLE `emp_info` (
`id` char(8)
,`fname` varchar(15)
,`lname` varchar(15)
,`email` varchar(40)
,`emp_password` varchar(8)
,`salary` decimal(6,2)
,`phone_number` char(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `number` int(11) NOT NULL,
  `destination` varchar(30) NOT NULL,
  `flight_date` date NOT NULL,
  `flight_time` time NOT NULL,
  `emp_id` char(8) DEFAULT NULL,
  `airplane_id` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`number`, `destination`, `flight_date`, `flight_time`, `emp_id`, `airplane_id`) VALUES
(2, 'qatar', '2023-09-09', '06:00:00', '12345678', '2'),
(3, 'USA', '2023-10-05', '05:30:00', '12345678', '1');

-- --------------------------------------------------------

--
-- Table structure for table `flight_booking`
--

CREATE TABLE `flight_booking` (
  `flight_num` int(11) NOT NULL,
  `passenger_SSN` char(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flight_booking`
--

INSERT INTO `flight_booking` (`flight_num`, `passenger_SSN`) VALUES
(2, '002345678'),
(2, '111111111'),
(3, '111111111');

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `SSN` char(9) NOT NULL,
  `fname` varchar(15) NOT NULL,
  `lname` varchar(15) NOT NULL,
  `email` varchar(40) NOT NULL,
  `passenger_password` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passenger`
--

INSERT INTO `passenger` (`SSN`, `fname`, `lname`, `email`, `passenger_password`) VALUES
('002345678', 'jana', 'J', 'janaJ@gmail.com', '111'),
('012345678', 'leen', 'L', 'leenl@gmail.com', '123l'),
('111111111', 's', 's', 'sara@gmail.com', '123'),
('111111112', 'same', 'S', 'samS@gmail.com', '123s');

-- --------------------------------------------------------

--
-- Stand-in structure for view `passenger_info`
-- (See below for the actual view)
--
CREATE TABLE `passenger_info` (
`First Name` varchar(15)
,`Last Name` varchar(15)
,`Email` varchar(40)
,`Address` varchar(60)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_flights`
-- (See below for the actual view)
--
CREATE TABLE `view_flights` (
`Flight Number` int(11)
,`destination` varchar(30)
,`Date` date
,`Time` time
);

-- --------------------------------------------------------

--
-- Structure for view `emp_info`
--
DROP TABLE IF EXISTS `emp_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `emp_info`  AS SELECT `employee`.`id` AS `id`, `employee`.`fname` AS `fname`, `employee`.`lname` AS `lname`, `employee`.`email` AS `email`, `employee`.`emp_password` AS `emp_password`, `employee`.`salary` AS `salary`, `employee`.`phone_number` AS `phone_number` FROM `employee` WHERE `employee`.`salary` > 1000 ORDER BY `employee`.`id` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `passenger_info`
--
DROP TABLE IF EXISTS `passenger_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `passenger_info`  AS SELECT `passenger`.`fname` AS `First Name`, `passenger`.`lname` AS `Last Name`, `passenger`.`email` AS `Email`, `address`.`address` AS `Address` FROM (`passenger` left join `address` on(`address`.`passenger_SSN` = `passenger`.`SSN`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_flights`
--
DROP TABLE IF EXISTS `view_flights`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_flights`  AS SELECT `flight`.`number` AS `Flight Number`, `flight`.`destination` AS `destination`, `flight`.`flight_date` AS `Date`, `flight`.`flight_time` AS `Time` FROM `flight` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`passenger_SSN`,`address`);

--
-- Indexes for table `airplane`
--
ALTER TABLE `airplane`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`number`),
  ADD KEY `empflight_fk` (`emp_id`),
  ADD KEY `airflight_fk` (`airplane_id`);

--
-- Indexes for table `flight_booking`
--
ALTER TABLE `flight_booking`
  ADD PRIMARY KEY (`flight_num`,`passenger_SSN`),
  ADD KEY `passenger_fk` (`passenger_SSN`);

--
-- Indexes for table `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`SSN`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_fk` FOREIGN KEY (`passenger_SSN`) REFERENCES `passenger` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `airflight_fk` FOREIGN KEY (`airplane_id`) REFERENCES `airplane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `empflight_fk` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `flight_booking`
--
ALTER TABLE `flight_booking`
  ADD CONSTRAINT `flight_fk` FOREIGN KEY (`flight_num`) REFERENCES `flight` (`number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_fk` FOREIGN KEY (`passenger_SSN`) REFERENCES `passenger` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
