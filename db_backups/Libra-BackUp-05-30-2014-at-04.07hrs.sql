DROP TABLE IF EXISTS admin_pages;

CREATE TABLE `admin_pages` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_or_last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `page_type` varchar(50) NOT NULL,
  `file_description` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

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
INSERT INTO admin_pages VALUES("26","2014-05-29 20:38:34","upload","upload csv script","1");
INSERT INTO admin_pages VALUES("27","2014-05-30 02:18:52","update_libraries","update_libraries","1");
INSERT INTO admin_pages VALUES("28","2014-05-30 02:18:44","update_authors","update_authors","1");



DROP TABLE IF EXISTS admin_role_permissions;

CREATE TABLE `admin_role_permissions` (
  `rp_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_id` int(11) NOT NULL,
  `permission_type` varchar(50) NOT NULL,
  `page_id` int(11) NOT NULL,
  PRIMARY KEY (`rp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

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
INSERT INTO admin_role_permissions VALUES("33","2014-05-29 20:38:55","1","VIEW;SEARCH;CREATE;EDIT;DELETE","26");
INSERT INTO admin_role_permissions VALUES("34","2014-05-29 22:08:30","1","VIEW;SEARCH;CREATE;EDIT;DELETE","27");
INSERT INTO admin_role_permissions VALUES("35","2014-05-29 22:08:30","1","VIEW;SEARCH;CREATE;EDIT;DELETE","28");



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
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=latin1 COMMENT='Tracking every activity of the admin';

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
INSERT INTO admin_user_activities VALUES("199","2014-05-23 14:17:55","1","login","2014-05-23 14:17:55");
INSERT INTO admin_user_activities VALUES("200","2014-05-25 10:46:14","3","login","2014-05-25 10:46:14");
INSERT INTO admin_user_activities VALUES("201","2014-05-25 10:46:36","1","login","2014-05-25 10:46:36");
INSERT INTO admin_user_activities VALUES("202","2014-05-25 14:33:57","1","login","2014-05-25 14:33:57");
INSERT INTO admin_user_activities VALUES("203","2014-05-28 11:56:40","1","login","2014-05-28 11:56:40");
INSERT INTO admin_user_activities VALUES("204","2014-05-28 13:18:00","1","login","2014-05-28 13:18:00");
INSERT INTO admin_user_activities VALUES("205","2014-05-28 13:19:19","1","login","2014-05-28 13:19:19");
INSERT INTO admin_user_activities VALUES("206","2014-05-28 13:19:34","1","login","2014-05-28 13:19:34");
INSERT INTO admin_user_activities VALUES("207","2014-05-28 14:51:25","1","login","2014-05-28 14:51:25");
INSERT INTO admin_user_activities VALUES("208","2014-05-28 20:24:19","1","login","2014-05-28 20:24:19");
INSERT INTO admin_user_activities VALUES("209","2014-05-28 21:06:37","1","login","2014-05-28 21:06:37");
INSERT INTO admin_user_activities VALUES("210","2014-05-28 22:06:04","1","login","2014-05-28 22:06:04");
INSERT INTO admin_user_activities VALUES("211","2014-05-28 23:30:04","1","login","2014-05-28 23:30:04");
INSERT INTO admin_user_activities VALUES("212","2014-05-29 18:24:15","1","login","2014-05-29 18:24:15");
INSERT INTO admin_user_activities VALUES("213","2014-05-29 20:32:49","1","login","2014-05-29 20:32:49");
INSERT INTO admin_user_activities VALUES("214","2014-05-29 20:39:31","1","login","2014-05-29 20:39:31");
INSERT INTO admin_user_activities VALUES("215","2014-05-29 23:29:21","1","login","2014-05-29 23:29:21");
INSERT INTO admin_user_activities VALUES("216","2014-05-30 02:19:12","1","login","2014-05-30 02:19:12");



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
  `github_author_id` int(11) NOT NULL DEFAULT '0',
  `is_github` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

INSERT INTO authors VALUES("1","Google","http://android.googlesource.com","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("2","Square Open Source","http://square.github.io/","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("3","emilsjolander","https://github.com/emilsjolander","1525924","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("4","bumptech","https://github.com/bumptech","423539","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("5","keyboardsurfer","https://github.com/keyboardsurfer","336005","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("6","loopj","https://github.com/loopj","104009","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("7","nvanbenschoten","https://github.com/nvanbenschoten","5438456","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("8","Lafosca","https://github.com/lafosca","3064345","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("9","Ribot","https://github.com/ribot","26924","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("10","nhaarman","https://github.com/nhaarman","3015152","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("11","romannurik","https://github.com/romannurik","100155","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("12","jgilfelt","https://github.com/jgilfelt","175697","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("13","satyan","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("14","commonsguy","https://github.com/commonsguy","103772","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("15","JakeWharton","https://github.com/JakeWharton","66577","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("16","chrisbanes","https://github.com/chrisbanes","227486","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("17","SimonVT","https://github.com/SimonVT","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("18","JohnPersano","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("19","castorflex","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("20","Inmite s.r.o.","https://github.com/inmite","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("21","anupcowkur","https://github.com/anupcowkur","1691740","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("22","Weddingparty","https://github.com/weddingparty","5777037","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("23","chrisjenx","https://github.com/chrisjenx","1167793","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("24","Etsy, Inc.","https://github.com/etsy","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("25","jfeinstein10","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("26","ManuelPeinado","https://github.com/ManuelPeinado","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("27","antonyt","https://github.com/antonyt","964952","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("28","MustafaFerhan","https://github.com/MustafaFerhan","1121700","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("29","RobotiumTech","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("30","BugSense","https://www.bugsense.com/","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("31","JoanZapata","https://github.com/JoanZapata","675408","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("32","jimu Labs Inc.","http://jimulabs.com/","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("33","Genymotion","http://www.genymotion.com/","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("34","tizionario","https://github.com/tizionario","2451183","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("35","PomepuyN","https://github.com/PomepuyN","371298","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("36","Comcast","https://github.com/Comcast","709212","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("37","nadavfima","https://github.com/nadavfima","688836","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("38","ACRA","https://github.com/ACRA","2363625","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("39","koush","https://github.com/koush","73924","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("40","nostra13","https://github.com/nostra13","1223348","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("41","Joda.org","https://github.com/JodaOrg","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("42","Roomorama","https://github.com/roomorama","53760","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("43","vinc3m1","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("44","Umano","https://github.com/umano","4552937","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("45","Startappz","https://github.com/Startappz","1978233","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("46","hoang8f","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("47","greenrobot","https://github.com/greenrobot","242242","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("48","pedrovgs","https://github.com/pedrovgs","4030704","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("49","idunnololz","https://github.com/idunnololz","3893565","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("50","tbouron","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("51","flavienlaurent","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("52","RomainPiel","","0","0","0000-00-00 00:00:00");
INSERT INTO authors VALUES("54","kikoso","https://github.com/kikoso","903097","0","2014-05-29 23:49:29");
INSERT INTO authors VALUES("55","Square","https://github.com/square","82592","0","2014-05-29 23:50:34");
INSERT INTO authors VALUES("56","SimonTV","https://github.com/SimonVT","549365","0","2014-05-29 23:50:35");
INSERT INTO authors VALUES("57","inmite","https://github.com/inmite","3819616","0","2014-05-29 23:50:35");
INSERT INTO authors VALUES("58","etsy","","0","0","2014-05-29 23:50:35");
INSERT INTO authors VALUES("59","Jimu Labs","","0","0","2014-05-29 23:50:36");
INSERT INTO authors VALUES("60","Community","","0","0","2014-05-29 23:50:36");
INSERT INTO authors VALUES("65","flavioarfaria","https://github.com/flavioarfaria","1800351","0","2014-05-29 23:50:37");
INSERT INTO authors VALUES("67","JodaOrg1","","0","0","2014-05-30 00:11:15");
INSERT INTO authors VALUES("68","JodaOrg","https://github.com/JodaOrg","779257","0","2014-05-30 00:59:53");



DROP TABLE IF EXISTS categories;

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'ID of the parent category (found in same table)',
  PRIMARY KEY (`cat_id`),
  KEY `active` (`active`,`name`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

INSERT INTO categories VALUES("10","2014-05-30 02:16:39","1","UI","0");
INSERT INTO categories VALUES("11","2014-05-30 02:16:39","1","Pull To Refreah","10");
INSERT INTO categories VALUES("12","2014-05-30 02:16:39","1","Development","0");
INSERT INTO categories VALUES("13","2014-05-30 02:16:39","1","Tools","12");
INSERT INTO categories VALUES("14","2014-05-30 02:16:39","1","Networking","0");
INSERT INTO categories VALUES("15","2014-05-30 02:16:39","1","Http Clients","14");
INSERT INTO categories VALUES("16","2014-05-30 02:16:39","1","Icons","0");
INSERT INTO categories VALUES("17","2014-05-30 02:16:39","1","Drawer","10");
INSERT INTO categories VALUES("18","2014-05-30 02:16:40","1","Databases","0");
INSERT INTO categories VALUES("19","2014-05-30 02:16:40","1","ImageView","0");
INSERT INTO categories VALUES("20","2014-05-30 02:16:40","1","dialog","0");
INSERT INTO categories VALUES("21","2014-05-30 02:16:40","1","Listview","0");
INSERT INTO categories VALUES("22","2014-05-30 02:16:40","1","Image Loading","14");
INSERT INTO categories VALUES("23","2014-05-30 02:16:40","1","ViewPager","0");
INSERT INTO categories VALUES("24","2014-05-30 02:16:40","1","wheel menu","0");
INSERT INTO categories VALUES("25","2014-05-30 02:16:41","1","Camera, ImageView","0");
INSERT INTO categories VALUES("26","2014-05-30 02:16:41","1","TextView","0");
INSERT INTO categories VALUES("27","2014-05-30 02:16:41","1","Bug Tracking","12");
INSERT INTO categories VALUES("28","2014-05-30 02:16:41","1","Dependancy Injection","0");
INSERT INTO categories VALUES("29","2014-05-30 02:16:41","1","CalenderView","0");
INSERT INTO categories VALUES("30","2014-05-30 02:16:42","1","Fonts","0");
INSERT INTO categories VALUES("31","2014-05-30 02:16:42","1","toasts","0");
INSERT INTO categories VALUES("32","2014-05-30 02:16:42","1","Debugging","0");
INSERT INTO categories VALUES("33","2014-05-30 02:16:42","1","Feedback","0");
INSERT INTO categories VALUES("34","2014-05-30 02:16:42","1","other","0");
INSERT INTO categories VALUES("35","2014-05-30 02:16:43","1","Event Bus","0");
INSERT INTO categories VALUES("36","2014-05-30 02:16:43","1","ActionBar","0");
INSERT INTO categories VALUES("37","2014-05-30 02:16:43","1","JSON","0");
INSERT INTO categories VALUES("38","2014-05-30 02:16:45","1","RadioButton","0");
INSERT INTO categories VALUES("39","2014-05-30 02:16:45","1","Sensors","0");
INSERT INTO categories VALUES("40","2014-05-30 02:16:45","1","progressbar","0");



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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO configs VALUES("1","2013-05-06 17:43:04","2013-11-23 19:36:32","con1","1","integer","1");
INSERT INTO configs VALUES("2","0000-00-00 00:00:00","2014-05-28 14:52:13","RESOURCE_DESCRIPTION_MAXLENGTH","200","","RESOURCE_DESCRIPTION_MAXLENGTH");
INSERT INTO configs VALUES("3","0000-00-00 00:00:00","2014-05-30 02:34:24","GITHUB_API_URL","https://api.github.com/repos/","","GITHUB_API_URL");
INSERT INTO configs VALUES("4","0000-00-00 00:00:00","2014-05-30 03:38:44","GITHUB_API_CALL_LIMIT","30","","GITHUB_API_CALL_LIMIT");



DROP TABLE IF EXISTS res_cat;

CREATE TABLE `res_cat` (
  `res_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;

INSERT INTO res_cat VALUES("10","10","11","2014-05-30 02:16:39");
INSERT INTO res_cat VALUES("11","11","13","2014-05-30 02:16:39");
INSERT INTO res_cat VALUES("12","12","15","2014-05-30 02:16:39");
INSERT INTO res_cat VALUES("13","13","16","2014-05-30 02:16:39");
INSERT INTO res_cat VALUES("14","14","17","2014-05-30 02:16:39");
INSERT INTO res_cat VALUES("15","15","18","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("16","16","19","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("17","17","20","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("18","18","21","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("19","19","22","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("20","20","23","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("21","21","24","2014-05-30 02:16:40");
INSERT INTO res_cat VALUES("22","22","13","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("23","23","25","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("24","24","26","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("25","25","13","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("26","26","17","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("27","27","21","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("28","28","21","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("29","29","27","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("30","30","27","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("31","31","28","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("32","32","13","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("33","33","29","2014-05-30 02:16:41");
INSERT INTO res_cat VALUES("34","34","30","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("35","35","21","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("36","36","31","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("37","37","21","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("38","38","28","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("39","39","32","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("40","40","33","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("41","41","17","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("42","42","34","2014-05-30 02:16:42");
INSERT INTO res_cat VALUES("43","43","21","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("44","44","35","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("45","45","36","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("46","46","34","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("47","47","34","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("48","48","34","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("49","49","13","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("50","50","22","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("51","51","18","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("52","52","37","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("53","53","23","2014-05-30 02:16:43");
INSERT INTO res_cat VALUES("54","54","15","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("55","55","29","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("56","56","19","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("57","57","21","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("58","58","13","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("59","59","34","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("60","60","19","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("61","61","18","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("62","62","35","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("63","63","34","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("64","64","19","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("65","65","21","2014-05-30 02:16:44");
INSERT INTO res_cat VALUES("66","66","15","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("67","67","13","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("68","68","19","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("69","69","32","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("70","70","38","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("71","71","39","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("72","72","26","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("73","73","17","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("74","74","40","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("75","75","18","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("76","76","21","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("77","77","18","2014-05-30 02:16:45");
INSERT INTO res_cat VALUES("78","78","31","2014-05-30 02:16:46");
INSERT INTO res_cat VALUES("79","79","29","2014-05-30 02:16:46");
INSERT INTO res_cat VALUES("80","80","23","2014-05-30 02:16:46");
INSERT INTO res_cat VALUES("81","81","15","2014-05-30 02:16:46");



DROP TABLE IF EXISTS resources;

CREATE TABLE `resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `description` text,
  `url` varchar(200) NOT NULL,
  `rating` tinyint(4) unsigned DEFAULT NULL,
  `is_github` tinyint(1) DEFAULT '1',
  `github_resource_id` int(11) DEFAULT NULL,
  `github_stargazers` int(11) DEFAULT '0',
  `github_forks` int(11) DEFAULT '0',
  `github_updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `author_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`),
  KEY `active` (`active`,`name`,`is_approved`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;

INSERT INTO resources VALUES("10","2014-05-30 03:37:15","1","ActionBar-PullToRefresh","ActionBar-PullToRefresh provides an easy way to add a modern version of the pull-to-refresh interaction to your application.","https://github.com/chrisbanes/ActionBar-PullToRefresh","","1","10480910","2442","751","2014-05-30 03:37:15","16","0","1");
INSERT INTO resources VALUES("11","2014-05-30 02:16:39","1","Android Asset Studio","Excellent community tools to generate custom graphics for Actionbars , UI controls and icons.","http://android-ui-utils.googlecode.com/hg/asset-studio/dist/index.html?utm_source=twitterfeed&utm_medium=twitter","","0","","0","0","0000-00-00 00:00:00","60","0","1");
INSERT INTO resources VALUES("12","2014-05-30 04:01:03","1","Android Asynchronous Http Client","An asynchronous callback-based Http client for Android built on top of Apache’s HttpClient libraries. All requests are made outside of your app’s main UI thread, but any callback logic will be exe","https://github.com/loopj/android-async-http","","1","1388245","3623","1776","2014-05-30 04:01:03","6","0","1");
INSERT INTO resources VALUES("13","2014-05-30 03:57:01","1","android-iconify","Integration of FontAwesome for Android","https://github.com/JoanZapata/android-iconify","","1","10641697","483","52","0000-00-00 00:00:00","31","0","1");
INSERT INTO resources VALUES("14","2014-05-30 03:57:02","1","android-menudrawer","A slide-out menu implementation, which allows users to navigate between views in your app. Most commonly the menu is revealed by either dragging the edge of the screen, or clicking the \'up\' button i","https://github.com/SimonVT/android-menudrawer","","1","5639802","1830","820","0000-00-00 00:00:00","56","0","1");
INSERT INTO resources VALUES("15","2014-05-30 03:26:42","1","android-sqllite-asset-helper","An Android helper class to manage database creation and version management using an application\'s raw asset files.\n\nThis class provides developers with a simple way to ship their Android app with a","https://github.com/jgilfelt/android-sqlite-asset-helper","","1","2927004","675","169","0000-00-00 00:00:00","12","0","1");
INSERT INTO resources VALUES("16","2014-05-30 03:26:43","1","android-stackblur","Android StackBlur is a library that can perform a blurry effect on a Bitmap based on a gradient or radius, and return the result. The library is based on the code of Mario Klingemann.","https://github.com/kikoso/android-stackblur","","1","12136636","669","165","0000-00-00 00:00:00","54","0","1");
INSERT INTO resources VALUES("17","2014-05-30 03:26:44","1","android-styled-dialogs","This library makes styling and using dialogs a piece of cake.","https://github.com/inmite/android-styled-dialogs","","1","10281119","821","197","0000-00-00 00:00:00","57","0","1");
INSERT INTO resources VALUES("18","2014-05-30 03:26:45","1","Android-SwipeToDismiss","Sample code that shows how to make ListView or other views support the swipe-to-dismiss Android UI pattern.","https://github.com/romannurik/Android-SwipeToDismiss","","1","12141504","484","136","0000-00-00 00:00:00","11","0","1");
INSERT INTO resources VALUES("19","2014-05-30 03:57:08","1","Android-Universal-Image-Loader","Powerful and flexible library for loading, caching and displaying images on Android.","https://github.com/nostra13/Android-Universal-Image-Loader","","1","2862290","4724","2223","0000-00-00 00:00:00","40","0","1");
INSERT INTO resources VALUES("20","2014-05-30 03:57:10","1","Android-ViewPagerIndicator","Paging indicator widgets that are compatible with the ViewPager from the Android Support Library to improve discoverability of content.","https://github.com/JakeWharton/Android-ViewPagerIndicator","","1","2155793","3677","2030","0000-00-00 00:00:00","15","0","1");
INSERT INTO resources VALUES("21","2014-05-30 03:26:49","1","Android-Wheel-Menu","A wheel menu for android","https://github.com/anupcowkur/Android-Wheel-Menu","","1","8177857","163","56","0000-00-00 00:00:00","21","0","1");
INSERT INTO resources VALUES("22","2014-05-30 03:26:50","1","AndroidDrawableFactory","A Java Application to create appropriate Drawable resources for your Android application","https://github.com/tizionario/AndroidDrawableFactory","","1","15845431","223","34","0000-00-00 00:00:00","34","0","1");
INSERT INTO resources VALUES("23","2014-05-30 03:26:53","1","AndroidFaceCropper","A library for cropping faces out of a bitmap and ImageViews.","https://github.com/lafosca/AndroidFaceCropper","","1","18222014","147","18","0000-00-00 00:00:00","8","0","1");
INSERT INTO resources VALUES("24","2014-05-30 03:26:55","1","AndroidFloatLabel","Textview that implements the floating label pattern.","https://github.com/weddingparty/AndroidFloatLabel","","1","15501185","266","22","0000-00-00 00:00:00","22","0","1");
INSERT INTO resources VALUES("25","2014-05-30 03:26:56","1","androidicons-adt-template","Android Studio / Eclipse ADT template for androidicons.com resources","https://github.com/jgilfelt/androidicons-adt-template","","1","18417563","153","4","0000-00-00 00:00:00","12","0","1");
INSERT INTO resources VALUES("26","2014-05-30 03:57:17","1","AndroidSlidingUpPanel","The 2.2 version of the Umano Android app features a sexy sliding up draggable panel for the currently playing article. This type of a panel is a common pattern also used in the Google Music app and th","https://github.com/umano/AndroidSlidingUpPanel","","1","10410764","1365","425","0000-00-00 00:00:00","44","0","1");
INSERT INTO resources VALUES("27","2014-05-30 02:16:41","1","AndroidStaggeredGrid","An Android staggered grid view which supports multiple columns with rows of varying sizes.","http://www.androidviews.net/2014/01/androidstaggeredgrid-view","","0","","0","0","0000-00-00 00:00:00","58","0","1");
INSERT INTO resources VALUES("28","2014-05-30 03:57:18","1","AnimatedExpandableListView","An extendable, flexible ExpandableListView widget that supports animations.\n\nThis project is dedicated to J Withey for giving me the motivation to write and release this source.","https://github.com/idunnololz/AnimatedExpandableListView","","1","18320484","61","15","0000-00-00 00:00:00","49","0","1");
INSERT INTO resources VALUES("29","2014-05-30 03:26:59","1","Application Crash Reports for Android","ACRA is a library enabling Android Application to automatically post their crash reports to a GoogleDoc form. It is targetted to android applications developers to help them get data from their applic","https://github.com/ACRA/acra","","1","5890835","1293","352","0000-00-00 00:00:00","38","0","1");
INSERT INTO resources VALUES("30","2014-05-30 02:16:41","1","Bugsense","BugSense is the leading developer tool to help you manage the Android fragmentation.\n\nLightweight\nProguard integration\nACRA\nCapture LogCat\nMaven / Gradle","http://www.bugsense.com/docs/android","","0","","0","0","0000-00-00 00:00:00","30","0","1");
INSERT INTO resources VALUES("31","2014-05-30 03:57:20","1","butterknife","View \"injection\" library for Android.","https://github.com/JakeWharton/butterknife","","1","8575137","1396","233","0000-00-00 00:00:00","15","0","1");
INSERT INTO resources VALUES("32","2014-05-30 03:27:02","1","butterknife-zelezny","Android Studio plug-in for generating ButterKnife injections from selected layout XML.","https://github.com/inmite/android-butterknife-zelezny","","1","15397085","313","25","0000-00-00 00:00:00","57","0","1");
INSERT INTO resources VALUES("33","2014-05-30 03:57:23","1","Caldroid","Caldroid is a fragment that display calendar with dates in a month. Caldroid can be used as embedded fragment, or as dialog fragment. User can also swipe left/right to navigate to different months.","https://github.com/roomorama/Caldroid","","1","8641067","317","131","0000-00-00 00:00:00","42","0","1");
INSERT INTO resources VALUES("34","2014-05-30 03:57:24","1","Calligraphy","Custom fonts in Android the easy way.","https://github.com/chrisjenx/Calligraphy","","1","15328210","561","43","0000-00-00 00:00:00","23","0","1");
INSERT INTO resources VALUES("35","2014-05-30 03:57:26","1","cardsui","An open source library offering the popular Google Now & Google Play cards views, additionnal features, view recycling and an optional Model-View-Controller structure.","https://github.com/nadavfima/cardsui-for-android","","1","16466386","114","57","0000-00-00 00:00:00","37","0","1");
INSERT INTO resources VALUES("36","2014-05-30 03:27:07","1","Crouton","Crouton is a class that can be used by Android developers that feel the need for an alternative to the Context insensitive Toast.\nA Crouton will be displayed at the position the developer decides. St","https://github.com/keyboardsurfer/Crouton","","1","5284389","1575","403","0000-00-00 00:00:00","5","0","1");
INSERT INTO resources VALUES("37","2014-05-30 03:27:08","1","cwac-endless","AJAX Web sites have sometimes taken up the \"endless page\" model, where scrolling automatically loads in new content, so you never have to click a \"Next\" link or anything like that.\n\nEndlessAdapt","https://github.com/commonsguy/cwac-endless","","1","256245","701","242","0000-00-00 00:00:00","14","0","1");
INSERT INTO resources VALUES("38","2014-05-30 03:27:09","1","dagger","A fast dependency injector for Android and Java.","https://github.com/square/dagger","","1","5279091","1885","272","0000-00-00 00:00:00","55","0","1");
INSERT INTO resources VALUES("39","2014-05-30 03:57:30","1","DebugLog","Create a simple and more understandable Android logs.","https://github.com/MustafaFerhan/DebugLog","","1","17419105","145","18","0000-00-00 00:00:00","28","0","1");
INSERT INTO resources VALUES("40","2014-05-30 03:27:12","1","discreet-app-rate","A lightweight non intrusive app rate reminder for Android","https://github.com/PomepuyN/discreet-app-rate","","1","17515267","330","22","0000-00-00 00:00:00","35","0","1");
INSERT INTO resources VALUES("41","2014-05-30 03:27:13","1","DobSliding","DobSliding is an Open Source Android library that allows developers to develop applications with vertical sliding menus just like the Android notifications menu.","https://github.com/Startappz/DobSliding","","1","17833053","102","7","0000-00-00 00:00:00","45","0","1");
INSERT INTO resources VALUES("42","2014-05-30 03:57:34","1","DraggablePanel","Android library used to create an awesome Android UI based on a draggable element similar to the last YouTube graphic component.","https://github.com/pedrovgs/DraggablePanel","","1","18727860","654","66","0000-00-00 00:00:00","48","0","1");
INSERT INTO resources VALUES("43","2014-05-30 03:27:15","1","easy-adapter","Using AdapterViews has never been so easy. Inspired by the view holder design pattern, this library provides an easier way of linking AdapterViews and the underlying data for that view without having ","https://github.com/ribot/easy-adapter","","1","16842589","138","7","0000-00-00 00:00:00","9","0","1");
INSERT INTO resources VALUES("44","2014-05-30 03:27:17","1","EventBus","Android optimized event bus that simplifies communication between Activities, Fragments, Threads, Services, etc. Less code, better quality.","https://github.com/greenrobot/EventBus","","1","5070389","1514","357","0000-00-00 00:00:00","47","0","1");
INSERT INTO resources VALUES("45","2014-05-30 02:16:43","1","Fading ActionBar","Android library implementing a fading effect for the action bar, similar to the one found in the Play Music app","http://www.androidviews.net/2013/05/fading-actionbar","","0","","0","0","0000-00-00 00:00:00","26","0","1");
INSERT INTO resources VALUES("46","2014-05-30 04:06:30","1","FlipView","A small, easy to use android library for implementing flipping between views as seen in the popular Flipboard application","https://github.com/emilsjolander/android-FlipView","","1","9119163","313","101","2014-05-30 04:06:30","3","0","1");
INSERT INTO resources VALUES("47","2014-05-30 03:27:19","1","flow","A small library that helps with describing an app as a collection of moderately independent screens.","https://github.com/square/flow","","1","12796207","325","25","0000-00-00 00:00:00","55","0","1");
INSERT INTO resources VALUES("48","2014-05-30 03:27:20","1","FreeFlow","A layout engine for Android that decouples layouts from the View containers that manage scrolling and view recycling. FreeFlow makes it really easy to create custom layouts and beautiful transition an","https://github.com/Comcast/FreeFlow","","1","13421516","1221","158","0000-00-00 00:00:00","36","0","1");
INSERT INTO resources VALUES("49","2014-05-30 02:16:43","1","Genymotion","Genymotion is the next generation of the AndroVM open source project, already trusted by 900,000 developers.\n\nIt’s even easier to use and has lots more functionalitie","http://www.genymotion.com","","0","","0","0","0000-00-00 00:00:00","33","0","1");
INSERT INTO resources VALUES("50","2014-05-30 03:27:23","1","Glide","Glide is fast and efficient image loading library for Android that wraps image downloading, resizing, memory and disk caching, and bitmap recycling into one simple and easy to use interface. By defaul","https://github.com/bumptech/glide","","1","11267509","349","53","0000-00-00 00:00:00","4","0","1");
INSERT INTO resources VALUES("51","2014-05-30 03:27:24","1","greenDAO","greenDAO is a light & fast ORM solution for Android that maps objects to SQLite databases.","https://github.com/greenrobot/greenDAO","","1","2626751","1160","455","0000-00-00 00:00:00","47","0","1");
INSERT INTO resources VALUES("52","2014-05-30 02:16:43","1","gson","Gson is a Java library that can be used to convert Java Objects into their JSON representation. It can also be used to convert a JSON string to an equivalent Java object. Gson can work with arbitrary ","http://code.google.com/p/google-gson","","0","","0","0","0000-00-00 00:00:00","1","0","1");
INSERT INTO resources VALUES("53","2014-05-30 03:27:25","1","InfiniteViewPager","Augment Android\'s ViewPager with wrap-around functionality.","https://github.com/antonyt/InfiniteViewPager","","1","3688003","108","51","0000-00-00 00:00:00","27","0","1");
INSERT INTO resources VALUES("54","2014-05-30 03:27:27","1","ion","Android Asynchronous Networking and Image Loading","https://github.com/koush/ion","","1","10214538","1652","250","0000-00-00 00:00:00","39","0","1");
INSERT INTO resources VALUES("55","2014-05-30 03:27:28","1","Joda-Time","Joda-Time provides a quality replacement for the Java date and time classes. The design allows for multiple calendar systems, while still providing a simple API. The \'default\' calendar is the ISO860","https://github.com/JodaOrg/joda-time","","1","1756350","778","134","0000-00-00 00:00:00","68","0","1");
INSERT INTO resources VALUES("56","2014-05-30 03:27:29","1","KenBurnsView","Android ImageViews animated by Ken Burns Effect","https://github.com/flavioarfaria/KenBurnsView","","1","17890722","240","26","0000-00-00 00:00:00","65","0","1");
INSERT INTO resources VALUES("57","2014-05-30 03:27:30","1","ListViewAnimations","ListViewAnimations provides the following features:\n\nAppearance animations for items in ListViews, GridViews, and other AbsListViews;\nBuilt in animations include Alpha, SwingRightIn, SwingLeftIn, S","https://github.com/nhaarman/ListViewAnimations","","1","8877512","1619","593","0000-00-00 00:00:00","10","0","1");
INSERT INTO resources VALUES("58","2014-05-30 02:16:44","1","Mirror","Mirror: Live previews of Android layouts\n\n\nCode layouts in Eclipse or Android Studio*\nPreview on real devices with Mirror, instantly\nSave time, write better code","http://jimulabs.com","","0","","0","0","0000-00-00 00:00:00","59","0","1");
INSERT INTO resources VALUES("59","2014-05-30 03:27:31","1","mortar","Mortar eases the use of Dagger to divide Android apps into composable modules. It is not a framework: there are no abstract Application or Activity classes here. Mortar eschews magic. Rather, Mortar i","https://github.com/square/mortar","","1","14247776","361","16","0000-00-00 00:00:00","55","0","1");
INSERT INTO resources VALUES("60","2014-05-30 03:27:33","1","Motion","An Android library allowing images to exhibit a parallax effect. By replacing static pictures and backgrounds with a fluid images that reacts to screen tilt and orientation, Android applications can a","https://github.com/nvanbenschoten/motion","","1","18415532","325","21","0000-00-00 00:00:00","7","0","1");
INSERT INTO resources VALUES("61","2014-05-30 02:16:44","1","OrmLite","Object Relational Mapping Lite (ORM Lite) provides some lightweight functionality for persisting Java objects to SQL databases while avoiding the complexity and overhead of more standard ORM packages.","http://ormlite.com/sqlite_java_android_orm.shtml","","0","","0","0","0000-00-00 00:00:00","0","0","1");
INSERT INTO resources VALUES("62","2014-05-30 03:27:34","1","otto","Otto is an event bus designed to decouple different parts of your application while still allowing them to communicate efficiently.\n\nForked from Guava, Otto adds unique functionality to an already r","https://github.com/square/otto","","1","4812336","1428","286","0000-00-00 00:00:00","55","0","1");
INSERT INTO resources VALUES("63","2014-05-30 03:27:35","1","PanningView","PanningView is a library which implements the animated background in the now playing screen of the Play Music app.","https://github.com/flavienlaurent/PanningView","","1","11900505","116","34","0000-00-00 00:00:00","51","0","1");
INSERT INTO resources VALUES("64","2014-05-30 03:27:36","1","Photoview","Implementation of ImageView for Android that supports zooming, by various touch gestures.","https://github.com/chrisbanes/PhotoView","","1","5084750","1824","736","0000-00-00 00:00:00","16","0","1");
INSERT INTO resources VALUES("65","2014-05-30 03:27:37","1","poppyview","Android library implementing a poppy view on scroll, similar to the one found in the Google Plus app","https://github.com/flavienlaurent/poppyview","","1","0","0","0","0000-00-00 00:00:00","51","0","1");
INSERT INTO resources VALUES("66","2014-05-30 02:16:45","1","Retrofit","Type-safe REST client for Android and Java.","http://square.github.io/retrofit","","0","","0","0","0000-00-00 00:00:00","55","0","1");
INSERT INTO resources VALUES("67","2014-05-30 03:27:39","1","robotium","Robotium is an Android test framework that has full support for WebViews, Activities, Dialogs, Toasts, Menus and Context Menus.","https://github.com/RobotiumTech/robotium","","1","0","0","0","0000-00-00 00:00:00","29","0","1");
INSERT INTO resources VALUES("68","2014-05-30 03:27:40","1","RoundedImageView","a fast ImageView that supports rounded corners and ovals or circles","https://github.com/vinc3m1/RoundedImageView","","1","0","0","0","0000-00-00 00:00:00","43","0","1");
INSERT INTO resources VALUES("69","2014-05-30 03:27:41","1","scalpel","A surgical debugging tool to uncover the layers under your app.","https://github.com/JakeWharton/scalpel","","1","0","0","0","0000-00-00 00:00:00","15","0","1");
INSERT INTO resources VALUES("70","2014-05-30 03:27:42","1","segmented-control","This implementation is inspired by Segmented Controls for iOS.\n\nA custom View for Android which is based on RadioGroup and RadioButton widget.","https://github.com/hoang8f/android-segmented-control","","1","0","0","0","0000-00-00 00:00:00","46","0","1");
INSERT INTO resources VALUES("71","2014-05-30 03:27:44","1","ShakeDetector","This library provides a easy way to detect a shake movement using the build-in accelerometer and fire a callback on the UI thread every times it happens.","https://github.com/tbouron/ShakeDetector","","1","0","0","0","0000-00-00 00:00:00","50","0","1");
INSERT INTO resources VALUES("72","2014-05-30 03:27:45","1","Shimmer-android","An Android TextView with a shimmering effect","https://github.com/RomainPiel/Shimmer-android","","1","0","0","0","0000-00-00 00:00:00","52","0","1");
INSERT INTO resources VALUES("73","2014-05-30 03:27:46","1","SlidingMenu","SlidingMenu is an Open Source Android library that allows developers to easily create applications with sliding menus like those made popular in the Google+, YouTube, and Facebook apps.","https://github.com/jfeinstein10/SlidingMenu","","1","0","0","0","0000-00-00 00:00:00","25","0","1");
INSERT INTO resources VALUES("74","2014-05-30 03:27:47","1","SmoothProgressBar","Small library allowing you to make a smooth indeterminate progress bar.","https://github.com/castorflex/SmoothProgressBar","","1","0","0","0","0000-00-00 00:00:00","19","0","1");
INSERT INTO resources VALUES("75","2014-05-30 03:27:48","1","Sprinkles","Sprinkles is a boiler-plate-reduction-library for dealing with databases in android applications. Some would call it a kind of ORM but I don\'t see it that way. Sprinkles lets SQL do what it is good a","https://github.com/emilsjolander/sprinkles","","1","0","0","0","0000-00-00 00:00:00","3","0","1");
INSERT INTO resources VALUES("76","2014-05-30 03:27:50","1","StickyListHeaders","StickyListHeaders is an Android library that makes it easy to integrate section headers in your ListView.","https://github.com/emilsjolander/StickyListHeaders","","1","0","0","0","0000-00-00 00:00:00","3","0","1");
INSERT INTO resources VALUES("77","2014-05-30 03:27:51","1","Sugar","It is intended to simplify the interaction with SQLite database in Android.\n\nIt eliminates writing SQL queries to interact with SQLite db.\nIt takes care of creating your database.\nIt manages objec","https://github.com/satyan/sugar","","1","0","0","0","0000-00-00 00:00:00","13","0","1");
INSERT INTO resources VALUES("78","2014-05-30 03:27:52","1","SuperToasts","The SuperToasts library enhances and builds upon the Android Toast class. Some of the features of this library include context sensitive toasts (SuperActivityToasts), toasts with buttons and icons, no","https://github.com/JohnPersano/SuperToasts","","1","0","0","0","0000-00-00 00:00:00","18","0","1");
INSERT INTO resources VALUES("79","2014-05-30 03:27:54","1","TimesSquare","Standalone Android widget for picking a single date from a calendar view.","https://github.com/square/android-times-square","","1","0","0","0","0000-00-00 00:00:00","55","0","1");
INSERT INTO resources VALUES("80","2014-05-30 03:27:55","1","ViewPager","An easy to use ViewPager that adds an awesome set of custom swiping animations. Just change your ViewPagers to JazzyViewPagers, two more steps, and you\'re good to go!","https://github.com/jfeinstein10/JazzyViewPager","","1","0","0","0","0000-00-00 00:00:00","25","0","1");
INSERT INTO resources VALUES("81","2014-05-30 02:16:46","1","Volley","Volley is a library that makes networking for Android apps easier and most importantly, faster. We\'ll give an overview of how it works, common patterns that work well with it, and a walkthrough of ho","http://android.googlesource.com/platform/frameworks/volley","","0","","0","0","0000-00-00 00:00:00","1","0","1");



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




