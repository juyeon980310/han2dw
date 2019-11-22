-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 22, 2019 at 03:01 PM
-- Server version: 10.1.41-MariaDB-0+deb9u1
-- PHP Version: 7.0.33-0+deb9u6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobile_type`
--

-- --------------------------------------------------------

--
-- Table structure for table `mobile_current`
--

CREATE TABLE `mobile_current` (
  `no` int(4) UNSIGNED ZEROFILL NOT NULL,
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `last_gcode` text NOT NULL,
  `current_gcode` text NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `direction` tinytext NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tag_use`
--

CREATE TABLE `tag_use` (
  `no` int(4) UNSIGNED ZEROFILL NOT NULL,
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `tag_id` tinytext,
  `tag_gcode` text NOT NULL,
  `tag_count` int(10) NOT NULL,
  `last_gcode` text NOT NULL,
  `direction` tinytext NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `elapsed_time` time NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mobile_current`
--
ALTER TABLE `mobile_current`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `tag_use`
--
ALTER TABLE `tag_use`
  ADD PRIMARY KEY (`no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mobile_current`
--
ALTER TABLE `mobile_current`
  MODIFY `no` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tag_use`
--
ALTER TABLE `tag_use`
  MODIFY `no` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
