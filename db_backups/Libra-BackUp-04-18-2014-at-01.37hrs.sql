DROP TABLE IF EXISTS admin_pages;

CREATE TABLE `admin_pages` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_or_last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `page_type` varchar(50) NOT NULL,
  `file_description` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

INSERT INTO admin_pages VALUES("9","2013-04-20 22:56:07","adminusers","Administrators","1");
INSERT INTO admin_pages VALUES("10","2013-04-20 22:56:07","rolepermissions","Permissions for Roles","1");
INSERT INTO admin_pages VALUES("11","2013-04-20 22:56:07","adminpages","All pages in the Admin panel","1");
INSERT INTO admin_pages VALUES("12","2013-04-20 23:02:18","backup","Backup and download the database","1");
INSERT INTO admin_pages VALUES("16","2013-05-02 19:33:41","adminroles","Admin Roles","1");
INSERT INTO admin_pages VALUES("17","2013-05-06 17:35:34","configs","Config variables for controlling different aspects of the site","1");
INSERT INTO admin_pages VALUES("22","2014-04-12 21:34:59","categories","Categories of stuff","1");
INSERT INTO admin_pages VALUES("23","2014-04-13 00:13:49","users","Users in the site","1");
INSERT INTO admin_pages VALUES("24","2014-04-13 00:18:44","resources","Libraries, Plugins, Toolbox, Stuff and more Stuff","1");
INSERT INTO admin_pages VALUES("25","2014-04-17 18:09:44","authors","Authors of the libraries","1");



DROP TABLE IF EXISTS admin_role_permissions;

CREATE TABLE `admin_role_permissions` (
  `rp_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_id` int(11) NOT NULL,
  `permission_type` varchar(50) NOT NULL,
  `page_id` int(11) NOT NULL,
  PRIMARY KEY (`rp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

INSERT INTO admin_role_permissions VALUES("20","2014-01-02 17:52:33","1","VIEW;SEARCH;CREATE;EDIT;DELETE","11");
INSERT INTO admin_role_permissions VALUES("21","2014-01-02 17:53:07","1","VIEW;SEARCH;CREATE;EDIT;DELETE","10");
INSERT INTO admin_role_permissions VALUES("22","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","9");
INSERT INTO admin_role_permissions VALUES("23","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","12");
INSERT INTO admin_role_permissions VALUES("24","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","16");
INSERT INTO admin_role_permissions VALUES("25","2014-01-02 17:54:19","1","VIEW;SEARCH;CREATE;EDIT;DELETE","17");
INSERT INTO admin_role_permissions VALUES("29","2014-04-12 21:35:23","1","VIEW;SEARCH;CREATE;EDIT;DELETE","22");
INSERT INTO admin_role_permissions VALUES("30","2014-04-13 00:14:31","1","VIEW;SEARCH;CREATE;EDIT;DELETE","23");
INSERT INTO admin_role_permissions VALUES("31","2014-04-13 00:21:40","1","VIEW;SEARCH;CREATE;EDIT;DELETE","24");
INSERT INTO admin_role_permissions VALUES("32","2014-04-17 18:09:52","1","VIEW;SEARCH;CREATE;EDIT;DELETE","25");



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
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=latin1 COMMENT='Tracking every activity of the admin';

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
INSERT INTO admin_user_activities VALUES("152","2014-04-12 21:33:54","1","login","2014-04-12 21:33:54");
INSERT INTO admin_user_activities VALUES("153","2014-04-12 23:59:07","1","login","2014-04-12 23:59:07");
INSERT INTO admin_user_activities VALUES("154","2014-04-13 00:13:33","1","login","2014-04-13 00:13:33");
INSERT INTO admin_user_activities VALUES("155","2014-04-13 00:14:08","1","login","2014-04-13 00:14:08");
INSERT INTO admin_user_activities VALUES("156","2014-04-13 00:14:38","1","login","2014-04-13 00:14:38");
INSERT INTO admin_user_activities VALUES("157","2014-04-13 00:21:44","1","login","2014-04-13 00:21:44");
INSERT INTO admin_user_activities VALUES("158","2014-04-13 01:19:58","1","login","2014-04-13 01:19:58");
INSERT INTO admin_user_activities VALUES("159","2014-04-13 14:07:28","1","login","2014-04-13 14:07:28");
INSERT INTO admin_user_activities VALUES("160","2014-04-13 19:04:26","1","login","2014-04-13 19:04:26");
INSERT INTO admin_user_activities VALUES("161","2014-04-13 19:53:07","1","login","2014-04-13 19:53:07");
INSERT INTO admin_user_activities VALUES("162","2014-04-16 18:48:40","1","login","2014-04-16 18:48:40");
INSERT INTO admin_user_activities VALUES("163","2014-04-16 20:42:42","1","login","2014-04-16 20:42:42");
INSERT INTO admin_user_activities VALUES("164","2014-04-17 00:30:52","1","login","2014-04-17 00:30:52");
INSERT INTO admin_user_activities VALUES("165","2014-04-17 14:12:27","1","login","2014-04-17 14:12:27");
INSERT INTO admin_user_activities VALUES("166","2014-04-17 16:15:14","1","login","2014-04-17 16:15:14");
INSERT INTO admin_user_activities VALUES("167","2014-04-17 18:10:05","1","login","2014-04-17 18:10:05");
INSERT INTO admin_user_activities VALUES("168","2014-04-18 01:36:52","1","login","2014-04-18 01:36:52");



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



DROP TABLE IF EXISTS authors;

CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS categories;

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL COMMENT 'ID of the parent category (found in same table)',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

INSERT INTO categories VALUES("2","2014-04-13 15:23:18","1","UI","0");
INSERT INTO categories VALUES("3","2014-04-13 15:25:52","1","Networking","0");
INSERT INTO categories VALUES("4","2014-04-13 20:51:11","1","Database","0");
INSERT INTO categories VALUES("5","2014-04-13 15:42:05","1","Development","0");
INSERT INTO categories VALUES("6","2014-04-13 15:51:04","1","HTTP Client","3");
INSERT INTO categories VALUES("7","2014-04-13 15:51:23","1","Toasts","2");
INSERT INTO categories VALUES("8","2014-04-13 15:52:38","1","Image Loading","3");
INSERT INTO categories VALUES("9","2014-04-13 15:52:33","1","ImageView","2");
INSERT INTO categories VALUES("10","2014-04-13 15:52:18","1","Camera","2");
INSERT INTO categories VALUES("11","2014-04-13 20:51:14","1","ListView","2");
INSERT INTO categories VALUES("12","2014-04-13 20:51:06","1","Dependency Injection","2");
INSERT INTO categories VALUES("13","2014-04-13 15:53:14","1","JSON","3");
INSERT INTO categories VALUES("14","2014-04-13 15:53:22","1","Pull to Refresh","2");
INSERT INTO categories VALUES("15","2014-04-13 15:53:29","1","Sidebar","2");
INSERT INTO categories VALUES("16","2014-04-13 15:53:42","1","Progress Bar","2");
INSERT INTO categories VALUES("17","2014-04-13 15:53:50","1","Dialog","2");
INSERT INTO categories VALUES("18","2014-04-13 15:53:57","1","Wheel Menu","2");
INSERT INTO categories VALUES("19","2014-04-13 15:54:04","1","TextView","2");
INSERT INTO categories VALUES("20","2014-04-13 15:54:11","1","Fonts","2");
INSERT INTO categories VALUES("21","2014-04-13 15:54:20","1","ActionBar","2");
INSERT INTO categories VALUES("22","2014-04-13 15:54:28","1","ViewPager","2");
INSERT INTO categories VALUES("23","2014-04-13 15:54:46","1","Debugging","5");
INSERT INTO categories VALUES("24","2014-04-13 15:54:52","1","Tools","5");
INSERT INTO categories VALUES("25","2014-04-13 15:55:11","1","Bug Tracking","5");
INSERT INTO categories VALUES("26","2014-04-13 15:55:20","1","Icons","2");
INSERT INTO categories VALUES("27","2014-04-13 15:55:35","1","Feedback","5");
INSERT INTO categories VALUES("28","2014-04-13 15:55:46","1","Other","2");
INSERT INTO categories VALUES("29","2014-04-13 15:56:09","1","Event Bus","5");
INSERT INTO categories VALUES("30","2014-04-13 15:56:43","1","CalenderView","2");



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



DROP TABLE IF EXISTS res_cat;

CREATE TABLE `res_cat` (
  `res_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

INSERT INTO res_cat VALUES("25","4","10","2014-04-17 17:04:13");
INSERT INTO res_cat VALUES("26","4","4","2014-04-17 17:04:13");
INSERT INTO res_cat VALUES("27","4","3","2014-04-17 17:04:13");
INSERT INTO res_cat VALUES("28","3","8","2014-04-17 17:04:51");
INSERT INTO res_cat VALUES("29","3","4","2014-04-17 17:04:51");
INSERT INTO res_cat VALUES("35","1","8","2014-04-17 18:16:52");
INSERT INTO res_cat VALUES("36","1","9","2014-04-17 18:16:52");
INSERT INTO res_cat VALUES("37","1","17","2014-04-17 18:16:52");
INSERT INTO res_cat VALUES("38","1","10","2014-04-17 18:16:52");
INSERT INTO res_cat VALUES("39","1","6","2014-04-17 18:16:52");



DROP TABLE IF EXISTS resources;

CREATE TABLE `resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(200) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `author` int(11) NOT NULL,
  `submitter` int(11) NOT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO resources VALUES("1","2014-04-17 18:16:52","1","Geny motion","Geny motionGeny motionGeny motionGeny motion\n!@#$%^&*()_+|}{P:L<>?][;l,./","http://google.com/geny","0","0","0","0","1");
INSERT INTO resources VALUES("2","2014-04-17 18:25:43","1","Intellij","jfdsa;lfkjas;lfkj;al","","0","0","0","0","1");
INSERT INTO resources VALUES("3","2014-04-16 23:24:55","1","Intellij idea","jfdsa;lfkjas;lfkj;al","","0","0","0","0","1");
INSERT INTO resources VALUES("4","2014-04-17 18:25:52","1","Intellij idea hh","jfdsa;lfkjas;lfkj;al","","0","0","0","0","0");



DROP TABLE IF EXISTS users;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime NOT NULL,
  `active` tinyint(1) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




