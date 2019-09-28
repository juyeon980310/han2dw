-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- 생성 시간: 19-06-01 18:20
-- 서버 버전: 10.1.38-MariaDB-0+deb9u1
-- PHP 버전: 7.0.33-0+deb9u3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `han2um`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `current`
--

CREATE TABLE `current` (
  `tag_num` char(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 테이블의 덤프 데이터 `current`
--

INSERT INTO `current` (`tag_num`, `date`, `time`) VALUES
('3', '2019-06-01', '13:30:30.000000'),
('3', '2019-06-01', '13:41:15.000000');

-- --------------------------------------------------------

--
-- 테이블 구조 `key_table`
--

CREATE TABLE `key_table` (
  `tag_num` int(255) NOT NULL,
  `tag_id` char(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `key_table`
--

INSERT INTO `key_table` (`tag_num`, `tag_id`) VALUES
(1, '0b329a15'),
(2, '09a46f63'),
(3, '45f2c6ef'),
(4, '791aca51'),
(5, '1jj2k1j2');

-- --------------------------------------------------------

--
-- 테이블 구조 `log_DB`
--

CREATE TABLE `log_DB` (
  `tag_num` char(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time(6) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 테이블의 덤프 데이터 `log_DB`
--

INSERT INTO `log_DB` (`tag_num`, `date`, `time`, `status`) VALUES
('3', '2019-06-01', '13:30:30.000000', 1),
('3', '2019-06-01', '13:41:15.000000', 1);

-- --------------------------------------------------------

--
-- 테이블 구조 `tag_rental`
--

CREATE TABLE `tag_rental` (
  `tag_num` char(20) DEFAULT NULL,
  `name` char(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time(6) DEFAULT NULL,
  `back` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `key_table`
--
ALTER TABLE `key_table`
  ADD PRIMARY KEY (`tag_num`,`tag_id`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `key_table`
--
ALTER TABLE `key_table`
  MODIFY `tag_num` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
