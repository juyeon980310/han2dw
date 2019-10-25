-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- 생성 시간: 19-10-25 06:38
-- 서버 버전: 10.3.17-MariaDB-0+deb10u1
-- PHP 버전: 7.3.9-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `rental`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `key_mgt`
--

CREATE TABLE `key_mgt` (
  `key_num` int(4) UNSIGNED ZEROFILL NOT NULL,
  `key_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `uniq_no` tinytext NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `tag_rental`
--

CREATE TABLE `tag_rental` (
  `key_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `u_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `r_date` date NOT NULL,
  `b_date` date NOT NULL,
  `temp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `user`
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
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `key_mgt`
--
ALTER TABLE `key_mgt`
  ADD PRIMARY KEY (`key_num`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `key_mgt`
--
ALTER TABLE `key_mgt`
  MODIFY `key_num` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
