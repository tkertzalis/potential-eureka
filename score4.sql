-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Φιλοξενητής: 127.0.0.1
-- Χρόνος δημιουργίας: 16 Δεκ 2020 στις 12:14:24
-- Έκδοση διακομιστή: 10.4.14-MariaDB
-- Έκδοση PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Βάση δεδομένων: `score4`
--
CREATE DATABASE IF NOT EXISTS `score4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `score4`;

DELIMITER $$
--
-- Διαδικασίες
--
DROP PROCEDURE IF EXISTS `clean_board`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_board` ()  BEGIN 
	REPLACE INTO board SELECT * FROM board_empty;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `board`
--

DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `p_color` enum('Y','R') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `board`
--

INSERT INTO `board` (`x`, `y`, `p_color`) VALUES
(1, 1, NULL),
(1, 2, NULL),
(1, 3, NULL),
(1, 4, NULL),
(1, 5, NULL),
(1, 6, NULL),
(2, 1, NULL),
(2, 2, NULL),
(2, 3, NULL),
(2, 4, NULL),
(2, 5, NULL),
(2, 6, NULL),
(3, 1, NULL),
(3, 2, NULL),
(3, 3, NULL),
(3, 4, NULL),
(3, 5, NULL),
(3, 6, NULL),
(4, 1, NULL),
(4, 2, NULL),
(4, 3, NULL),
(4, 4, NULL),
(4, 5, NULL),
(4, 6, NULL),
(5, 1, NULL),
(5, 2, NULL),
(5, 3, NULL),
(5, 4, NULL),
(5, 5, NULL),
(5, 6, NULL),
(6, 1, NULL),
(6, 2, NULL),
(6, 3, NULL),
(6, 4, NULL),
(6, 5, NULL),
(6, 6, NULL),
(7, 1, NULL),
(7, 2, NULL),
(7, 3, NULL),
(7, 4, NULL),
(7, 5, NULL),
(7, 6, NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `board_empty`
--

DROP TABLE IF EXISTS `board_empty`;
CREATE TABLE `board_empty` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `p_color` enum('Y','R') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `board_empty`
--

INSERT INTO `board_empty` (`x`, `y`, `p_color`) VALUES
(1, 1, NULL),
(1, 2, NULL),
(1, 3, NULL),
(1, 4, NULL),
(1, 5, NULL),
(1, 6, NULL),
(2, 1, NULL),
(2, 2, NULL),
(2, 3, NULL),
(2, 4, NULL),
(2, 5, NULL),
(2, 6, NULL),
(3, 1, NULL),
(3, 2, NULL),
(3, 3, NULL),
(3, 4, NULL),
(3, 5, NULL),
(3, 6, NULL),
(4, 1, NULL),
(4, 2, NULL),
(4, 3, NULL),
(4, 4, NULL),
(4, 5, NULL),
(4, 6, NULL),
(5, 1, NULL),
(5, 2, NULL),
(5, 3, NULL),
(5, 4, NULL),
(5, 5, NULL),
(5, 6, NULL),
(6, 1, NULL),
(6, 2, NULL),
(6, 3, NULL),
(6, 4, NULL),
(6, 5, NULL),
(6, 6, NULL),
(7, 1, NULL),
(7, 2, NULL),
(7, 3, NULL),
(7, 4, NULL),
(7, 5, NULL),
(7, 6, NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `game_status`
--

DROP TABLE IF EXISTS `game_status`;
CREATE TABLE `game_status` (
  `status` enum('not active','initialized','started','ended','aborted') NOT NULL,
  `p_turn` enum('Y','R') DEFAULT NULL,
  `result` enum('Y','R','D') DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `game_status`
--

INSERT INTO `game_status` (`status`, `p_turn`, `result`, `last_change`) VALUES
('not active', NULL, NULL, '2020-12-16 11:12:40');

--
-- Δείκτες `game_status`
--
DROP TRIGGER IF EXISTS `set_Status_lastchange`;
DELIMITER $$
CREATE TRIGGER `set_Status_lastchange` BEFORE UPDATE ON `game_status` FOR EACH ROW SET NEW.last_change = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `username` varchar(20) DEFAULT NULL,
  `player_color` enum('Y','R') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `last_action` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `players`
--


--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `board`
--
ALTER TABLE `board`
  ADD PRIMARY KEY (`x`,`y`);

--
-- Ευρετήρια για πίνακα `board_empty`
--
ALTER TABLE `board_empty`
  ADD PRIMARY KEY (`x`,`y`);

--
-- Ευρετήρια για πίνακα `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`player_color`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
