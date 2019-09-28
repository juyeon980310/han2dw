-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- 생성 시간: 19-09-28 06:09
-- 서버 버전: 8.0.17
-- PHP 버전: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `fixed_type`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `constraint_current`
--

CREATE TABLE `constraint_current` (
  `no` int(4) UNSIGNED ZEROFILL NOT NULL,
  `g_code` double NOT NULL,
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `u_date` date NOT NULL,
  `d_date` date NOT NULL,
  `elapsed_time` time NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `constraint_log`
--

CREATE TABLE `constraint_log` (
  `no` int(4) UNSIGNED ZEROFILL NOT NULL,
  `g_code` double NOT NULL,
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `u_date` date NOT NULL,
  `d_date` date NOT NULL,
  `elapsed_time` time NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `constraint_current`
--
ALTER TABLE `constraint_current`
  ADD PRIMARY KEY (`no`);

--
-- 테이블의 인덱스 `constraint_log`
--
ALTER TABLE `constraint_log`
  ADD PRIMARY KEY (`no`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `constraint_current`
--
ALTER TABLE `constraint_current`
  MODIFY `no` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `constraint_log`
--
ALTER TABLE `constraint_log`
  MODIFY `no` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
