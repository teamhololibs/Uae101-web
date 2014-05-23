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
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1 COMMENT='Tracking every activity of the admin';

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
INSERT INTO admin_user_activities VALUES("169","2014-04-19 23:03:57","1","login","2014-04-19 23:03:57");
INSERT INTO admin_user_activities VALUES("170","2014-04-21 20:24:18","1","login","2014-04-21 20:24:18");
INSERT INTO admin_user_activities VALUES("171","2014-04-25 17:40:58","1","login","2014-04-25 17:40:58");
INSERT INTO admin_user_activities VALUES("172","2014-04-25 19:25:29","1","login","2014-04-25 19:25:29");
INSERT INTO admin_user_activities VALUES("173","2014-04-25 20:12:02","1","login","2014-04-25 20:12:02");
INSERT INTO admin_user_activities VALUES("174","2014-04-25 20:48:26","1","login","2014-04-25 20:48:26");
INSERT INTO admin_user_activities VALUES("175","2014-04-26 00:29:17","1","login","2014-04-26 00:29:17");
INSERT INTO admin_user_activities VALUES("176","2014-05-08 16:25:33","1","login","2014-05-08 16:25:33");
INSERT INTO admin_user_activities VALUES("177","2014-05-08 16:56:02","1","login","2014-05-08 16:56:02");
INSERT INTO admin_user_activities VALUES("178","2014-05-08 20:48:39","1","login","2014-05-08 20:48:39");
INSERT INTO admin_user_activities VALUES("179","2014-05-09 01:07:17","1","login","2014-05-09 01:07:17");
INSERT INTO admin_user_activities VALUES("180","2014-05-09 14:05:10","1","login","2014-05-09 14:05:10");
INSERT INTO admin_user_activities VALUES("181","2014-05-09 17:21:10","1","login","2014-05-09 17:21:10");
INSERT INTO admin_user_activities VALUES("182","2014-05-09 17:22:59","1","login","2014-05-09 17:22:59");
INSERT INTO admin_user_activities VALUES("183","2014-05-09 17:23:20","1","login","2014-05-09 17:23:20");
INSERT INTO admin_user_activities VALUES("184","2014-05-10 22:35:41","1","login","2014-05-10 22:35:41");
INSERT INTO admin_user_activities VALUES("185","2014-05-12 00:02:29","1","login","2014-05-12 00:02:29");
INSERT INTO admin_user_activities VALUES("186","2014-05-13 16:09:05","1","login","2014-05-13 16:09:05");
INSERT INTO admin_user_activities VALUES("187","2014-05-13 21:15:45","1","login","2014-05-13 21:15:45");
INSERT INTO admin_user_activities VALUES("188","2014-05-13 21:52:14","1","login","2014-05-13 21:52:14");
INSERT INTO admin_user_activities VALUES("189","2014-05-14 00:11:07","1","login","2014-05-14 00:11:07");
INSERT INTO admin_user_activities VALUES("190","2014-05-14 15:02:19","1","login","2014-05-14 15:02:19");
INSERT INTO admin_user_activities VALUES("191","2014-05-14 17:31:58","1","login","2014-05-14 17:31:58");
INSERT INTO admin_user_activities VALUES("192","2014-05-14 19:21:27","1","login","2014-05-14 19:21:27");
INSERT INTO admin_user_activities VALUES("193","2014-05-14 20:28:08","1","login","2014-05-14 20:28:08");
INSERT INTO admin_user_activities VALUES("194","2014-05-14 21:55:50","1","login","2014-05-14 21:55:50");
INSERT INTO admin_user_activities VALUES("195","2014-05-16 15:13:23","1","login","2014-05-16 15:13:23");
INSERT INTO admin_user_activities VALUES("196","2014-05-17 13:02:01","1","login","2014-05-17 13:02:01");
INSERT INTO admin_user_activities VALUES("197","2014-05-21 13:29:49","1","login","2014-05-21 13:29:49");
INSERT INTO admin_user_activities VALUES("198","2014-05-23 11:35:21","1","login","2014-05-23 11:35:21");



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
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

INSERT INTO authors VALUES("1","Google","http://android.googlesource.com");
INSERT INTO authors VALUES("2","Square Open Source","http://square.github.io/");
INSERT INTO authors VALUES("3","emilsjolander","https://github.com/emilsjolander");
INSERT INTO authors VALUES("4","bumptech","https://github.com/bumptech");
INSERT INTO authors VALUES("5","keyboardsurfer","https://github.com/keyboardsurfer");
INSERT INTO authors VALUES("6","loopj","https://github.com/loopj");
INSERT INTO authors VALUES("7","nvanbenschoten","https://github.com/nvanbenschoten");
INSERT INTO authors VALUES("8","Lafosca","https://github.com/lafosca");
INSERT INTO authors VALUES("9","Ribot","https://github.com/ribot");
INSERT INTO authors VALUES("10","nhaarman","https://github.com/nhaarman");
INSERT INTO authors VALUES("11","romannurik","https://github.com/romannurik");
INSERT INTO authors VALUES("12","jgilfelt","https://github.com/jgilfelt");
INSERT INTO authors VALUES("13","satyan","https://github.com/satyan");
INSERT INTO authors VALUES("14","commonsguy","https://github.com/commonsguy");
INSERT INTO authors VALUES("15","JakeWharton","https://github.com/JakeWharton");
INSERT INTO authors VALUES("16","chrisbanes","https://github.com/chrisbanes");
INSERT INTO authors VALUES("17","SimonVT","https://github.com/SimonVT");
INSERT INTO authors VALUES("18","JohnPersano","https://github.com/JohnPersano");
INSERT INTO authors VALUES("19","castorflex","https://github.com/castorflex");
INSERT INTO authors VALUES("20","Inmite s.r.o.","https://github.com/inmite");
INSERT INTO authors VALUES("21","anupcowkur","https://github.com/anupcowkur");
INSERT INTO authors VALUES("22","Weddingparty","https://github.com/weddingparty");
INSERT INTO authors VALUES("23","chrisjenx","https://github.com/chrisjenx");
INSERT INTO authors VALUES("24","Etsy, Inc.","https://github.com/etsy");
INSERT INTO authors VALUES("25","jfeinstein10","https://github.com/jfeinstein10");
INSERT INTO authors VALUES("26","ManuelPeinado","https://github.com/ManuelPeinado");
INSERT INTO authors VALUES("27","antonyt","https://github.com/antonyt");
INSERT INTO authors VALUES("28","MustafaFerhan","https://github.com/MustafaFerhan");
INSERT INTO authors VALUES("29","RobotiumTech","https://github.com/RobotiumTech");
INSERT INTO authors VALUES("30","BugSense","https://www.bugsense.com/");
INSERT INTO authors VALUES("31","JoanZapata","https://github.com/JoanZapata");
INSERT INTO authors VALUES("32","jimu Labs Inc.","http://jimulabs.com/");
INSERT INTO authors VALUES("33","Genymotion","http://www.genymotion.com/");
INSERT INTO authors VALUES("34","tizionario","https://github.com/tizionario");
INSERT INTO authors VALUES("35","PomepuyN","https://github.com/PomepuyN");
INSERT INTO authors VALUES("36","Comcast","https://github.com/Comcast");
INSERT INTO authors VALUES("37","nadavfima","https://github.com/nadavfima");
INSERT INTO authors VALUES("38","ACRA","https://github.com/ACRA");
INSERT INTO authors VALUES("39","koush","https://github.com/koush");
INSERT INTO authors VALUES("40","nostra13","https://github.com/nostra13");
INSERT INTO authors VALUES("41","Joda.org","https://github.com/JodaOrg");
INSERT INTO authors VALUES("42","Roomorama","https://github.com/roomorama");
INSERT INTO authors VALUES("43","vinc3m1","https://github.com/vinc3m1");
INSERT INTO authors VALUES("44","Umano","https://github.com/umano");
INSERT INTO authors VALUES("45","Startappz","https://github.com/Startappz");
INSERT INTO authors VALUES("46","hoang8f","https://github.com/hoang8f");
INSERT INTO authors VALUES("47","greenrobot","https://github.com/greenrobot");
INSERT INTO authors VALUES("48","pedrovgs","https://github.com/pedrovgs");
INSERT INTO authors VALUES("49","idunnololz","https://github.com/idunnololz");
INSERT INTO authors VALUES("50","tbouron","https://github.com/tbouron");
INSERT INTO authors VALUES("51","flavienlaurent","https://github.com/flavienlaurent");
INSERT INTO authors VALUES("52","RomainPiel","https://github.com/RomainPiel");



DROP TABLE IF EXISTS categories;

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL COMMENT 'ID of the parent category (found in same table)',
  PRIMARY KEY (`cat_id`),
  KEY `active` (`active`,`name`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

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
INSERT INTO categories VALUES("31","2014-05-14 20:40:57","1","Drawer","2");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO configs VALUES("1","2013-05-06 17:43:04","2013-11-23 19:36:32","con1","1","integer","1");
INSERT INTO configs VALUES("2","0000-00-00 00:00:00","2014-05-23 12:41:55","RESOURCE_DESCRIPTION_MAXLENGTH","300","","RESOURCE_DESCRIPTION_MAXLENGTH");



DROP TABLE IF EXISTS res_cat;

CREATE TABLE `res_cat` (
  `res_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

INSERT INTO res_cat VALUES("25","4","10","2014-04-17 17:04:13");
INSERT INTO res_cat VALUES("26","4","4","2014-04-17 17:04:13");
INSERT INTO res_cat VALUES("27","4","3","2014-04-17 17:04:13");
INSERT INTO res_cat VALUES("62","2","5","2014-05-13 22:11:25");
INSERT INTO res_cat VALUES("63","2","12","2014-05-13 22:11:25");
INSERT INTO res_cat VALUES("64","2","10","2014-05-13 22:11:25");
INSERT INTO res_cat VALUES("75","3","8","2014-05-13 22:46:39");
INSERT INTO res_cat VALUES("76","3","4","2014-05-13 22:46:39");
INSERT INTO res_cat VALUES("77","3","10","2014-05-13 22:46:39");
INSERT INTO res_cat VALUES("83","1","13","2014-05-13 22:58:36");
INSERT INTO res_cat VALUES("84","5","4","2014-05-14 16:11:47");
INSERT INTO res_cat VALUES("85","6","6","2014-05-14 16:12:34");
INSERT INTO res_cat VALUES("86","7","7","2014-05-14 16:17:19");
INSERT INTO res_cat VALUES("87","8","8","2014-05-14 16:18:27");
INSERT INTO res_cat VALUES("88","9","6","2014-05-14 16:19:41");
INSERT INTO res_cat VALUES("90","10","6","2014-05-14 16:57:33");
INSERT INTO res_cat VALUES("94","13","11","2014-05-14 17:40:23");
INSERT INTO res_cat VALUES("96","14","11","2014-05-14 20:30:17");
INSERT INTO res_cat VALUES("97","15","11","2014-05-14 20:30:58");
INSERT INTO res_cat VALUES("98","16","11","2014-05-14 20:31:48");
INSERT INTO res_cat VALUES("100","18","4","2014-05-14 20:33:40");
INSERT INTO res_cat VALUES("102","20","12","2014-05-14 20:35:59");
INSERT INTO res_cat VALUES("103","21","12","2014-05-14 20:37:13");
INSERT INTO res_cat VALUES("104","22","13","2014-05-14 20:38:32");
INSERT INTO res_cat VALUES("107","24","31","2014-05-14 20:42:13");
INSERT INTO res_cat VALUES("108","25","7","2014-05-14 20:42:43");
INSERT INTO res_cat VALUES("109","26","16","2014-05-14 20:43:18");
INSERT INTO res_cat VALUES("110","27","17","2014-05-14 20:44:00");
INSERT INTO res_cat VALUES("111","28","18","2014-05-14 20:44:47");
INSERT INTO res_cat VALUES("112","29","19","2014-05-14 20:45:22");
INSERT INTO res_cat VALUES("113","19","11","2014-05-21 13:35:59");
INSERT INTO res_cat VALUES("114","17","4","2014-05-21 13:36:33");
INSERT INTO res_cat VALUES("118","12","9","2014-05-21 13:45:34");
INSERT INTO res_cat VALUES("119","12","10","2014-05-21 13:45:34");
INSERT INTO res_cat VALUES("123","11","9","2014-05-21 13:46:29");
INSERT INTO res_cat VALUES("124","11","12","2014-05-21 13:46:29");
INSERT INTO res_cat VALUES("125","11","4","2014-05-21 13:46:29");
INSERT INTO res_cat VALUES("126","11","25","2014-05-21 13:46:29");
INSERT INTO res_cat VALUES("135","23","14","2014-05-23 12:42:08");
INSERT INTO res_cat VALUES("136","23","11","2014-05-23 12:42:08");



DROP TABLE IF EXISTS resources;

CREATE TABLE `resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(200) NOT NULL,
  `rating` tinyint(4) unsigned NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`),
  KEY `active` (`active`,`name`,`is_approved`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

INSERT INTO resources VALUES("1","2014-05-21 13:10:18","0","Geny motion a really looooong name that has no meaning and just takes up space","jfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf","http://google.com/geny","0","206","1818","1","0","1");
INSERT INTO resources VALUES("2","2014-05-21 13:10:18","0","Intellij !!!!!!!!","jfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf sdf sf sdfsdf sd sdfdsf sdf sdf ds fds sjfdsa;lfkjafdsfds; fds fdsf","http://google.com/intellij","0","280","1546","2","0","1");
INSERT INTO resources VALUES("3","2014-05-14 15:02:35","0","Intellij idea","ffjkdhf kjsdhf kjdshdf kjdshd fkjsdh fksdjhf ksdjhf ksdh fkds ffjkdhf kjsdhf kjdshdf kjdshd fkjsdh fksdjhf ksdjhf ksdh fkds f zzzzzzzzz aaaaa","http://google.com/geny","0","282","1274","0","0","1");
INSERT INTO resources VALUES("4","2014-05-13 21:47:05","1","Intellij idea hh","jfdsa;lfkjas;lfkj;al","","0","470","4733","0","0","0");
INSERT INTO resources VALUES("5","2014-05-21 13:10:18","1","Sprinkles","Sprinkles is a boiler-plate-reduction-library for dealing with databases in android applications. Some would call it a kind of ORM but I don\'t see it that way. Sprinkles lets SQL do what it is good at, making complex queries. SQL however is a mess (in my opinion) when is comes to everything else. Th","https://github.com/emilsjolander/sprinkles","0","0","0","3","0","1");
INSERT INTO resources VALUES("6","2014-05-14 16:12:40","1","Retrofit","Type-safe REST client for Android and Java.","http://square.github.io/retrofit/","0","0","0","2","0","1");
INSERT INTO resources VALUES("7","2014-05-21 13:10:18","1","Crouton","Crouton is a class that can be used by Android developers that feel the need for an alternative to the Context insensitive Toast. A Crouton will be displayed at the position the developer decides. Standard will be the top of an application window. You can line up multiple Croutons for display, that","https://github.com/keyboardsurfer/Crouton","0","0","0","5","0","1");
INSERT INTO resources VALUES("8","2014-05-21 13:10:18","1","Glide","Glide is fast and efficient image loading library for Android that wraps image downloading, re-sizing, memory and disk caching, and bitmap recycling into one simple and easy to use interface. By default, Glide includes an implementation for fetching images over http based on Google\'s Volley project","https://github.com/bumptech/glide","0","0","0","4","0","1");
INSERT INTO resources VALUES("9","2014-05-14 16:19:41","1","Android Asynchronous HTTP Client","An asynchronous callback-based Http client for Android built on top of Apache’s HttpClient libraries. All requests are made outside of your app’s main UI thread, but any callback logic will be executed on the same thread as the callback was created using Android’s Handler message passing.","https://github.com/loopj/android-async-http","0","0","0","6","0","1");
INSERT INTO resources VALUES("10","2014-05-21 13:10:18","1","Volley","Volley is a library that makes networking for Android apps easier and most importantly, faster. We\'ll give an overview of how it works, common patterns that work well with it, and a walkthrough of how you can easily load thumbnail images for your ListView from the network in parallel.","https://android.googlesource.com/platform/frameworks/volley/","0","0","0","1","0","1");
INSERT INTO resources VALUES("11","2014-05-21 13:10:18","1","Motion","An Android library allowing images to exhibit a parallax effect. By replacing static pictures and backgrounds with a fluid images that reacts to screen tilt and orientation, Android applications can add a perceived depth and layering to their content. Motion works great for both full screen backgrou","https://github.com/nvanbenschoten/motion","0","0","0","7","0","1");
INSERT INTO resources VALUES("12","2014-05-14 17:39:02","1","AndroidFaceCropper","A library for cropping faces out of a bitmap and ImageViews.","https://github.com/lafosca/AndroidFaceCropper","0","0","0","8","0","1");
INSERT INTO resources VALUES("13","2014-05-14 17:40:23","1","EasyAdapter","Using AdapterViews has never been so easy. Inspired by the view holder design pattern, this library provides an easier way of linking AdapterViews and the underlying data for that view without having to implement your own Adapter. The EasyAdapter will do the tedious work for you.","https://github.com/ribot/easy-adapter","0","0","0","9","0","1");
INSERT INTO resources VALUES("14","2014-05-21 13:10:53","1","ListViewAnimations","ListViewAnimations provides the following features:<ul><li>Appearance animations for items in ListViews, GridViews, and other AbsListViews;</li><li>Built in animations include Alpha, SwingRightIn, SwingLeftIn, SwingBottomIn, SwingRightIn and ScaleIn.</li><li>Other animations can easily be ad</li></ul>","https://github.com/nhaarman/ListViewAnimations","0","0","0","10","0","1");
INSERT INTO resources VALUES("15","2014-05-14 20:30:58","1","StickyListHeaders","StickyListHeaders is an Android library that makes it easy to integrate section headers in your ListView.","https://github.com/emilsjolander/StickyListHeaders","0","0","0","3","0","1");
INSERT INTO resources VALUES("16","2014-05-14 20:31:48","1","Swipe To Dismiss","Sample code that shows how to make ListView or other views support the swipe-to-dismiss Android UI pattern.","https://github.com/romannurik/Android-SwipeToDismiss","0","0","0","11","0","1");
INSERT INTO resources VALUES("17","2014-05-21 13:36:32","1","SQLlite Asset Helper","An Android helper class to manage database creation and version management using an application\'s raw asset files.<br />This class provides developers with a simple way to ship their Android app with an existing SQLite database (which may be pre-populated with data) and to manage its initial c","https://github.com/jgilfelt/android-sqlite-asset-helper","0","0","0","12","0","1");
INSERT INTO resources VALUES("18","2014-05-21 13:11:05","1","Sugar","<ul><li>It is intended to simplify the interaction with SQLite database in Android.</li><li>It eliminates writing SQL queries to interact with SQLite db.</li><li>It takes care of creating your database.</li><li>It manages object relationships too.</li><li>It provides you with clear and sim</li></ul>","https://github.com/satyan/sugar","0","0","0","13","0","1");
INSERT INTO resources VALUES("19","2014-05-21 13:35:59","1","CWAC EndlessAdapter","AJAX Web sites have sometimes taken up the \"endless page\" model, where scrolling automatically loads in new content, so you never have to click a \"Next\" link or anything like that.<br />EndlessAdapter is one approach to solving this problem.<br />It is designed to wrap around another ada","https://github.com/commonsguy/cwac-endless","0","0","0","14","0","1");
INSERT INTO resources VALUES("20","2014-05-14 20:35:59","1","Butter Knife","View \"injection\" library for Android.","https://github.com/JakeWharton/butterknife","0","0","0","15","0","1");
INSERT INTO resources VALUES("21","2014-05-14 20:37:13","1","Dagger","A fast dependency injector for Android and Java.","https://github.com/square/dagger","0","0","0","2","0","1");
INSERT INTO resources VALUES("22","2014-05-14 20:38:32","1","Gson","Gson is a Java library that can be used to convert Java Objects into their JSON representation. It can also be used to convert a JSON string to an equivalent Java object. Gson can work with arbitrary Java objects including pre-existing objects that you do not have source-code of.","https://code.google.com/p/google-gson/","0","0","0","1","0","1");
INSERT INTO resources VALUES("23","2014-05-23 12:42:07","1","ActionBar-PullToRefresh","ActionBar-PullToRefresh provides an easy way to add a modern version of the pull-to-refresh interaction to your application.ActionBar-PullToRefresh provides an easy way to add a modern version of the pull-to-refresh interaction to your application.ActionBar-PullToRefresh provides an easy way to addx","https://github.com/chrisbanes/ActionBar-PullToRefresh","8","0","0","16","0","1");
INSERT INTO resources VALUES("24","2014-05-14 20:42:13","1","MenuDrawer","A slide-out menu implementation, which allows users to navigate between views in your app. Most commonly the menu is revealed by either dragging the edge of the screen, or clicking the \'up\' button in the action bar.","https://github.com/SimonVT/android-menudrawer","0","0","0","17","0","1");
INSERT INTO resources VALUES("25","2014-05-21 13:10:18","1","SuperToasts","The SuperToasts library enhances and builds upon the Android Toast class. Some of the features of this library include context sensitive toasts (SuperActivityToasts), toasts with buttons and icons, non context sensitive toasts (SuperToasts), and a new style of toasts (SuperCardToasts) with many cust","https://github.com/JohnPersano/SuperToasts","0","0","0","18","0","1");
INSERT INTO resources VALUES("26","2014-05-14 20:43:18","1","SmoothProgressBar","Small library allowing you to make a smooth indeterminate progress bar.","https://github.com/castorflex/SmoothProgressBar","0","0","0","19","0","1");
INSERT INTO resources VALUES("27","2014-05-14 20:43:59","1","StyledDialogs","This library makes styling and using dialogs a piece of cake.","https://github.com/inmite/android-styled-dialogs","0","0","0","20","0","1");
INSERT INTO resources VALUES("28","2014-05-14 20:44:46","1","Wheel Menu","A wheel menu for android","https://github.com/anupcowkur/Android-Wheel-Menu","0","0","0","21","0","1");
INSERT INTO resources VALUES("29","2014-05-14 20:45:22","1","Floating Label Edit Text","Textview that implements the floating label pattern.","https://github.com/weddingparty/AndroidFloatLabel","0","0","0","22","0","1");



DROP TABLE IF EXISTS users;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime NOT NULL,
  `active` tinyint(1) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `password` varchar(60) NOT NULL,
  `access_token` varchar(200) NOT NULL,
  `refresh_token` varchar(200) NOT NULL,
  `authorization_code` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




