-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 10, 2022 at 04:54 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nippon_paint`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_code` int(11) NOT NULL,
  `customer_name` varchar(50) NOT NULL,
  `customer_group` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_code`, `customer_name`, `customer_group`) VALUES
(2001, 'Saman Enp', 'Distributors'),
(2002, 'Nimal H/W store', 'Hardwares');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `inv_number` int(11) NOT NULL,
  `customer_code` int(11) NOT NULL,
  `invoice_date` varchar(20) NOT NULL,
  `invoice_setoff_date` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`inv_number`, `customer_code`, `invoice_date`, `invoice_setoff_date`) VALUES
(1001, 2001, '2022-10-01', '2022-10-05'),
(1002, 2002, '2022-09-05', '2022-09-15'),
(1003, 2001, '2022-08-20', '2022-09-04');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_detail`
--

CREATE TABLE `invoice_detail` (
  `invoice_number` int(11) NOT NULL,
  `material` int(11) NOT NULL,
  `material name` varchar(50) NOT NULL,
  `material_group` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice_detail`
--

INSERT INTO `invoice_detail` (`invoice_number`, `material`, `material name`, `material_group`, `quantity`, `value`) VALUES
(1001, 3001, 'emulsion brilliant white', 'emulsion', 10, 15000),
(1001, 3004, 'emulsion blue', 'emulsion', 5, 5000),
(1001, 3003, 'waterbase teak', 'waterbase', 1, 1500),
(1002, 3003, 'waterbase teak', 'waterbase', 3, 4500),
(1003, 3001, 'emulsion brilliant white', 'emulsion', 6, 9000),
(1003, 3002, 'enamal black', 'enamal', 4, 4000);

-- --------------------------------------------------------

--
-- Table structure for table `material_group`
--

CREATE TABLE `material_group` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `material_group`
--

INSERT INTO `material_group` (`group_id`, `group_name`) VALUES
(1, 'emulsion'),
(2, 'enamal'),
(3, 'waterbase');

-- --------------------------------------------------------

--
-- Table structure for table `schema_detail`
--

CREATE TABLE `schema_detail` (
  `schema_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `time_slots` int(11) NOT NULL,
  `material_group` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `schema_detail`
--

INSERT INTO `schema_detail` (`schema_id`, `value`, `time_slots`, `material_group`) VALUES
(1, 100, 1, 1),
(2, 75, 2, 1),
(3, 50, 3, 1),
(4, 70, 1, 2),
(5, 50, 2, 2),
(6, 20, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `time_slots`
--

CREATE TABLE `time_slots` (
  `id` int(11) NOT NULL,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `time_slots`
--

INSERT INTO `time_slots` (`id`, `from`, `to`) VALUES
(1, 1, 7),
(2, 8, 15),
(3, 16, 21),
(4, 22, 35);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_code`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`inv_number`),
  ADD KEY `customer_code` (`customer_code`);

--
-- Indexes for table `invoice_detail`
--
ALTER TABLE `invoice_detail`
  ADD KEY `invoice number` (`invoice_number`);

--
-- Indexes for table `material_group`
--
ALTER TABLE `material_group`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `schema_detail`
--
ALTER TABLE `schema_detail`
  ADD PRIMARY KEY (`schema_id`),
  ADD KEY `material_group` (`material_group`),
  ADD KEY `time_slots` (`time_slots`);

--
-- Indexes for table `time_slots`
--
ALTER TABLE `time_slots`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `inv_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1004;

--
-- AUTO_INCREMENT for table `material_group`
--
ALTER TABLE `material_group`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `schema_detail`
--
ALTER TABLE `schema_detail`
  MODIFY `schema_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `time_slots`
--
ALTER TABLE `time_slots`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`customer_code`) REFERENCES `customers` (`customer_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_detail`
--
ALTER TABLE `invoice_detail`
  ADD CONSTRAINT `invoice_detail_ibfk_1` FOREIGN KEY (`invoice_number`) REFERENCES `invoice` (`inv_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schema_detail`
--
ALTER TABLE `schema_detail`
  ADD CONSTRAINT `schema_detail_ibfk_1` FOREIGN KEY (`material_group`) REFERENCES `material_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `schema_detail_ibfk_2` FOREIGN KEY (`time_slots`) REFERENCES `time_slots` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
