-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 08, 2021 at 06:40 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apptest_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(50) NOT NULL,
  `rate` decimal(11,0) NOT NULL,
  `desc` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `create_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `type`, `rate`, `desc`, `status`, `create_date`) VALUES
(1, 'Weekly Subscription', 'weekly', '500', 'Weekly Subscription,\r\nWeekly Subscription', '1', '2021-09-08'),
(2, 'Monthly Subscription', 'monthly', '1500', 'monthly Subscription,\r\nmonthly Subscription', '1', '2021-09-08');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(50) NOT NULL,
  `pl_id` int(5) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `next_payment_date` date DEFAULT NULL,
  `pl_rate` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `create_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `user_id`, `pl_id`, `payment_date`, `next_payment_date`, `pl_rate`, `status`, `create_date`) VALUES
(1, 42, 1, '2021-09-01', '2021-09-08', 500, '1', '2021-09-01'),
(2, 42, 1, '2021-09-08', '2021-09-15', 500, '1', '2021-09-08');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `auth_key` mediumtext NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact` varchar(12) NOT NULL,
  `address` mediumtext NOT NULL,
  `password` varchar(200) NOT NULL,
  `status` enum('1','0') NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_id`, `auth_key`, `name`, `email`, `contact`, `address`, `password`, `status`, `create_date`) VALUES
(42, 'fkhan961', '3a0baac5c871336827f6f73dfbf5fdc0', 'Fazil Khan', 'fkhan961@gmail.com', '', '', 'TVRJek5BPT0=', '1', '2017-05-17 09:32:26'),
(44, '', '', 'khan', 'khan@gmail.com', '8090825667', '', 'TVRJek5BPT0=', '0', '2017-07-09 07:29:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
