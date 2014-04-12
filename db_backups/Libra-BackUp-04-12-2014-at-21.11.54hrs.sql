DROP TABLE IF EXISTS admin_pages;

CREATE TABLE `admin_pages` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_or_last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `page_type` varchar(50) NOT NULL,
  `file_description` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

INSERT INTO admin_pages VALUES("9","2013-04-20 22:56:07","adminusers","Administrators","1");
INSERT INTO admin_pages VALUES("10","2013-04-20 22:56:07","rolepermissions","Permissions for Roles","1");
INSERT INTO admin_pages VALUES("11","2013-04-20 22:56:07","adminpages","All pages in the Admin panel","1");
INSERT INTO admin_pages VALUES("12","2013-04-20 23:02:18","backup","Backup and download the database","1");
INSERT INTO admin_pages VALUES("16","2013-05-02 19:33:41","adminroles","Admin Roles","1");
INSERT INTO admin_pages VALUES("17","2013-05-06 17:35:34","configs","Config variables for controlling different aspects of the site","1");



DROP TABLE IF EXISTS admin_role_permissions;

CREATE TABLE `admin_role_permissions` (
  `rp_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_id` int(11) NOT NULL,
  `permission_type` varchar(50) NOT NULL,
  `page_id` int(11) NOT NULL,
  PRIMARY KEY (`rp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

INSERT INTO admin_role_permissions VALUES("20","2014-01-02 17:52:33","1","VIEW;SEARCH;CREATE;EDIT;DELETE","11");
INSERT INTO admin_role_permissions VALUES("21","2014-01-02 17:53:07","1","VIEW;SEARCH;CREATE;EDIT;DELETE","10");
INSERT INTO admin_role_permissions VALUES("22","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","9");
INSERT INTO admin_role_permissions VALUES("23","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","12");
INSERT INTO admin_role_permissions VALUES("24","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","16");
INSERT INTO admin_role_permissions VALUES("25","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","17");



DROP TABLE IF EXISTS admin_roles;

CREATE TABLE `admin_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO admin_roles VALUES("1","Super Admin","2013-04-20 15:50:07","2013-05-02 19:14:19","1");
INSERT INTO admin_roles VALUES("2","Role2","0000-00-00 00:00:00","2013-05-02 19:53:33","0");
INSERT INTO admin_roles VALUES("3","Role1","0000-00-00 00:00:00","2013-05-02 19:53:19","1");



DROP TABLE IF EXISTS admin_user_activities;

CREATE TABLE `admin_user_activities` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_user_id` int(11) NOT NULL,
  `activity` varchar(200) NOT NULL COMMENT 'updated info, anything that is relevant and needs to be tracked',
  `additional_remark` text NOT NULL COMMENT 'any sql command he/she might have executed',
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1 COMMENT='Tracking every activity of the admin';

INSERT INTO admin_user_activities VALUES("135","2014-01-02 17:57:01","1","login","2014-01-02 17:57:01");
INSERT INTO admin_user_activities VALUES("136","2014-01-02 17:59:58","1","login","2014-01-02 17:59:58");
INSERT INTO admin_user_activities VALUES("137","2014-01-02 22:48:33","1","login","2014-01-02 22:48:33");
INSERT INTO admin_user_activities VALUES("138","2014-01-03 15:56:27","1","login","2014-01-03 15:56:27");
INSERT INTO admin_user_activities VALUES("139","2014-01-03 15:56:53","3","login","2014-01-03 15:56:53");
INSERT INTO admin_user_activities VALUES("140","2014-01-03 15:56:57","1","login","2014-01-03 15:56:57");
INSERT INTO admin_user_activities VALUES("141","2014-01-03 11:37:12","1","login","2014-01-03 11:37:12");
INSERT INTO admin_user_activities VALUES("142","2014-01-03 11:38:31","3","login","2014-01-03 11:38:31");
INSERT INTO admin_user_activities VALUES("143","2014-01-03 11:49:39","1","login","2014-01-03 11:49:39");
INSERT INTO admin_user_activities VALUES("144","2014-01-04 08:24:26","3","login","2014-01-04 08:24:26");
INSERT INTO admin_user_activities VALUES("145","2014-01-04 08:25:02","1","login","2014-01-04 08:25:02");
INSERT INTO admin_user_activities VALUES("146","2014-01-11 06:50:39","1","login","2014-01-11 06:50:39");
INSERT INTO admin_user_activities VALUES("147","2014-01-11 07:51:40","1","login","2014-01-11 07:51:40");
INSERT INTO admin_user_activities VALUES("148","2014-01-11 18:08:09","1","login","2014-01-11 18:08:09");
INSERT INTO admin_user_activities VALUES("149","2014-04-06 06:36:55","1","login","2014-04-06 06:36:55");
INSERT INTO admin_user_activities VALUES("150","2014-04-12 21:05:49","1","login","2014-04-12 21:05:49");
INSERT INTO admin_user_activities VALUES("151","2014-04-12 21:09:06","1","login","2014-04-12 21:09:06");



DROP TABLE IF EXISTS admin_users;

CREATE TABLE `admin_users` (
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO admin_users VALUES("1","0000-00-00 00:00:00","2013-04-20 16:51:29","Admin1","admin@gmail.com","a","$2a$10$6ff521fecd74d4ca2c735e3sCC0sdRQqiO89jMUOqvfxm9B/rreRu","1","2013-02-20 18:57:15","1");
INSERT INTO admin_users VALUES("2","2013-06-13 18:35:56","2013-06-13 18:36:00","kalsdfj","lkjdflkj","lkjsd","$2a$10$d5b0ff9fdb265fd05f935uNvtYqgP8ZKxafUBi.eHNpShAMY/uPZK","0","0000-00-00 00:00:00","0");
INSERT INTO admin_users VALUES("3","2014-01-03 15:56:46","2014-01-03 15:56:46","Thomas","th","thomas","$2a$10$18dc99bed564aff9e04d1uzb820Nf81CFIILNd860P06PEAoQwgX6","1","0000-00-00 00:00:00","1");



DROP TABLE IF EXISTS changes_log;

CREATE TABLE `changes_log` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `time_of_change` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS configs;

CREATE TABLE `configs` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(200) NOT NULL,
  `value` varchar(100) NOT NULL,
  `type` enum('integer','boolean','array','string','','') NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO configs VALUES("1","2013-05-06 17:43:04","2013-11-23 19:36:32","con1","1","integer","1");



