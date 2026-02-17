-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3320
-- Generation Time: Feb 15, 2026 at 07:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vehi`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `car` varchar(255) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `file_url` varchar(500) DEFAULT NULL,
  `da`date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','approved','rejected') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `customer_name`, `customer_id`, `vehicle_id`, `car`, `brand`, `price`, `type`, `file_url`, `date`, `status`) VALUES
(1, 'asfasf', 1, 1, 'asf', 'asf', 35235, 'sale', 'uploads\\5e180530-7d73-4d22-bcf9-0c6fb10fb98a.pdf', '2026-02-15', 'approved'),
(2, 'Test', NULL, 1, 'dfasd', 'sdfas', 2345235, 'lease', 'uploads\\876d9676-b781-4cb8-bdf0-1b84370c5d1f.pdf', '2026-02-15', 'rejected'),
(3, 'Pixel', 1, 1, 'dfasd', 'sdfas', 2345235, 'lease', 'uploads\\5e180530-7d73-4d22-bcf9-0c6fb10fb98a.pdf', '2026-02-15', 'rejected'),
(5, 'Pixel Values', 1, 2, 'sdf', 'sdf', 354235, 'sale', 'uploads\\b0fa5ab9-3a12-44b4-897d-374b6e3db0f7.pdf', '2026-02-15', 'pending'),
(6, 'Pixel Values', 1, 1, 'dfasd', 'sdfas', 2345235, 'lease', 'uploads\\47b746a8-a8f1-4bb4-bcee-11b32a51dc37.pdf', '2026-02-15', 'pending'),
(7, 'Pixel Values', 1, 1, 'dfasd', 'sdfas', 2345235, 'lease', 'uploads\\5b01ae95-0b23-4ec8-a01a-db02624aefde.pdf', '2026-02-15', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `address`) VALUES
(1, 'safsafd', 'a@sdg.dsf', '345235', 'dfsdf');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `car` varchar(255) NOT NULL,
  `type` enum('sale','lease') NOT NULL,
  `price` int(11) NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `brand`, `car`, `type`, `price`, `date`) VALUES
(1, 'sdfas', 'dfasd', 'lease', 2345235, '2026-02-05 13:41:28'),
(2, 'sdf', 'sdf', 'sale', 354235, '2026-02-15 08:11:04'),
(3, 'asd', 'asdas', 'sale', 234234234, '2026-02-15 08:11:15'),
(4, 'sdfas', 'dfasd', 'lease', 2345235, '2026-02-05 13:41:28'),
(5, 'sdf', 'sdf', 'sale', 354235, '2026-02-15 08:11:04'),
(6, 'asd', 'asdas', 'sale', 234234234, '2026-02-15 08:11:15'),
(7, 'test', 'testtt', 'sale', 987989, '2026-02-15 10:23:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `ix_applications_id` (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_customers_id` (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_vehicles_id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


]: [2026-02-16 01:11:20 +0530] [239363] [ERROR] Connection in use: ('127.0.0.1>
Feb 16 01:11:20 srv863079 gunicorn[239363]: [2026-02-16 01:11:20 +0530] [239363] [ERROR] connection to ('127.0.0.1', 80>
Feb 16 01:11:21 srv863079 gunicorn[239363]: [2026-02-16 01:11:21 +0530] [239363] [ERROR] Connection in use: ('127.0.0.1>
Feb 16 01:11:21 srv863079 gunicorn[239363]: [2026-02-16 01:11:21 +0530] [239363] [ERROR] connection to ('127.0.0.1', 80>
lines 1-16/16 (END)