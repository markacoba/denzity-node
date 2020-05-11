-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2020 at 05:44 AM
-- Server version: 5.7.14
-- PHP Version: 7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `denzity-app`
--

-- --------------------------------------------------------

--
-- Table structure for table `filteroptions`
--

CREATE TABLE `filteroptions` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '99',
  `active` tinyint(1) DEFAULT '1',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `filterId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `filteroptions`
--

INSERT INTO `filteroptions` (`id`, `label`, `value`, `sort`, `active`, `createdAt`, `updatedAt`, `filterId`) VALUES
(1, '$7-$200k', '7-200000', 1, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 2),
(2, '$201k-$500k', '201000-500000', 2, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 2),
(3, '$501k-$1M', '501000-1000000', 3, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 2),
(4, '0 Year - 5 Year', '0-5', 1, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 3),
(5, '6 Year - 10 Year', '6-10', 2, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 3),
(6, '10 Year - 20 Year', '10-20', 3, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 3),
(7, 'Open', 'open', 1, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 4),
(8, 'Closed', 'closed', 2, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 4),
(9, '0%-4%', '0-4', 1, 1, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5),
(10, '5%-25%', '5-25', 2, 1, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5),
(11, '26%-100%', '26-100', 3, 1, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5);

-- --------------------------------------------------------

--
-- Table structure for table `filters`
--

CREATE TABLE `filters` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `type` enum('option','float-range','integer-range') NOT NULL DEFAULT 'option',
  `fieldType` enum('dropdown','dropdown-multiple','checkbox') DEFAULT 'dropdown',
  `sort` int(11) NOT NULL DEFAULT '99',
  `dynamicOptions` tinyint(1) DEFAULT '1',
  `active` tinyint(1) DEFAULT '1',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `propertyId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `filters`
--

INSERT INTO `filters` (`id`, `label`, `type`, `fieldType`, `sort`, `dynamicOptions`, `active`, `createdAt`, `updatedAt`, `propertyId`) VALUES
(1, 'Location', 'option', 'dropdown-multiple', 1, 1, 1, '2020-05-10 13:56:41', '2020-05-10 13:56:41', 3),
(2, 'Min. Investment (USD)', 'float-range', 'dropdown', 2, 0, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 4),
(3, 'Estimated Hold (Years)', 'integer-range', 'dropdown', 3, 0, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 5),
(4, 'Availability Status', 'option', 'checkbox', 4, 0, 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00', 6),
(5, 'Target IRR (%)', 'float-range', 'dropdown', 5, 0, 1, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 7);

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

CREATE TABLE `pictures` (
  `id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `projectId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pictures`
--

INSERT INTO `pictures` (`id`, `filename`, `createdAt`, `updatedAt`, `projectId`) VALUES
(3, 'image1.jpg', '2020-05-11 04:20:40', '2020-05-11 04:20:40', 1),
(4, 'image2.jpg', '2020-05-11 04:20:44', '2020-05-11 04:20:44', 2);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `active`, `startDate`, `endDate`, `createdAt`, `updatedAt`) VALUES
(1, 'At the Roemerwerg', 1, NULL, NULL, '2020-05-10 09:43:42', '2020-05-10 09:43:42'),
(2, 'Weidmanngasse 19', 1, NULL, NULL, '2020-05-10 10:11:40', '2020-05-10 10:11:40'),
(3, 'Project 1', 1, NULL, NULL, '2020-05-10 10:12:12', '2020-05-10 10:12:12'),
(4, 'Project 2', 1, NULL, NULL, '2020-05-11 00:00:00', '2020-05-11 00:00:00'),
(5, 'Project 3', 1, NULL, NULL, '2020-05-11 00:00:00', '2020-05-11 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `type` enum('string','integer','decimal') NOT NULL DEFAULT 'string',
  `active` tinyint(1) DEFAULT '1',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `type`, `active`, `createdAt`, `updatedAt`) VALUES
(1, 'City', 'City', 'string', 1, '2020-05-10 09:35:51', '2020-05-10 09:35:51'),
(2, 'State', 'State', 'string', 1, '2020-05-10 09:36:04', '2020-05-10 09:36:04'),
(3, 'Country', 'Country', 'string', 1, '2020-05-10 09:36:11', '2020-05-10 09:36:11'),
(4, 'Min. Investment', 'Min. Investment', 'decimal', 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00'),
(5, 'Estimated Hold', 'Estimated Hold', 'integer', 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00'),
(6, 'Availability Status', 'Availability Status', 'string', 1, '2020-05-10 00:00:00', '2020-05-10 00:00:00'),
(7, 'Target IRR', 'Target IRR (%)', 'decimal', 1, '2020-05-11 00:00:00', '2020-05-11 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `propertydecimalvalues`
--

CREATE TABLE `propertydecimalvalues` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `value` decimal(10,0) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `propertyId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `propertydecimalvalues`
--

INSERT INTO `propertydecimalvalues` (`id`, `label`, `value`, `createdAt`, `updatedAt`, `propertyId`, `projectId`) VALUES
(1, '$200k', '200000', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 4, 1),
(2, '$300k', '300000', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 4, 2),
(3, '$600k', '600000', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 4, 3),
(4, '$1M', '1000000', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 4, 4),
(5, '$50k', '50000', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 4, 5),
(6, '3.5%', '4', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 7, 1),
(7, '60%', '60', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 7, 2),
(8, '7%', '7', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 7, 3),
(9, '45%', '45', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 7, 4),
(10, '99.8%', '100', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 7, 5);

-- --------------------------------------------------------

--
-- Table structure for table `propertyintegervalues`
--

CREATE TABLE `propertyintegervalues` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `value` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `propertyId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `propertyintegervalues`
--

INSERT INTO `propertyintegervalues` (`id`, `label`, `value`, `createdAt`, `updatedAt`, `propertyId`, `projectId`) VALUES
(1, '1 Year', 1, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5, 1),
(2, '3 Years', 3, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5, 2),
(3, '6 Years', 6, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5, 3),
(4, '9 Years', 9, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5, 4),
(5, '15 Years', 15, '2020-05-11 00:00:00', '2020-05-11 00:00:00', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `propertystringvalues`
--

CREATE TABLE `propertystringvalues` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `propertyId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `propertystringvalues`
--

INSERT INTO `propertystringvalues` (`id`, `label`, `value`, `createdAt`, `updatedAt`, `propertyId`, `projectId`) VALUES
(2, 'Eisenstadt', 'Eisenstadt', '2020-05-10 10:02:44', '2020-05-10 10:02:44', 1, 1),
(3, 'Austria', 'Austria', '2020-05-10 10:03:26', '2020-05-10 10:03:26', 3, 1),
(4, 'Austria', 'Austria', '2020-05-10 10:12:32', '2020-05-10 10:12:32', 3, 2),
(5, 'Vienna', 'Vienna', '2020-05-10 10:12:49', '2020-05-10 10:12:49', 1, 2),
(6, 'Berlin', 'Berlin', '2020-05-10 00:00:00', '2020-05-10 00:00:00', 1, 3),
(7, 'Germany', 'Germany', '2020-05-10 00:00:00', '2020-05-10 00:00:00', 3, 3),
(8, 'Open', 'open', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 6, 1),
(9, 'Closed', 'closed', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 6, 2),
(10, 'Closed', 'closed', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 6, 3),
(11, 'Closed', 'closed', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 6, 4),
(12, 'Open', 'open', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 6, 5),
(14, 'Manila', 'Manila', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 1, 4),
(15, 'Sydney', 'Sydney', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 1, 5),
(16, 'Philippines', 'Philippines', '2020-05-11 00:00:00', '2020-05-18 00:00:00', 3, 4),
(17, 'Australia', 'Australia', '2020-05-11 00:00:00', '2020-05-11 00:00:00', 3, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `filteroptions`
--
ALTER TABLE `filteroptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `label` (`label`),
  ADD KEY `filterId` (`filterId`);

--
-- Indexes for table `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `label` (`label`),
  ADD KEY `propertyId` (`propertyId`);

--
-- Indexes for table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `filename` (`filename`),
  ADD KEY `projectId` (`projectId`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `propertydecimalvalues`
--
ALTER TABLE `propertydecimalvalues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `propertyId` (`propertyId`),
  ADD KEY `projectId` (`projectId`);

--
-- Indexes for table `propertyintegervalues`
--
ALTER TABLE `propertyintegervalues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `propertyId` (`propertyId`),
  ADD KEY `projectId` (`projectId`);

--
-- Indexes for table `propertystringvalues`
--
ALTER TABLE `propertystringvalues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `propertyId` (`propertyId`),
  ADD KEY `projectId` (`projectId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `filteroptions`
--
ALTER TABLE `filteroptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `filters`
--
ALTER TABLE `filters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `propertydecimalvalues`
--
ALTER TABLE `propertydecimalvalues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `propertyintegervalues`
--
ALTER TABLE `propertyintegervalues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `propertystringvalues`
--
ALTER TABLE `propertystringvalues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `filteroptions`
--
ALTER TABLE `filteroptions`
  ADD CONSTRAINT `filteroptions_ibfk_1` FOREIGN KEY (`filterId`) REFERENCES `filters` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `filters`
--
ALTER TABLE `filters`
  ADD CONSTRAINT `filters_ibfk_1` FOREIGN KEY (`propertyId`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `pictures_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `propertydecimalvalues`
--
ALTER TABLE `propertydecimalvalues`
  ADD CONSTRAINT `propertydecimalvalues_ibfk_1` FOREIGN KEY (`propertyId`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `propertydecimalvalues_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `propertyintegervalues`
--
ALTER TABLE `propertyintegervalues`
  ADD CONSTRAINT `propertyintegervalues_ibfk_1` FOREIGN KEY (`propertyId`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `propertyintegervalues_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `propertystringvalues`
--
ALTER TABLE `propertystringvalues`
  ADD CONSTRAINT `propertystringvalues_ibfk_1` FOREIGN KEY (`propertyId`) REFERENCES `properties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `propertystringvalues_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
