-- phpMyAdmin SQL Dump
-- version 3.5.8.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 17, 2014 at 01:03 PM
-- Server version: 5.5.34-0ubuntu0.13.04.1
-- PHP Version: 5.4.9-4ubuntu2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `libra`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_pages`
--

CREATE TABLE IF NOT EXISTS `admin_pages` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_or_last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `page_type` varchar(50) NOT NULL,
  `file_description` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `admin_pages`
--

INSERT INTO `admin_pages` (`page_id`, `created_or_last_updated`, `page_type`, `file_description`, `active`) VALUES
(9, '2013-04-20 18:56:07', 'adminusers', 'Administrators', 1),
(10, '2013-04-20 18:56:07', 'rolepermissions', 'Permissions for Roles', 1),
(11, '2013-04-20 18:56:07', 'adminpages', 'All pages in the Admin panel', 1),
(12, '2013-04-20 19:02:18', 'backup', 'Backup and download the database', 1),
(16, '2013-05-02 15:33:41', 'adminroles', 'Admin Roles', 1),
(17, '2013-05-06 13:35:34', 'configs', 'Config variables for controlling different aspects of the site', 1),
(22, '2014-04-12 17:34:59', 'categories', 'Categories of stuff', 1),
(23, '2014-04-12 20:13:49', 'users', 'Users in the site', 1),
(24, '2014-04-12 20:18:44', 'resources', 'Libraries, Plugins, Toolbox, Stuff and more Stuff', 1),
(25, '2014-04-17 14:09:44', 'authors', 'Authors of the libraries', 1);

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE IF NOT EXISTS `admin_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`role_id`, `role_name`, `created`, `last_updated`, `active`) VALUES
(1, 'Super Admin', '2013-04-20 15:50:07', '2013-05-02 15:14:19', 1),
(2, 'Role2', '0000-00-00 00:00:00', '2013-05-02 15:53:33', 0),
(3, 'Role1', '0000-00-00 00:00:00', '2013-05-02 15:53:19', 1);

-- --------------------------------------------------------

--
-- Table structure for table `admin_role_permissions`
--

CREATE TABLE IF NOT EXISTS `admin_role_permissions` (
  `rp_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_id` int(11) NOT NULL,
  `permission_type` varchar(50) NOT NULL,
  `page_id` int(11) NOT NULL,
  PRIMARY KEY (`rp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `admin_role_permissions`
--

INSERT INTO `admin_role_permissions` (`rp_id`, `updated`, `role_id`, `permission_type`, `page_id`) VALUES
(20, '2014-01-02 13:52:33', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 11),
(21, '2014-01-02 13:53:07', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 10),
(22, '2014-01-02 13:54:19', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 9),
(23, '2014-01-02 13:54:19', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 12),
(24, '2014-01-02 13:54:19', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 16),
(25, '2014-01-02 13:54:19', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 17),
(29, '2014-04-12 17:35:23', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 22),
(30, '2014-04-12 20:14:31', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 23),
(31, '2014-04-12 20:21:40', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 24),
(32, '2014-04-17 14:09:52', 1, 'VIEW;SEARCH;CREATE;EDIT;DELETE', 25);

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE IF NOT EXISTS `admin_users` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of admin',
  `created` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 if active or 0 if disabled or older admin.',
  `last_login` datetime NOT NULL,
  `admin_role_id` int(11) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`admin_id`, `created`, `last_updated`, `name`, `email`, `username`, `password`, `active`, `last_login`, `admin_role_id`) VALUES
(1, '0000-00-00 00:00:00', '2013-04-20 12:51:29', 'Admin1', 'admin@gmail.com', 'a', '$2a$10$6ff521fecd74d4ca2c735e3sCC0sdRQqiO89jMUOqvfxm9B/rreRu', 1, '2013-02-20 18:57:15', 1),
(2, '2013-06-13 18:35:56', '2013-06-13 14:36:00', 'kalsdfj', 'lkjdflkj', 'lkjsd', '$2a$10$d5b0ff9fdb265fd05f935uNvtYqgP8ZKxafUBi.eHNpShAMY/uPZK', 0, '0000-00-00 00:00:00', 0),
(3, '2014-01-03 15:56:46', '2014-01-03 11:56:46', 'Thomas', 'th', 'thomas', '$2a$10$18dc99bed564aff9e04d1uzb820Nf81CFIILNd860P06PEAoQwgX6', 1, '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `admin_user_activities`
--

CREATE TABLE IF NOT EXISTS `admin_user_activities` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_user_id` int(11) NOT NULL,
  `activity` varchar(200) NOT NULL COMMENT 'updated info, anything that is relevant and needs to be tracked',
  `additional_remark` text NOT NULL COMMENT 'any sql command he/she might have executed',
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tracking every activity of the admin' AUTO_INCREMENT=197 ;

--
-- Dumping data for table `admin_user_activities`
--

INSERT INTO `admin_user_activities` (`activity_id`, `created`, `admin_user_id`, `activity`, `additional_remark`) VALUES
(135, '2014-01-02 13:57:01', 1, 'login', '2014-01-02 17:57:01'),
(136, '2014-01-02 13:59:58', 1, 'login', '2014-01-02 17:59:58'),
(137, '2014-01-02 18:48:33', 1, 'login', '2014-01-02 22:48:33'),
(138, '2014-01-03 11:56:27', 1, 'login', '2014-01-03 15:56:27'),
(139, '2014-01-03 11:56:53', 3, 'login', '2014-01-03 15:56:53'),
(140, '2014-01-03 11:56:57', 1, 'login', '2014-01-03 15:56:57'),
(141, '2014-01-03 07:37:12', 1, 'login', '2014-01-03 11:37:12'),
(142, '2014-01-03 07:38:31', 3, 'login', '2014-01-03 11:38:31'),
(143, '2014-01-03 07:49:39', 1, 'login', '2014-01-03 11:49:39'),
(144, '2014-01-04 04:24:26', 3, 'login', '2014-01-04 08:24:26'),
(145, '2014-01-04 04:25:02', 1, 'login', '2014-01-04 08:25:02'),
(146, '2014-01-11 02:50:39', 1, 'login', '2014-01-11 06:50:39'),
(147, '2014-01-11 03:51:40', 1, 'login', '2014-01-11 07:51:40'),
(148, '2014-01-11 14:08:09', 1, 'login', '2014-01-11 18:08:09'),
(149, '2014-04-06 02:36:55', 1, 'login', '2014-04-06 06:36:55'),
(150, '2014-04-12 17:05:49', 1, 'login', '2014-04-12 21:05:49'),
(151, '2014-04-12 17:09:06', 1, 'login', '2014-04-12 21:09:06'),
(152, '2014-04-12 17:33:54', 1, 'login', '2014-04-12 21:33:54'),
(153, '2014-04-12 19:59:07', 1, 'login', '2014-04-12 23:59:07'),
(154, '2014-04-12 20:13:33', 1, 'login', '2014-04-13 00:13:33'),
(155, '2014-04-12 20:14:08', 1, 'login', '2014-04-13 00:14:08'),
(156, '2014-04-12 20:14:38', 1, 'login', '2014-04-13 00:14:38'),
(157, '2014-04-12 20:21:44', 1, 'login', '2014-04-13 00:21:44'),
(158, '2014-04-12 21:19:58', 1, 'login', '2014-04-13 01:19:58'),
(159, '2014-04-13 10:07:28', 1, 'login', '2014-04-13 14:07:28'),
(160, '2014-04-13 15:04:26', 1, 'login', '2014-04-13 19:04:26'),
(161, '2014-04-13 15:53:07', 1, 'login', '2014-04-13 19:53:07'),
(162, '2014-04-16 14:48:40', 1, 'login', '2014-04-16 18:48:40'),
(163, '2014-04-16 16:42:42', 1, 'login', '2014-04-16 20:42:42'),
(164, '2014-04-16 20:30:52', 1, 'login', '2014-04-17 00:30:52'),
(165, '2014-04-17 10:12:27', 1, 'login', '2014-04-17 14:12:27'),
(166, '2014-04-17 12:15:14', 1, 'login', '2014-04-17 16:15:14'),
(167, '2014-04-17 14:10:05', 1, 'login', '2014-04-17 18:10:05'),
(168, '2014-04-17 21:36:52', 1, 'login', '2014-04-18 01:36:52'),
(169, '2014-04-19 19:03:57', 1, 'login', '2014-04-19 23:03:57'),
(170, '2014-04-21 16:24:18', 1, 'login', '2014-04-21 20:24:18'),
(171, '2014-04-25 13:40:58', 1, 'login', '2014-04-25 17:40:58'),
(172, '2014-04-25 15:25:29', 1, 'login', '2014-04-25 19:25:29'),
(173, '2014-04-25 16:12:02', 1, 'login', '2014-04-25 20:12:02'),
(174, '2014-04-25 16:48:26', 1, 'login', '2014-04-25 20:48:26'),
(175, '2014-04-25 20:29:17', 1, 'login', '2014-04-26 00:29:17'),
(176, '2014-05-08 12:25:33', 1, 'login', '2014-05-08 16:25:33'),
(177, '2014-05-08 12:56:02', 1, 'login', '2014-05-08 16:56:02'),
(178, '2014-05-08 16:48:39', 1, 'login', '2014-05-08 20:48:39'),
(179, '2014-05-08 21:07:17', 1, 'login', '2014-05-09 01:07:17'),
(180, '2014-05-09 10:05:10', 1, 'login', '2014-05-09 14:05:10'),
(181, '2014-05-09 13:21:10', 1, 'login', '2014-05-09 17:21:10'),
(182, '2014-05-09 13:22:59', 1, 'login', '2014-05-09 17:22:59'),
(183, '2014-05-09 13:23:20', 1, 'login', '2014-05-09 17:23:20'),
(184, '2014-05-10 18:35:41', 1, 'login', '2014-05-10 22:35:41'),
(185, '2014-05-11 20:02:29', 1, 'login', '2014-05-12 00:02:29'),
(186, '2014-05-13 12:09:05', 1, 'login', '2014-05-13 16:09:05'),
(187, '2014-05-13 17:15:45', 1, 'login', '2014-05-13 21:15:45'),
(188, '2014-05-13 17:52:14', 1, 'login', '2014-05-13 21:52:14'),
(189, '2014-05-13 20:11:07', 1, 'login', '2014-05-14 00:11:07'),
(190, '2014-05-14 11:02:19', 1, 'login', '2014-05-14 15:02:19'),
(191, '2014-05-14 13:31:58', 1, 'login', '2014-05-14 17:31:58'),
(192, '2014-05-14 15:21:27', 1, 'login', '2014-05-14 19:21:27'),
(193, '2014-05-14 16:28:08', 1, 'login', '2014-05-14 20:28:08'),
(194, '2014-05-14 17:55:50', 1, 'login', '2014-05-14 21:55:50'),
(195, '2014-05-16 11:13:23', 1, 'login', '2014-05-16 15:13:23'),
(196, '2014-05-17 09:02:01', 1, 'login', '2014-05-17 13:02:01');

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE IF NOT EXISTS `authors` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `name`, `url`) VALUES
(1, 'Google', 'http://android.googlesource.com'),
(2, 'Square Open Source', 'http://square.github.io/'),
(3, 'Emil "emilsjolander" SjÃ¶lander', 'https://github.com/emilsjolander'),
(4, 'Bump "bumptech" Technologies', 'https://github.com/bumptech'),
(5, 'Benjamin "keyboardsurfer" Weiss', 'https://github.com/keyboardsurfer'),
(6, 'James "loopj" Smith', 'https://github.com/loopj'),
(7, 'Nathan "nvanbenschoten" VanBenschoten', 'https://github.com/nvanbenschoten'),
(8, 'Lafosca', 'https://github.com/lafosca'),
(9, 'Ribot', 'https://github.com/ribot'),
(10, 'Niek "nhaarman" Haarman', 'https://github.com/nhaarman'),
(11, 'Roman "romannurik" Nurik', 'https://github.com/romannurik'),
(12, 'Jeff "jgilfelt" Gilfelt', 'https://github.com/jgilfelt'),
(13, 'Satya "satyan" Narayan', 'https://github.com/satyan'),
(14, 'Mark "commonsguy" Murphy', 'https://github.com/commonsguy'),
(15, 'Jake "JakeWharton" Wharton', 'https://github.com/JakeWharton'),
(16, 'Chris "chrisbanes" Banes', 'https://github.com/chrisbanes'),
(17, 'Simon "SimonVT" Vig Therkildsen', 'https://github.com/SimonVT'),
(18, 'John "JohnPersano" Persano', 'https://github.com/JohnPersano'),
(19, 'Antoine "castorflex Merle', 'https://github.com/castorflex'),
(20, 'Inmite s.r.o.', 'https://github.com/inmite'),
(21, 'Anup "anupcowkur" Cowkur', 'https://github.com/anupcowkur'),
(22, 'Weddingparty', 'https://github.com/weddingparty'),
(23, 'Christopher "chrisjenx" Jenkins', 'https://github.com/chrisjenx'),
(24, 'Etsy, Inc.', 'https://github.com/etsy'),
(25, 'Jeremy "jfeinstein10" Feinstein', 'https://github.com/jfeinstein10'),
(26, 'ManuelPeinado', 'https://github.com/ManuelPeinado'),
(27, 'Antony "antonyt" Tran', 'https://github.com/antonyt'),
(28, 'Mustafa "MustafaFerhan" Ferhan Akman', 'https://github.com/MustafaFerhan'),
(29, 'RobotiumTech', 'https://github.com/RobotiumTech'),
(30, 'BugSense', 'https://www.bugsense.com/'),
(31, 'Joan "JoanZapata" Zapata', 'https://github.com/JoanZapata'),
(32, 'jimu Labs Inc.', 'http://jimulabs.com/'),
(33, 'Genymotion', 'http://www.genymotion.com/'),
(34, 'Tiziano "tizionario" Basile', 'https://github.com/tizionario'),
(35, 'Nicolas "PomepuyN" POMEPUY', 'https://github.com/PomepuyN'),
(36, 'Comcast', 'https://github.com/Comcast'),
(37, 'nadavfima', 'https://github.com/nadavfima'),
(38, 'Application "ACRA" Crash Reports for Android', 'https://github.com/ACRA'),
(39, 'Koushik "koush" Dutta', 'https://github.com/koush'),
(40, 'Sergey "nostra13" Tarasevich', 'https://github.com/nostra13'),
(41, 'Joda.org', 'https://github.com/JodaOrg'),
(42, 'Roomorama', 'https://github.com/roomorama'),
(43, 'Vince "vinc3m1" Mi', 'https://github.com/vinc3m1'),
(44, 'Umano: News Read To You', 'https://github.com/umano'),
(45, 'Startappz', 'https://github.com/Startappz'),
(46, 'Le "hoang8f" Van Hoang', 'https://github.com/hoang8f'),
(47, 'greenrobot', 'https://github.com/greenrobot'),
(48, 'Pedro "pedrovgs" Vicente GÃ³mez SÃ¡nchez', 'https://github.com/pedrovgs'),
(49, 'idunnololz', 'https://github.com/idunnololz'),
(50, 'Thomas "tbouron" Bouron', 'https://github.com/tbouron'),
(51, 'Flavien "flavienlaurent" Laurent', 'https://github.com/flavienlaurent'),
(52, 'Romain "RomainPiel" Piel', 'https://github.com/RomainPiel');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL COMMENT 'ID of the parent category (found in same table)',
  PRIMARY KEY (`cat_id`),
  KEY `active` (`active`,`name`,`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `updated`, `active`, `name`, `parent_id`) VALUES
(2, '2014-04-13 11:23:18', 1, 'UI', 0),
(3, '2014-04-13 11:25:52', 1, 'Networking', 0),
(4, '2014-04-13 16:51:11', 1, 'Database', 0),
(5, '2014-04-13 11:42:05', 1, 'Development', 0),
(6, '2014-04-13 11:51:04', 1, 'HTTP Client', 3),
(7, '2014-04-13 11:51:23', 1, 'Toasts', 2),
(8, '2014-04-13 11:52:38', 1, 'Image Loading', 3),
(9, '2014-04-13 11:52:33', 1, 'ImageView', 2),
(10, '2014-04-13 11:52:18', 1, 'Camera', 2),
(11, '2014-04-13 16:51:14', 1, 'ListView', 2),
(12, '2014-04-13 16:51:06', 1, 'Dependency Injection', 2),
(13, '2014-04-13 11:53:14', 1, 'JSON', 3),
(14, '2014-04-13 11:53:22', 1, 'Pull to Refresh', 2),
(15, '2014-04-13 11:53:29', 1, 'Sidebar', 2),
(16, '2014-04-13 11:53:42', 1, 'Progress Bar', 2),
(17, '2014-04-13 11:53:50', 1, 'Dialog', 2),
(18, '2014-04-13 11:53:57', 1, 'Wheel Menu', 2),
(19, '2014-04-13 11:54:04', 1, 'TextView', 2),
(20, '2014-04-13 11:54:11', 1, 'Fonts', 2),
(21, '2014-04-13 11:54:20', 1, 'ActionBar', 2),
(22, '2014-04-13 11:54:28', 1, 'ViewPager', 2),
(23, '2014-04-13 11:54:46', 1, 'Debugging', 5),
(24, '2014-04-13 11:54:52', 1, 'Tools', 5),
(25, '2014-04-13 11:55:11', 1, 'Bug Tracking', 5),
(26, '2014-04-13 11:55:20', 1, 'Icons', 2),
(27, '2014-04-13 11:55:35', 1, 'Feedback', 5),
(28, '2014-04-13 11:55:46', 1, 'Other', 2),
(29, '2014-04-13 11:56:09', 1, 'Event Bus', 5),
(30, '2014-04-13 11:56:43', 1, 'CalenderView', 2),
(31, '2014-05-14 16:40:57', 1, 'Drawer', 2);

-- --------------------------------------------------------

--
-- Table structure for table `changes_log`
--

CREATE TABLE IF NOT EXISTS `changes_log` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `time_of_change` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `configs`
--

CREATE TABLE IF NOT EXISTS `configs` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(200) NOT NULL,
  `value` varchar(100) NOT NULL,
  `type` enum('integer','boolean','array','string','','') NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `configs`
--

INSERT INTO `configs` (`config_id`, `created`, `last_updated`, `name`, `value`, `type`, `description`) VALUES
(1, '2013-05-06 17:43:04', '2013-11-23 15:36:32', 'con1', '1', 'integer', '1');

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE IF NOT EXISTS `resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(200) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`),
  KEY `active` (`active`,`name`,`is_approved`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Dumping data for table `resources`
--

INSERT INTO `resources` (`resource_id`, `updated`, `active`, `name`, `description`, `url`, `points`, `views`, `author_id`, `user_id`, `is_approved`) VALUES
(1, '2014-05-14 11:02:31', 0, 'Geny motion a really looooong name that has no meaning and just takes up space', 'jfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjajfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkja', 'http://google.com/geny', 206, 1818, 1, 0, 1),
(2, '2014-05-14 11:02:33', 0, 'Intellij !!!!!!!!', 'jfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds s ffffffffff ggggggg', 'http://google.com/intellij', 280, 1546, 2, 0, 1),
(3, '2014-05-14 11:02:35', 0, 'Intellij idea', 'ffjkdhf kjsdhf kjdshdf kjdshd fkjsdh fksdjhf ksdjhf ksdh fkds ffjkdhf kjsdhf kjdshdf kjdshd fkjsdh fksdjhf ksdjhf ksdh fkds f zzzzzzzzz aaaaa', 'http://google.com/geny', 282, 1274, 0, 0, 1),
(4, '2014-05-13 17:47:05', 1, 'Intellij idea hh', 'jfdsa;lfkjas;lfkj;al', '', 470, 4733, 0, 0, 0),
(5, '2014-05-14 11:37:02', 1, 'Sprinkles', 'Sprinkles is a boiler-plate-reduction-library for dealing with databases in android applications. Some would call it a kind of ORM but I don''t see it that way. Sprinkles lets SQL do what it is good at, making complex queries. SQL however is a mess (in my opinion) when is comes to everything else. This is why sprinkles helps you with things such as inserting, updating, and destroying models. Sprinkles will also help you with the tedious task of unpacking a cursor into a model.', 'https://github.com/emilsjolander/sprinkles', 0, 0, 3, 0, 1),
(6, '2014-05-14 12:12:40', 1, 'Retrofit', 'Type-safe REST client for Android and Java.', 'http://square.github.io/retrofit/', 0, 0, 2, 0, 1),
(7, '2014-05-14 12:17:19', 1, 'Crouton', 'Crouton is a class that can be used by Android developers that feel the need for an alternative to the Context insensitive Toast. A Crouton will be displayed at the position the developer decides. Standard will be the top of an application window. You can line up multiple Croutons for display, that will be shown one after another.', 'https://github.com/keyboardsurfer/Crouton', 0, 0, 5, 0, 1),
(8, '2014-05-14 12:18:27', 1, 'Glide', 'Glide is fast and efficient image loading library for Android that wraps image downloading, re-sizing, memory and disk caching, and bitmap recycling into one simple and easy to use interface. By default, Glide includes an implementation for fetching images over http based on Google''s Volley project for fast, parallelized network operations on Android.', 'https://github.com/bumptech/glide', 0, 0, 4, 0, 1),
(9, '2014-05-14 12:19:41', 1, 'Android Asynchronous HTTP Client', 'An asynchronous callback-based Http client for Android built on top of Apacheâ€™s HttpClient libraries. All requests are made outside of your appâ€™s main UI thread, but any callback logic will be executed on the same thread as the callback was created using Androidâ€™s Handler message passing.', 'https://github.com/loopj/android-async-http', 0, 0, 6, 0, 1),
(10, '2014-05-14 12:57:33', 1, 'Volley', 'Volley is a library that makes networking for Android apps easier and most importantly, faster. We''ll give an overview of how it works, common patterns that work well with it, and a walkthrough of how you can easily load thumbnail images for your ListView from the network in parallel.                     \r\n\r\n<a href=''https://developers.google.com/events/io/sessions/325304728''>https://developers.google.com/events/io/sessions/325304728</a>', 'https://android.googlesource.com/platform/frameworks/volley/', 0, 0, 1, 0, 1),
(11, '2014-05-14 12:59:57', 1, 'Motion', 'An Android library allowing images to exhibit a parallax effect. By replacing static pictures and backgrounds with a fluid images that reacts to screen tilt and orientation, Android applications can add a perceived depth and layering to their content. Motion works great for both full screen background images and smaller sized pictures to give users a whole new perspective on how they interact with their phone. This project was inspired in part by iOS 7''s new parallax effect.', 'https://github.com/nvanbenschoten/motion', 0, 0, 7, 0, 1),
(12, '2014-05-14 13:39:02', 1, 'AndroidFaceCropper', 'A library for cropping faces out of a bitmap and ImageViews.', 'https://github.com/lafosca/AndroidFaceCropper', 0, 0, 8, 0, 1),
(13, '2014-05-14 13:40:23', 1, 'EasyAdapter', 'Using AdapterViews has never been so easy. Inspired by the view holder design pattern, this library provides an easier way of linking AdapterViews and the underlying data for that view without having to implement your own Adapter. The EasyAdapter will do the tedious work for you.', 'https://github.com/ribot/easy-adapter', 0, 0, 9, 0, 1),
(14, '2014-05-14 16:30:17', 1, 'ListViewAnimations', 'ListViewAnimations provides the following features:\r\n<ul>\r\n<li>Appearance animations for items in ListViews, GridViews, and other AbsListViews;</li>\r\n<li>Built in animations include Alpha, SwingRightIn, SwingLeftIn, SwingBottomIn, SwingRightIn and ScaleIn.</li>\r\n<li>Other animations can easily be added</li>\r\n<li>Swipe-to-Dismiss, Swipe-To-Dismiss with contextual undo (and optionally count down);</li>\r\n<li>Drag-and-Drop reordering;</li>\r\n<li>Animate dismissal of items;</li>\r\n<li>Animate addition of items;</li>\r\n<li>Smoothly expand your items to reveal more content;</li>\r\n</ul>', 'https://github.com/nhaarman/ListViewAnimations', 0, 0, 10, 0, 1),
(15, '2014-05-14 16:30:58', 1, 'StickyListHeaders', 'StickyListHeaders is an Android library that makes it easy to integrate section headers in your ListView.', 'https://github.com/emilsjolander/StickyListHeaders', 0, 0, 3, 0, 1),
(16, '2014-05-14 16:31:48', 1, 'Swipe To Dismiss', 'Sample code that shows how to make ListView or other views support the swipe-to-dismiss Android UI pattern.', 'https://github.com/romannurik/Android-SwipeToDismiss', 0, 0, 11, 0, 1),
(17, '2014-05-14 16:32:56', 1, 'SQLlite Asset Helper', 'An Android helper class to manage database creation and version management using an application''s raw asset files.<br /><br />This class provides developers with a simple way to ship their Android app with an existing SQLite database (which may be pre-populated with data) and to manage its initial creation and any upgrades required with subsequent version releases.', 'https://github.com/jgilfelt/android-sqlite-asset-helper', 0, 0, 12, 0, 1),
(18, '2014-05-14 16:33:40', 1, 'Sugar', '<ul>\r\n<li>It is intended to simplify the interaction with SQLite database in Android.</li>\r\n<li>It eliminates writing SQL queries to interact with SQLite db.</li>\r\n<li>It takes care of creating your database.</li>\r\n<li>It manages object relationships too.</li>\r\n<li>It provides you with clear and simple APIs for db operations</li>\r\n</ul>', 'https://github.com/satyan/sugar', 0, 0, 13, 0, 1),
(19, '2014-05-14 16:34:39', 1, 'CWAC EndlessAdapter', 'AJAX Web sites have sometimes taken up the "endless page" model, where scrolling automatically loads in new content, so you never have to click a "Next" link or anything like that.<br /><br />EndlessAdapter is one approach to solving this problem.<br /><br />It is designed to wrap around another adapter, where you have your "real" data. Hence, it follows the Decorator pattern, augmenting your current adapter with new Endless Technology(TM).', 'https://github.com/commonsguy/cwac-endless', 0, 0, 14, 0, 1),
(20, '2014-05-14 16:35:59', 1, 'Butter Knife', 'View "injection" library for Android.', 'https://github.com/JakeWharton/butterknife', 0, 0, 15, 0, 1),
(21, '2014-05-14 16:37:13', 1, 'Dagger', 'A fast dependency injector for Android and Java.', 'https://github.com/square/dagger', 0, 0, 2, 0, 1),
(22, '2014-05-14 16:38:32', 1, 'Gson', 'Gson is a Java library that can be used to convert Java Objects into their JSON representation. It can also be used to convert a JSON string to an equivalent Java object. Gson can work with arbitrary Java objects including pre-existing objects that you do not have source-code of.', 'https://code.google.com/p/google-gson/', 0, 0, 1, 0, 1),
(23, '2014-05-14 16:39:42', 1, 'ActionBar-PullToRefresh', 'ActionBar-PullToRefresh provides an easy way to add a modern version of the pull-to-refresh interaction to your application.', 'https://github.com/chrisbanes/ActionBar-PullToRefresh', 0, 0, 16, 0, 1),
(24, '2014-05-14 16:42:13', 1, 'MenuDrawer', 'A slide-out menu implementation, which allows users to navigate between views in your app. Most commonly the menu is revealed by either dragging the edge of the screen, or clicking the ''up'' button in the action bar.', 'https://github.com/SimonVT/android-menudrawer', 0, 0, 17, 0, 1),
(25, '2014-05-14 16:42:43', 1, 'SuperToasts', 'The SuperToasts library enhances and builds upon the Android Toast class. Some of the features of this library include context sensitive toasts (SuperActivityToasts), toasts with buttons and icons, non context sensitive toasts (SuperToasts), and a new style of toasts (SuperCardToasts) with many customization options for each.', 'https://github.com/JohnPersano/SuperToasts', 0, 0, 18, 0, 1),
(26, '2014-05-14 16:43:18', 1, 'SmoothProgressBar', 'Small library allowing you to make a smooth indeterminate progress bar.', 'https://github.com/castorflex/SmoothProgressBar', 0, 0, 19, 0, 1),
(27, '2014-05-14 16:43:59', 1, 'StyledDialogs', 'This library makes styling and using dialogs a piece of cake.', 'https://github.com/inmite/android-styled-dialogs', 0, 0, 20, 0, 1),
(28, '2014-05-14 16:44:46', 1, 'Wheel Menu', 'A wheel menu for android', 'https://github.com/anupcowkur/Android-Wheel-Menu', 0, 0, 21, 0, 1),
(29, '2014-05-14 16:45:22', 1, 'Floating Label Edit Text', 'Textview that implements the floating label pattern.', 'https://github.com/weddingparty/AndroidFloatLabel', 0, 0, 22, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `res_cat`
--

CREATE TABLE IF NOT EXISTS `res_cat` (
  `res_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_cat_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=113 ;

--
-- Dumping data for table `res_cat`
--

INSERT INTO `res_cat` (`res_cat_id`, `res_id`, `cat_id`, `updated`) VALUES
(25, 4, 10, '2014-04-17 13:04:13'),
(26, 4, 4, '2014-04-17 13:04:13'),
(27, 4, 3, '2014-04-17 13:04:13'),
(62, 2, 5, '2014-05-13 18:11:25'),
(63, 2, 12, '2014-05-13 18:11:25'),
(64, 2, 10, '2014-05-13 18:11:25'),
(75, 3, 8, '2014-05-13 18:46:39'),
(76, 3, 4, '2014-05-13 18:46:39'),
(77, 3, 10, '2014-05-13 18:46:39'),
(83, 1, 13, '2014-05-13 18:58:36'),
(84, 5, 4, '2014-05-14 12:11:47'),
(85, 6, 6, '2014-05-14 12:12:34'),
(86, 7, 7, '2014-05-14 12:17:19'),
(87, 8, 8, '2014-05-14 12:18:27'),
(88, 9, 6, '2014-05-14 12:19:41'),
(90, 10, 6, '2014-05-14 12:57:33'),
(91, 11, 9, '2014-05-14 12:59:57'),
(92, 12, 9, '2014-05-14 13:39:02'),
(93, 12, 10, '2014-05-14 13:39:02'),
(94, 13, 11, '2014-05-14 13:40:23'),
(96, 14, 11, '2014-05-14 16:30:17'),
(97, 15, 11, '2014-05-14 16:30:58'),
(98, 16, 11, '2014-05-14 16:31:48'),
(99, 17, 4, '2014-05-14 16:32:56'),
(100, 18, 4, '2014-05-14 16:33:40'),
(101, 19, 11, '2014-05-14 16:34:39'),
(102, 20, 12, '2014-05-14 16:35:59'),
(103, 21, 12, '2014-05-14 16:37:13'),
(104, 22, 13, '2014-05-14 16:38:32'),
(105, 23, 14, '2014-05-14 16:39:42'),
(106, 23, 11, '2014-05-14 16:39:42'),
(107, 24, 31, '2014-05-14 16:42:13'),
(108, 25, 7, '2014-05-14 16:42:43'),
(109, 26, 16, '2014-05-14 16:43:18'),
(110, 27, 17, '2014-05-14 16:44:00'),
(111, 28, 18, '2014-05-14 16:44:47'),
(112, 29, 19, '2014-05-14 16:45:22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime NOT NULL,
  `active` tinyint(1) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
