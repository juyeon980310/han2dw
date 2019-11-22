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
-- Database: `rental`
--

-- --------------------------------------------------------

--
-- Table structure for table `key_mgt`
--

CREATE TABLE `key_mgt` (
  `key_num` int(4) UNSIGNED ZEROFILL NOT NULL,
  `key_id` tinytext,
  `uniq_no` tinytext NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tag_rental`
--

CREATE TABLE `tag_rental` (
  `key_id` tinytext,
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `r_date` date NOT NULL,
  `b_date` date NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `home` tinytext NOT NULL,
  `natinal` tinytext NOT NULL,
  `passport_num` int(20) NOT NULL,
  `sex` tinytext NOT NULL,
  `tel` tinytext NOT NULL,
  `email` tinytext NOT NULL,
  `temp` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `key_mgt`
--
ALTER TABLE `key_mgt`
  ADD PRIMARY KEY (`key_num`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `key_mgt`
--
ALTER TABLE `key_mgt`
  MODIFY `key_num` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
