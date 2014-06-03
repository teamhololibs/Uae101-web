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
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=latin1 COMMENT='Tracking every activity of the admin';

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
INSERT INTO admin_user_activities VALUES("217","2014-05-30 12:48:20","1","login","2014-05-30 12:48:20");
INSERT INTO admin_user_activities VALUES("218","2014-05-30 13:46:14","1","login","2014-05-30 13:46:14");
INSERT INTO admin_user_activities VALUES("219","2014-05-31 00:31:41","1","login","2014-05-31 00:31:41");
INSERT INTO admin_user_activities VALUES("220","2014-05-31 11:53:55","1","login","2014-05-31 11:53:55");
INSERT INTO admin_user_activities VALUES("221","2014-05-31 13:13:18","1","login","2014-05-31 13:13:18");
INSERT INTO admin_user_activities VALUES("222","2014-05-31 17:38:43","1","login","2014-05-31 17:38:43");
INSERT INTO admin_user_activities VALUES("223","2014-06-03 01:31:42","1","login","2014-06-03 01:31:42");
INSERT INTO admin_user_activities VALUES("224","2014-06-03 09:41:15","1","login","2014-06-03 09:41:15");



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
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;

INSERT INTO authors VALUES("10","Community","","0","2014-05-31 14:02:31");
INSERT INTO authors VALUES("11","etsy","","0","2014-05-31 14:02:33");
INSERT INTO authors VALUES("12","Bugsense","","0","2014-05-31 14:02:33");
INSERT INTO authors VALUES("13","ManuelPeinado","","0","2014-05-31 14:02:35");
INSERT INTO authors VALUES("14","Genymotion","","0","2014-05-31 14:02:35");
INSERT INTO authors VALUES("15","Google","","0","2014-05-31 14:02:36");
INSERT INTO authors VALUES("16","Jimu Labs","","0","2014-05-31 14:02:36");
INSERT INTO authors VALUES("17","square","https://github.com/square","82592","2014-05-31 14:02:37");
INSERT INTO authors VALUES("18","Simple","","0","2014-05-31 14:02:39");
INSERT INTO authors VALUES("19","inAppSquared","","0","2014-05-31 14:02:39");
INSERT INTO authors VALUES("20","Szczepan Faber and friends","","0","2014-05-31 14:02:39");
INSERT INTO authors VALUES("21","chrisbanes","https://github.com/chrisbanes","227486","2014-05-31 14:05:25");
INSERT INTO authors VALUES("22","loopj","https://github.com/loopj","104009","2014-05-31 14:05:26");
INSERT INTO authors VALUES("23","JoanZapata","https://github.com/JoanZapata","675408","2014-05-31 14:05:27");
INSERT INTO authors VALUES("24","SimonVT","https://github.com/SimonVT","549365","2014-05-31 14:05:28");
INSERT INTO authors VALUES("25","jgilfelt","https://github.com/jgilfelt","175697","2014-05-31 14:05:29");
INSERT INTO authors VALUES("26","kikoso","https://github.com/kikoso","903097","2014-05-31 14:05:31");
INSERT INTO authors VALUES("27","inmite","https://github.com/inmite","3819616","2014-05-31 14:05:32");
INSERT INTO authors VALUES("28","romannurik","https://github.com/romannurik","100155","2014-05-31 14:05:33");
INSERT INTO authors VALUES("29","nostra13","https://github.com/nostra13","1223348","2014-05-31 14:05:34");
INSERT INTO authors VALUES("30","JakeWharton","https://github.com/JakeWharton","66577","2014-05-31 14:10:50");
INSERT INTO authors VALUES("31","anupcowkur","https://github.com/anupcowkur","1691740","2014-05-31 14:10:51");
INSERT INTO authors VALUES("32","tizionario","https://github.com/tizionario","2451183","2014-05-31 14:10:52");
INSERT INTO authors VALUES("33","lafosca","https://github.com/lafosca","3064345","2014-05-31 14:10:54");
INSERT INTO authors VALUES("34","weddingparty","https://github.com/weddingparty","5777037","2014-05-31 14:10:55");
INSERT INTO authors VALUES("35","umano","https://github.com/umano","4552937","2014-05-31 14:10:57");
INSERT INTO authors VALUES("36","idunnololz","https://github.com/idunnololz","3893565","2014-05-31 14:10:58");
INSERT INTO authors VALUES("37","ACRA","https://github.com/ACRA","2363625","2014-05-31 14:15:21");
INSERT INTO authors VALUES("38","roomorama","https://github.com/roomorama","53760","2014-05-31 14:15:25");
INSERT INTO authors VALUES("39","chrisjenx","https://github.com/chrisjenx","1167793","2014-05-31 14:15:26");
INSERT INTO authors VALUES("40","nadavfima","https://github.com/nadavfima","688836","2014-05-31 14:15:29");
INSERT INTO authors VALUES("41","keyboardsurfer","https://github.com/keyboardsurfer","336005","2014-05-31 14:15:30");
INSERT INTO authors VALUES("42","commonsguy","https://github.com/commonsguy","103772","2014-05-31 14:16:29");
INSERT INTO authors VALUES("43","MustafaFerhan","https://github.com/MustafaFerhan","1121700","2014-05-31 14:16:32");
INSERT INTO authors VALUES("44","PomepuyN","https://github.com/PomepuyN","371298","2014-05-31 14:16:33");
INSERT INTO authors VALUES("45","Startappz","https://github.com/Startappz","1978233","2014-05-31 14:16:34");
INSERT INTO authors VALUES("46","pedrovgs","https://github.com/pedrovgs","4030704","2014-05-31 14:16:36");
INSERT INTO authors VALUES("47","ribot","https://github.com/ribot","26924","2014-05-31 14:16:37");
INSERT INTO authors VALUES("48","greenrobot","https://github.com/greenrobot","242242","2014-05-31 14:20:38");
INSERT INTO authors VALUES("49","emilsjolander","https://github.com/emilsjolander","1525924","2014-05-31 14:20:39");
INSERT INTO authors VALUES("50","Comcast","https://github.com/Comcast","709212","2014-05-31 14:20:41");
INSERT INTO authors VALUES("51","bumptech","https://github.com/bumptech","423539","2014-05-31 14:20:42");
INSERT INTO authors VALUES("52","antonyt","https://github.com/antonyt","964952","2014-05-31 14:20:45");
INSERT INTO authors VALUES("53","koush","https://github.com/koush","73924","2014-05-31 14:20:46");
INSERT INTO authors VALUES("54","JodaOrg","https://github.com/JodaOrg","779257","2014-05-31 14:20:47");
INSERT INTO authors VALUES("55","flavioarfaria","https://github.com/flavioarfaria","1800351","2014-05-31 14:20:48");
INSERT INTO authors VALUES("56","nhaarman","https://github.com/nhaarman","3015152","2014-05-31 14:20:50");
INSERT INTO authors VALUES("57","nvanbenschoten","https://github.com/nvanbenschoten","5438456","2014-05-31 14:20:52");
INSERT INTO authors VALUES("58","flavienlaurent","https://github.com/flavienlaurent","4429434","2014-05-31 14:20:55");
INSERT INTO authors VALUES("59","RobotiumTech","https://github.com/RobotiumTech","6298503","2014-05-31 14:20:58");
INSERT INTO authors VALUES("60","vinc3m1","https://github.com/vinc3m1","498852","2014-05-31 14:21:00");
INSERT INTO authors VALUES("61","hoang8f","https://github.com/hoang8f","319726","2014-05-31 14:21:02");
INSERT INTO authors VALUES("62","tbouron","https://github.com/tbouron","2082759","2014-05-31 14:47:41");
INSERT INTO authors VALUES("63","RomainPiel","https://github.com/RomainPiel","464320","2014-05-31 15:26:17");
INSERT INTO authors VALUES("64","jfeinstein10","https://github.com/jfeinstein10","1269143","2014-05-31 15:26:43");
INSERT INTO authors VALUES("65","castorflex","https://github.com/castorflex","1364129","2014-05-31 15:26:44");
INSERT INTO authors VALUES("66","satyan","https://github.com/satyan","148153","2014-05-31 15:26:48");
INSERT INTO authors VALUES("67","JohnPersano","https://github.com/JohnPersano","3487327","2014-05-31 15:26:49");
INSERT INTO authors VALUES("68","jenzz","https://github.com/jenzz","1798455","2014-05-31 15:26:53");
INSERT INTO authors VALUES("69","stephanenicolas","https://github.com/stephanenicolas","1832925","2014-05-31 15:26:54");
INSERT INTO authors VALUES("70","grantland","https://github.com/grantland","277030","2014-05-31 15:29:50");
INSERT INTO authors VALUES("71","antonkrasov","https://github.com/antonkrasov","3696113","2014-05-31 15:29:51");
INSERT INTO authors VALUES("72","matshofman","https://github.com/matshofman","906405","2014-05-31 15:29:53");
INSERT INTO authors VALUES("73","throrin19","https://github.com/throrin19","1394778","2014-05-31 15:29:55");



DROP TABLE IF EXISTS authors1;

CREATE TABLE `authors1` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `github_author_id` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

INSERT INTO authors1 VALUES("1","Google","http://android.googlesource.com","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("2","Square Open Source","http://square.github.io/","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("3","emilsjolander","https://github.com/emilsjolander","1525924","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("4","bumptech","https://github.com/bumptech","423539","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("5","keyboardsurfer","https://github.com/keyboardsurfer","336005","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("6","loopj","https://github.com/loopj","104009","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("7","nvanbenschoten","https://github.com/nvanbenschoten","5438456","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("8","Lafosca","https://github.com/lafosca","3064345","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("9","Ribot","https://github.com/ribot","26924","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("10","nhaarman","https://github.com/nhaarman","3015152","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("11","romannurik","https://github.com/romannurik","100155","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("12","jgilfelt","https://github.com/jgilfelt","175697","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("13","satyan","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("14","commonsguy","https://github.com/commonsguy","103772","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("15","JakeWharton","https://github.com/JakeWharton","66577","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("16","chrisbanes","https://github.com/chrisbanes","227486","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("17","SimonVT","https://github.com/SimonVT","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("18","JohnPersano","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("19","castorflex","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("20","Inmite s.r.o.","https://github.com/inmite","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("21","anupcowkur","https://github.com/anupcowkur","1691740","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("22","Weddingparty","https://github.com/weddingparty","5777037","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("23","chrisjenx","https://github.com/chrisjenx","1167793","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("24","Etsy, Inc.","https://github.com/etsy","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("25","jfeinstein10","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("26","ManuelPeinado","https://github.com/ManuelPeinado","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("27","antonyt","https://github.com/antonyt","964952","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("28","MustafaFerhan","https://github.com/MustafaFerhan","1121700","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("29","RobotiumTech","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("30","Bugsense","https://www.bugsense.com/","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("31","JoanZapata","https://github.com/JoanZapata","675408","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("32","jimu Labs Inc.","http://jimulabs.com/","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("33","Genymotion","http://www.genymotion.com/","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("34","tizionario","https://github.com/tizionario","2451183","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("35","PomepuyN","https://github.com/PomepuyN","371298","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("36","Comcast","https://github.com/Comcast","709212","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("37","nadavfima","https://github.com/nadavfima","688836","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("38","ACRA","https://github.com/ACRA","2363625","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("39","koush","https://github.com/koush","73924","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("40","nostra13","https://github.com/nostra13","1223348","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("41","Joda.org","https://github.com/JodaOrg","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("42","Roomorama","https://github.com/roomorama","53760","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("43","vinc3m1","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("44","Umano","https://github.com/umano","4552937","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("45","Startappz","https://github.com/Startappz","1978233","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("46","hoang8f","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("47","greenrobot","https://github.com/greenrobot","242242","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("48","pedrovgs","https://github.com/pedrovgs","4030704","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("49","idunnololz","https://github.com/idunnololz","3893565","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("50","tbouron","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("51","flavienlaurent","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("52","RomainPiel","","0","0000-00-00 00:00:00");
INSERT INTO authors1 VALUES("54","kikoso","https://github.com/kikoso","903097","2014-05-29 23:49:29");
INSERT INTO authors1 VALUES("55","Square","https://github.com/square","82592","2014-05-29 23:50:34");
INSERT INTO authors1 VALUES("56","SimonTV","https://github.com/SimonVT","549365","2014-05-29 23:50:35");
INSERT INTO authors1 VALUES("57","inmite","https://github.com/inmite","3819616","2014-05-29 23:50:35");
INSERT INTO authors1 VALUES("58","etsy","","0","2014-05-29 23:50:35");
INSERT INTO authors1 VALUES("59","Jimu Labs","","0","2014-05-29 23:50:36");
INSERT INTO authors1 VALUES("60","Community","","0","2014-05-29 23:50:36");
INSERT INTO authors1 VALUES("65","flavioarfaria","https://github.com/flavioarfaria","1800351","2014-05-29 23:50:37");
INSERT INTO authors1 VALUES("67","JodaOrg1","","0","2014-05-30 00:11:15");
INSERT INTO authors1 VALUES("68","JodaOrg","https://github.com/JodaOrg","779257","2014-05-30 00:59:53");
INSERT INTO authors1 VALUES("69","Community","","0","2014-05-31 13:25:33");
INSERT INTO authors1 VALUES("70","etsy","","0","2014-05-31 13:25:35");
INSERT INTO authors1 VALUES("71","Bugsense","","0","2014-05-31 13:25:35");
INSERT INTO authors1 VALUES("72","ManuelPeinado","","0","2014-05-31 13:25:37");
INSERT INTO authors1 VALUES("73","Genymotion","","0","2014-05-31 13:25:37");
INSERT INTO authors1 VALUES("74","google","","0","2014-05-31 13:25:38");
INSERT INTO authors1 VALUES("75","Jimu Labs","","0","2014-05-31 13:25:38");
INSERT INTO authors1 VALUES("76","Square","","0","2014-05-31 13:25:39");
INSERT INTO authors1 VALUES("77","google","","0","2014-05-31 13:25:40");
INSERT INTO authors1 VALUES("78","google","","0","2014-05-31 13:25:40");
INSERT INTO authors1 VALUES("79","inAppSquared","","0","2014-05-31 13:25:41");
INSERT INTO authors1 VALUES("80","Szczepan Faber and friends","","0","2014-05-31 13:25:41");
INSERT INTO authors1 VALUES("81","Google","","0","2014-05-31 13:25:41");
INSERT INTO authors1 VALUES("82","Community","","0","2014-05-31 13:31:05");
INSERT INTO authors1 VALUES("83","etsy","","0","2014-05-31 13:31:07");
INSERT INTO authors1 VALUES("84","Bugsense","","0","2014-05-31 13:31:07");
INSERT INTO authors1 VALUES("85","ManuelPeinado","","0","2014-05-31 13:31:09");
INSERT INTO authors1 VALUES("86","Genymotion","","0","2014-05-31 13:31:10");
INSERT INTO authors1 VALUES("87","google","","0","2014-05-31 13:31:10");
INSERT INTO authors1 VALUES("88","Jimu Labs","","0","2014-05-31 13:31:10");
INSERT INTO authors1 VALUES("89","Square","","0","2014-05-31 13:31:11");
INSERT INTO authors1 VALUES("90","google","","0","2014-05-31 13:31:12");
INSERT INTO authors1 VALUES("91","google","","0","2014-05-31 13:31:12");
INSERT INTO authors1 VALUES("92","inAppSquared","","0","2014-05-31 13:31:13");
INSERT INTO authors1 VALUES("93","Szczepan Faber and friends","","0","2014-05-31 13:31:13");
INSERT INTO authors1 VALUES("94","Google","","0","2014-05-31 13:31:13");



DROP TABLE IF EXISTS categories;

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'ID of the parent category (found in same table)',
  PRIMARY KEY (`cat_id`),
  KEY `active` (`active`,`name`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

INSERT INTO categories VALUES("10","2014-05-31 14:04:01","1","PullToRefresh","0");
INSERT INTO categories VALUES("11","2014-05-31 14:04:01","1","Development Tools","0");
INSERT INTO categories VALUES("12","2014-05-31 14:04:01","1","Networking","0");
INSERT INTO categories VALUES("13","2014-05-31 14:04:01","1","Icons","0");
INSERT INTO categories VALUES("14","2014-05-31 14:04:01","1","Navigation Drawer","0");
INSERT INTO categories VALUES("15","2014-05-31 14:04:01","1","Databases","0");
INSERT INTO categories VALUES("16","2014-05-31 14:04:01","1","ImageView","0");
INSERT INTO categories VALUES("17","2014-05-31 14:04:01","1","dialogs","0");
INSERT INTO categories VALUES("18","2014-05-31 14:04:01","1","Listview","0");
INSERT INTO categories VALUES("19","2014-05-31 14:04:02","1","Image Loading","0");
INSERT INTO categories VALUES("20","2014-05-31 14:04:02","1","ViewPager","0");
INSERT INTO categories VALUES("21","2014-05-31 14:04:02","1","Wheel Menu","0");
INSERT INTO categories VALUES("22","2014-05-31 14:04:02","1","TextView","0");
INSERT INTO categories VALUES("23","2014-05-31 14:04:03","1","Bug Tracking","0");
INSERT INTO categories VALUES("24","2014-05-31 14:04:03","1","Dependancy Injection","0");
INSERT INTO categories VALUES("25","2014-05-31 14:04:03","1","Calender","0");
INSERT INTO categories VALUES("26","2014-05-31 14:04:03","1","Fonts","0");
INSERT INTO categories VALUES("27","2014-05-31 14:04:03","1","CardsUI","0");
INSERT INTO categories VALUES("28","2014-05-31 14:04:03","1","toasts","0");
INSERT INTO categories VALUES("29","2014-05-31 14:04:04","1","Debugging","0");
INSERT INTO categories VALUES("30","2014-05-31 14:04:04","1","Feedback","0");
INSERT INTO categories VALUES("31","2014-05-31 14:04:04","1","Event Bus","0");
INSERT INTO categories VALUES("32","2014-05-31 14:04:04","1","ActionBar","0");
INSERT INTO categories VALUES("33","2014-05-31 14:04:04","1","FlipView","0");
INSERT INTO categories VALUES("34","2014-05-31 14:04:04","1","Architecture","0");
INSERT INTO categories VALUES("35","2014-05-31 14:04:05","1","JSON","0");
INSERT INTO categories VALUES("36","2014-05-31 14:04:06","1","AnimatedViews","0");
INSERT INTO categories VALUES("37","2014-05-31 14:04:06","1","Http Clients","0");
INSERT INTO categories VALUES("38","2014-05-31 14:04:06","1","RadioButton","0");
INSERT INTO categories VALUES("39","2014-05-31 14:04:06","1","Sensors","0");
INSERT INTO categories VALUES("40","2014-05-31 14:04:07","1","ProgressBar","0");
INSERT INTO categories VALUES("41","2014-05-31 14:04:08","1","Video Streaming","0");
INSERT INTO categories VALUES("42","2014-05-31 14:04:08","1","Social Networks","0");
INSERT INTO categories VALUES("43","2014-05-31 14:04:08","1","XML Serialization","0");
INSERT INTO categories VALUES("44","2014-05-31 14:04:08","1","Demoes","0");
INSERT INTO categories VALUES("45","2014-05-31 14:04:08","1","Testing","0");
INSERT INTO categories VALUES("46","2014-05-31 14:04:08","1","RSS Reader","0");
INSERT INTO categories VALUES("47","2014-05-31 14:04:08","1","Validation","0");
INSERT INTO categories VALUES("48","2014-05-31 14:04:09","1","In-App Billing","0");



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
INSERT INTO configs VALUES("4","0000-00-00 00:00:00","2014-05-31 14:50:18","GITHUB_API_CALL_LIMIT","20","","GITHUB_API_CALL_LIMIT");



DROP TABLE IF EXISTS res_cat;

CREATE TABLE `res_cat` (
  `res_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

INSERT INTO res_cat VALUES("10","10","10","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("11","11","11","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("12","12","12","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("13","13","13","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("14","14","14","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("15","15","15","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("16","16","16","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("17","17","17","2014-05-31 14:04:01");
INSERT INTO res_cat VALUES("18","18","18","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("19","19","19","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("20","20","20","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("21","21","21","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("22","22","11","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("23","23","16","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("24","24","22","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("25","25","13","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("26","26","14","2014-05-31 14:04:02");
INSERT INTO res_cat VALUES("27","27","18","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("28","28","18","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("29","29","23","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("30","30","23","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("31","31","24","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("32","32","24","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("33","33","25","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("34","34","26","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("35","35","27","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("36","36","28","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("37","37","18","2014-05-31 14:04:03");
INSERT INTO res_cat VALUES("38","38","24","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("39","39","29","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("40","40","30","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("41","41","14","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("42","42","14","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("43","43","18","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("44","44","31","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("45","45","32","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("46","46","33","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("47","47","34","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("48","48","34","2014-05-31 14:04:04");
INSERT INTO res_cat VALUES("49","49","11","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("50","50","19","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("51","51","15","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("52","52","35","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("53","53","20","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("54","54","12","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("55","55","25","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("56","56","16","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("57","57","18","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("58","58","11","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("59","59","34","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("60","60","16","2014-05-31 14:04:05");
INSERT INTO res_cat VALUES("61","61","15","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("62","62","31","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("63","63","36","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("64","64","16","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("65","65","18","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("66","66","37","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("67","67","11","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("68","68","16","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("69","69","11","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("70","70","38","2014-05-31 14:04:06");
INSERT INTO res_cat VALUES("71","71","39","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("72","72","22","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("73","73","14","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("74","74","40","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("75","75","15","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("76","76","18","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("77","77","15","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("78","78","28","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("79","79","25","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("80","80","20","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("81","81","37","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("82","82","18","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("83","83","12","2014-05-31 14:04:07");
INSERT INTO res_cat VALUES("84","84","41","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("85","85","22","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("86","86","42","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("87","87","43","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("88","88","44","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("89","89","45","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("90","90","46","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("91","91","47","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("92","92","47","2014-05-31 14:04:08");
INSERT INTO res_cat VALUES("93","93","48","2014-05-31 14:04:09");



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
  `github_resource_id` int(11) DEFAULT '0',
  `github_stargazers` int(11) DEFAULT '0',
  `github_forks` int(11) DEFAULT '0',
  `github_updated_at` datetime NOT NULL,
  `github_api_last_checked` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `author_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`),
  KEY `active` (`active`,`name`,`is_approved`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

INSERT INTO resources VALUES("10","2014-05-31 15:31:27","1","ActionBar-PullToRefresh","DEPRECATED","https://github.com/chrisbanes/ActionBar-PullToRefresh","","1","10480910","2443","753","2014-05-31 06:11:30","2014-05-31 15:31:27","21","0","1");
INSERT INTO resources VALUES("11","2014-05-31 14:04:01","1","Android Asset Studio","Excellent community tools to generate custom graphics for Actionbars , UI controls and icons.","http://android-ui-utils.googlecode.com/hg/asset-studio/dist/index.html?utm_source=twitterfeed&utm_medium=twitter","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","10","0","1");
INSERT INTO resources VALUES("12","2014-05-31 15:31:28","1","android-async-http","An Asynchronous HTTP Library for Android","https://github.com/loopj/android-async-http","","1","1388245","3633","1783","2014-05-31 05:25:44","2014-05-31 15:31:28","22","0","1");
INSERT INTO resources VALUES("13","2014-05-31 15:31:29","1","android-iconify","Integration of FontAwesome for Android","https://github.com/JoanZapata/android-iconify","","1","10641697","483","52","2014-05-29 23:41:50","2014-05-31 15:31:29","23","0","1");
INSERT INTO resources VALUES("14","2014-05-31 15:31:31","1","android-menudrawer","A slide-out menu implementation, which allows users to navigate between views in your app.","https://github.com/SimonVT/android-menudrawer","","1","5639802","1834","820","2014-05-30 22:36:33","2014-05-31 15:31:31","24","0","1");
INSERT INTO resources VALUES("15","2014-05-31 15:31:32","1","android-sqlite-asset-helper","An Android helper class to manage database creation and version management using an application\'s raw asset files","https://github.com/jgilfelt/android-sqlite-asset-helper","","1","2927004","676","169","2014-05-30 07:58:26","2014-05-31 15:31:32","25","0","1");
INSERT INTO resources VALUES("16","2014-05-31 15:31:33","1","android-stackblur","Android StackBlur is a library that can perform a blurry effect on a Bitmap based on a gradient or radius, and return the result. The library is based on the code of Mario Klingemann.","https://github.com/kikoso/android-stackblur","","1","12136636","672","167","2014-05-31 10:28:51","2014-05-31 15:31:33","26","0","1");
INSERT INTO resources VALUES("17","2014-05-31 15:31:34","1","android-styled-dialogs","A simple library for styling Android dialogs in the Holo theme. It also removes boilerplate code for displaying simple dialogs.","https://github.com/inmite/android-styled-dialogs","","1","10281119","823","197","2014-05-30 19:32:47","2014-05-31 15:31:34","27","0","1");
INSERT INTO resources VALUES("18","2014-05-31 15:31:35","1","Android-SwipeToDismiss","Android swipe-to-dismiss mini-library and sample code","https://github.com/romannurik/Android-SwipeToDismiss","","1","12141504","484","136","2014-05-29 13:28:18","2014-05-31 15:31:35","28","0","1");
INSERT INTO resources VALUES("19","2014-05-31 15:31:37","1","Android-Universal-Image-Loader","Powerful and flexible library for loading, caching and displaying images on Android.","https://github.com/nostra13/Android-Universal-Image-Loader","","1","2862290","4738","2227","2014-05-31 05:25:54","2014-05-31 15:31:37","29","0","1");
INSERT INTO resources VALUES("20","2014-05-31 15:31:38","1","Android-ViewPagerIndicator","Paging indicator widgets compatible with the ViewPager from the Android Support Library and ActionBarSherlock. Originally based on Patrik Åkerfeldt\'s ViewFlow.","https://github.com/JakeWharton/Android-ViewPagerIndicator","","1","2155793","3685","2036","2014-05-31 05:25:58","2014-05-31 15:31:38","30","0","1");
INSERT INTO resources VALUES("21","2014-05-31 15:31:39","1","Android-Wheel-Menu","Simple and easy to use circular menu widget for Android.","https://github.com/anupcowkur/Android-Wheel-Menu","","1","8177857","165","56","2014-05-30 14:42:27","2014-05-31 15:31:39","31","0","1");
INSERT INTO resources VALUES("22","2014-05-31 15:31:40","1","AndroidDrawableFactory","A Java Application to create appropriate Drawable resources for your Android application","https://github.com/tizionario/AndroidDrawableFactory","","1","15845431","223","34","2014-05-25 02:20:07","2014-05-31 15:31:40","32","0","1");
INSERT INTO resources VALUES("23","2014-05-31 15:31:42","1","AndroidFaceCropper","Android bitmap Face Cropper","https://github.com/lafosca/AndroidFaceCropper","","1","18222014","148","18","2014-05-30 09:44:23","2014-05-31 15:31:42","33","0","1");
INSERT INTO resources VALUES("24","2014-05-31 15:31:43","1","AndroidFloatLabel","Float Label Edit Texts for Android","https://github.com/weddingparty/AndroidFloatLabel","","1","15501185","267","22","2014-05-30 21:05:27","2014-05-31 15:31:43","34","0","1");
INSERT INTO resources VALUES("25","2014-05-31 15:31:44","1","androidicons-adt-template","Android Studio / Eclipse ADT template for androidicons.com resources","https://github.com/jgilfelt/androidicons-adt-template","","1","18417563","154","4","2014-05-30 14:08:59","2014-05-31 15:31:44","25","0","1");
INSERT INTO resources VALUES("26","2014-05-31 15:31:45","1","AndroidSlidingUpPanel","Android Sliding Up Panel Demo","https://github.com/umano/AndroidSlidingUpPanel","","1","10410764","1369","428","2014-05-31 09:43:10","2014-05-31 15:31:45","35","0","1");
INSERT INTO resources VALUES("27","2014-05-31 14:04:03","1","AndroidStaggeredGrid","An Android staggered grid view which supports multiple columns with rows of varying sizes.","http://www.androidviews.net/2014/01/androidstaggeredgrid-view","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","11","0","1");
INSERT INTO resources VALUES("28","2014-05-31 15:31:47","1","AnimatedExpandableListView","An extendable, flexible ExpandableListView widget that supports animations.","https://github.com/idunnololz/AnimatedExpandableListView","","1","18320484","61","16","2014-05-29 23:55:33","2014-05-31 15:31:47","36","0","1");
INSERT INTO resources VALUES("29","2014-05-31 15:31:48","1","acra","Application Crash Reports for Android","https://github.com/ACRA/acra","","1","5890835","1295","354","2014-05-30 06:38:43","2014-05-31 15:31:48","37","0","1");
INSERT INTO resources VALUES("30","2014-05-31 14:04:03","1","Bugsense","BugSense is the leading developer tool to help you manage the Android fragmentation.\\n\\nLightweight\\nProguard integration\\nACRA\\nCapture LogCat\\nMaven / Gradle","http://www.bugsense.com/docs/android","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","12","0","1");
INSERT INTO resources VALUES("31","2014-05-31 15:31:49","1","butterknife","View \"injection\" library for Android.","https://github.com/JakeWharton/butterknife","","1","8575137","1401","238","2014-05-31 04:26:47","2014-05-31 15:31:49","30","0","1");
INSERT INTO resources VALUES("32","2014-05-31 15:31:50","1","android-butterknife-zelezny","Android Studio plug-in for generating ButterKnife injections from selected layout XML.","https://github.com/inmite/android-butterknife-zelezny","","1","15397085","314","25","2014-05-30 07:52:27","2014-05-31 15:31:50","27","0","1");
INSERT INTO resources VALUES("33","2014-05-31 17:38:49","1","Caldroid","A better calendar for Android","https://github.com/roomorama/Caldroid","","1","8641067","317","131","2014-05-29 23:51:15","2014-05-31 17:38:49","38","0","1");
INSERT INTO resources VALUES("34","2014-05-31 17:38:50","1","Calligraphy","Custom fonts in Android the easy way...","https://github.com/chrisjenx/Calligraphy","","1","15328210","587","46","2014-05-31 10:20:28","2014-05-31 17:38:50","39","0","1");
INSERT INTO resources VALUES("35","2014-05-31 17:38:52","1","cardsui-for-android","Fork of the CardsUI library with more features, including the popular Google Now & Google Play cards views, and an additional MVC implementation","https://github.com/nadavfima/cardsui-for-android","","1","16466386","115","57","2014-05-30 17:12:25","2014-05-31 17:38:52","40","0","1");
INSERT INTO resources VALUES("36","2014-05-31 17:38:53","1","Crouton","Context sensitive notifications for Android","https://github.com/keyboardsurfer/Crouton","","1","5284389","1578","404","2014-05-30 11:53:34","2014-05-31 17:38:53","41","0","1");
INSERT INTO resources VALUES("37","2014-05-31 17:38:54","1","cwac-endless","CommonsWare Android Components: EndlessAdapter","https://github.com/commonsguy/cwac-endless","","1","256245","701","242","2014-05-28 03:48:01","2014-05-31 17:38:54","42","0","1");
INSERT INTO resources VALUES("38","2014-05-31 17:38:55","1","dagger","A fast dependency injector for Android and Java.","https://github.com/square/dagger","","1","5279091","1886","272","2014-05-30 09:21:51","2014-05-31 17:38:55","17","0","1");
INSERT INTO resources VALUES("39","2014-05-31 17:38:56","1","DebugLog","Create a simple and more understandable Android logs.","https://github.com/MustafaFerhan/DebugLog","","1","17419105","146","18","2014-05-31 07:38:48","2014-05-31 17:38:56","43","0","1");
INSERT INTO resources VALUES("40","2014-05-31 17:38:58","1","discreet-app-rate","A lightweight non intrusive app rate reminder for Android","https://github.com/PomepuyN/discreet-app-rate","","1","17515267","331","22","2014-05-30 20:42:28","2014-05-31 17:38:58","44","0","1");
INSERT INTO resources VALUES("41","2014-05-31 17:38:59","1","DobSliding","","https://github.com/Startappz/DobSliding","","1","17833053","104","7","2014-05-30 14:24:41","2014-05-31 17:38:59","45","0","1");
INSERT INTO resources VALUES("42","2014-05-31 17:39:00","1","DraggablePanel","Android library used to create an awesome Android UI based on a draggable element similar to the last YouTube graphic component.","https://github.com/pedrovgs/DraggablePanel","","1","18727860","655","68","2014-05-30 13:52:40","2014-05-31 17:39:00","46","0","1");
INSERT INTO resources VALUES("43","2014-05-31 17:39:01","1","easy-adapter","Easy Adapters library for Android","https://github.com/ribot/easy-adapter","","1","16842589","141","7","2014-05-30 22:11:21","2014-05-31 17:39:01","47","0","1");
INSERT INTO resources VALUES("44","2014-05-31 17:39:03","1","EventBus","Android optimized event bus that simplifies communication between Activities, Fragments, Threads, Services, etc. Less code, better quality.","https://github.com/greenrobot/EventBus","","1","5070389","1520","360","2014-05-31 10:14:20","2014-05-31 17:39:03","48","0","1");
INSERT INTO resources VALUES("45","2014-05-31 14:04:04","1","Fading ActionBar","Android library implementing a fading effect for the action bar, similar to the one found in the Play Music app","http://www.androidviews.net/2013/05/fading-actionbar","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","13","0","1");
INSERT INTO resources VALUES("46","2014-05-31 17:39:04","1","android-FlipView","A small, easy to use android library for implementing flipping between views as seen in the popular Flipboard application","https://github.com/emilsjolander/android-FlipView","","1","9119163","313","101","2014-05-29 23:41:16","2014-05-31 17:39:04","49","0","1");
INSERT INTO resources VALUES("47","2014-05-31 17:39:05","1","flow","A small library that helps with describing an app as a collection of moderately independent screens.","https://github.com/square/flow","","1","12796207","326","26","2014-05-30 10:27:54","2014-05-31 17:39:05","17","0","1");
INSERT INTO resources VALUES("48","2014-05-31 17:39:06","1","FreeFlow","A layout engine for Android that decouples layouts from the View containers that manage scrolling and view recycling. FreeFlow makes it really easy to create custom layouts and beautiful transition animations as data and layouts change","https://github.com/Comcast/FreeFlow","","1","13421516","1222","160","2014-05-31 10:43:55","2014-05-31 17:39:06","50","0","1");
INSERT INTO resources VALUES("49","2014-05-31 14:04:05","1","Genymotion","Genymotion is the next generation of the AndroVM open source project, already trusted by 900,000 developers.\\n\\nIt’s even easier to use and has lots more functionalitie","http://www.genymotion.com","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","14","0","1");
INSERT INTO resources VALUES("50","2014-05-31 17:39:08","1","glide","An image loading and caching library for Android focused on smooth scrolling","https://github.com/bumptech/glide","","1","11267509","350","53","2014-05-30 21:03:33","2014-05-31 17:39:08","51","0","1");
INSERT INTO resources VALUES("51","2014-05-31 17:39:09","1","greenDAO","greenDAO is a light & fast ORM solution for Android that maps objects to SQLite databases.","https://github.com/greenrobot/greenDAO","","1","2626751","1161","457","2014-05-31 10:09:52","2014-05-31 17:39:09","48","0","1");
INSERT INTO resources VALUES("52","2014-05-31 14:04:05","1","gson","Gson is a Java library that can be used to convert Java Objects into their JSON representation. It can also be used to convert a JSON string to an equivalent Java object. G","http://code.google.com/p/google-gson","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","15","0","1");
INSERT INTO resources VALUES("53","2014-05-31 17:39:10","1","InfiniteViewPager","Augment Android\'s ViewPager with wrap-around functionality.","https://github.com/antonyt/InfiniteViewPager","","1","3688003","109","51","2014-05-30 10:53:19","2014-05-31 17:39:10","52","0","1");
INSERT INTO resources VALUES("54","2014-05-31 17:39:11","1","ion","Android Asynchronous Networking and Image Loading","https://github.com/koush/ion","","1","10214538","1656","251","2014-05-31 05:06:46","2014-05-31 17:39:11","53","0","1");
INSERT INTO resources VALUES("55","2014-05-31 17:39:12","1","joda-time","Joda-Time is the widely used replacement for the Java date and time classes.","https://github.com/JodaOrg/joda-time","","1","1756350","778","134","2014-05-29 22:04:05","2014-05-31 17:39:12","54","0","1");
INSERT INTO resources VALUES("56","2014-05-31 14:20:48","1","KenBurnsView","Android ImageViews animated by Ken Burns Effect","https://github.com/flavioarfaria/KenBurnsView","","1","17890722","240","26","2014-05-29 03:18:48","2014-05-31 14:20:48","55","0","1");
INSERT INTO resources VALUES("57","2014-05-31 14:20:50","1","ListViewAnimations","An Android library which allows developers to easily add animations to ListView items","https://github.com/nhaarman/ListViewAnimations","","1","8877512","1626","596","2014-05-31 06:27:14","2014-05-31 14:20:50","56","0","1");
INSERT INTO resources VALUES("58","2014-05-31 14:04:05","1","Mirror","Mirror: Live previews of Android layouts\\n\\n\\nCode layouts in Eclipse or Android Studio*\\nPreview on real devices with Mirror, instantly\\nSave time, write better code","http://jimulabs.com","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","16","0","1");
INSERT INTO resources VALUES("59","2014-05-31 14:20:51","1","mortar","A simple library that makes it easy to pair thin views with dedicated controllers, isolated from most of the vagaries of the Activity life cycle.","https://github.com/square/mortar","","1","14247776","361","16","2014-05-29 20:40:34","2014-05-31 14:20:51","17","0","1");
INSERT INTO resources VALUES("60","2014-05-31 14:20:52","1","motion","An Android library allowing images to exhibit a parallax effect","https://github.com/nvanbenschoten/motion","","1","18415532","325","21","2014-05-30 08:52:07","2014-05-31 14:20:52","57","0","1");
INSERT INTO resources VALUES("61","2014-05-31 14:04:06","1","OrmLite","Object Relational Mapping Lite (ORM Lite) provides some lightweight functionality for persisting Java objects to SQL databases while avoiding the complexity and overhead of more standard ORM packages.","http://ormlite.com/sqlite_java_android_orm.shtml","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","0","0","1");
INSERT INTO resources VALUES("62","2014-05-31 14:20:53","1","otto","An enhanced Guava-based event bus with emphasis on Android support.","https://github.com/square/otto","","1","4812336","1429","286","2014-05-30 06:36:56","2014-05-31 14:20:53","17","0","1");
INSERT INTO resources VALUES("63","2014-05-31 14:20:55","1","PanningView","PanningView is a library which implements the animated background in the now playing screen of the Play Music app.","https://github.com/flavienlaurent/PanningView","","1","11900505","117","34","2014-05-30 13:39:42","2014-05-31 14:20:55","58","0","1");
INSERT INTO resources VALUES("64","2014-05-31 14:20:56","1","PhotoView","Implementation of ImageView for Android that supports zooming, by various touch gestures.","https://github.com/chrisbanes/PhotoView","","1","5084750","1828","740","2014-05-30 19:01:59","2014-05-31 14:20:56","21","0","1");
INSERT INTO resources VALUES("65","2014-05-31 14:20:57","1","poppyview","Android library implementing a poppy view on scroll, similar to the one found in the Google Plus app","https://github.com/flavienlaurent/poppyview","","1","10317164","187","50","2014-05-30 14:51:17","2014-05-31 14:20:57","58","0","1");
INSERT INTO resources VALUES("66","2014-05-31 14:04:06","1","Retrofit","Type-safe REST client for Android and Java.","http://square.github.io/retrofit","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","17","0","1");
INSERT INTO resources VALUES("67","2014-05-31 14:20:58","1","robotium","Like Selenium, but for Android","https://github.com/RobotiumTech/robotium","","1","416272","694","344","2014-05-28 03:48:08","2014-05-31 14:20:58","59","0","1");
INSERT INTO resources VALUES("68","2014-05-31 14:21:00","1","RoundedImageView","a fast ImageView that supports rounded corners and ovals or circles","https://github.com/vinc3m1/RoundedImageView","","1","8347864","569","219","2014-05-30 14:32:58","2014-05-31 14:21:00","60","0","1");
INSERT INTO resources VALUES("69","2014-05-31 14:21:01","1","scalpel","A surgical debugging tool to uncover the layers under your app.","https://github.com/JakeWharton/scalpel","","1","15680192","736","60","2014-05-28 20:12:39","2014-05-31 14:21:01","30","0","1");
INSERT INTO resources VALUES("70","2014-05-31 14:21:02","1","android-segmented-control","ios7 UISegmentedControl for android","https://github.com/hoang8f/android-segmented-control","","1","16587824","154","24","2014-05-30 13:14:24","2014-05-31 14:21:02","61","0","1");
INSERT INTO resources VALUES("71","2014-05-31 14:47:41","1","ShakeDetector","This library provides a easy way to detect a shake movement using the build-in accelerometer and fire a callback on the UI thread every times it happens.","https://github.com/tbouron/ShakeDetector","","1","17939561","55","6","2014-05-19 05:55:24","2014-05-31 14:47:41","62","0","1");
INSERT INTO resources VALUES("72","2014-05-31 15:26:17","1","Shimmer-android","An Android TextView with a shimmering effect","https://github.com/RomainPiel/Shimmer-android","","1","17485132","459","59","2014-05-30 15:16:26","2014-05-31 15:26:17","63","0","1");
INSERT INTO resources VALUES("73","2014-05-31 15:26:43","1","SlidingMenu","An Android library that allows you to easily create applications with slide-in menus. You may use it in your Android apps provided that you cite this project and include the license in your app. Thanks!","https://github.com/jfeinstein10/SlidingMenu","","1","4839957","5495","3201","2014-05-31 11:08:31","2014-05-31 15:26:43","64","0","1");
INSERT INTO resources VALUES("74","2014-05-31 15:26:44","1","SmoothProgressBar","A small Android library allowing you to have a smooth and customizable horizontal indeterminate ProgressBar","https://github.com/castorflex/SmoothProgressBar","","1","14758329","874","272","2014-05-30 13:29:49","2014-05-31 15:26:44","65","0","1");
INSERT INTO resources VALUES("75","2014-05-31 15:26:45","1","sprinkles","Sprinkles is a boiler-plate-reduction-library for dealing with databases in android applications","https://github.com/emilsjolander/sprinkles","","1","13521187","478","43","2014-05-29 23:53:33","2014-05-31 15:26:45","49","0","1");
INSERT INTO resources VALUES("76","2014-05-31 15:26:47","1","StickyListHeaders","An android library for section headers that stick to the top","https://github.com/emilsjolander/StickyListHeaders","","1","3688678","1514","502","2014-05-30 16:12:43","2014-05-31 15:26:47","49","0","1");
INSERT INTO resources VALUES("77","2014-05-31 15:26:48","1","sugar","Insanely easy way to work with Android Database.","https://github.com/satyan/sugar","","1","2197202","311","65","2014-05-29 06:16:58","2014-05-31 15:26:48","66","0","1");
INSERT INTO resources VALUES("78","2014-05-31 15:26:49","1","SuperToasts","A library that extends the Android toast framework.","https://github.com/JohnPersano/SuperToasts","","1","10444562","613","123","2014-05-30 18:16:56","2014-05-31 15:26:49","67","0","1");
INSERT INTO resources VALUES("79","2014-05-31 15:26:50","1","android-times-square","Standalone Android widget for picking a single date from a calendar view.","https://github.com/square/android-times-square","","1","7923123","1070","374","2014-05-31 05:20:42","2014-05-31 15:26:50","17","0","1");
INSERT INTO resources VALUES("80","2014-05-31 15:26:52","1","JazzyViewPager","An easy to use ViewPager that adds an awesome set of custom swiping animations. Just change your ViewPagers to JazzyViewPagers, two more steps, and you\'re good to go!","https://github.com/jfeinstein10/JazzyViewPager","","1","7952078","792","350","2014-05-29 16:00:04","2014-05-31 15:26:52","64","0","1");
INSERT INTO resources VALUES("81","2014-05-31 14:04:07","1","Volley","Volley is a library that makes networking for Android apps easier and most importantly, faster. \\nhttps://developers.google.com/events/io/sessions/325304728","http://android.googlesource.com/platform/frameworks/volley","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","15","0","1");
INSERT INTO resources VALUES("82","2014-05-31 15:26:53","1","Android-MultiStateListView","A simple Android ListView that lets you define three states: Loading, Empty & Error","https://github.com/jenzz/Android-MultiStateListView","","1","14246845","10","5","2014-05-28 18:01:37","2014-05-31 15:26:53","68","0","1");
INSERT INTO resources VALUES("83","2014-05-31 15:26:54","1","robospice","Repo of the Open Source Android library : RoboSpice. RoboSpice is a modular android library that makes writing asynchronous long running tasks easy. It is specialized in network requests, supports caching and offers REST requests out-of-the box using extension modules.","https://github.com/stephanenicolas/robospice","","1","5872657","1494","327","2014-05-30 22:13:09","2014-05-31 15:26:54","69","0","1");
INSERT INTO resources VALUES("84","2014-05-31 14:04:08","1","YouTube Android Player","The YouTube Android Player API enables you to incorporate video playback functionality into your Android applications.","http://developers.google.com/youtube/android/player","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","15","0","1");
INSERT INTO resources VALUES("85","2014-05-31 15:29:50","1","android-autofittextview","A TextView that automatically resizes text to fit perfectly within its bounds.","https://github.com/grantland/android-autofittextview","","1","1364139","262","60","2014-05-30 23:29:08","2014-05-31 15:29:50","70","0","1");
INSERT INTO resources VALUES("86","2014-05-31 15:29:51","1","AndroidSocialNetworks","Library for easy work with Facebook, Twitter, LinkedIn and Google on Android","https://github.com/antonkrasov/AndroidSocialNetworks","","1","19025100","460","43","2014-05-31 09:31:55","2014-05-31 15:29:51","71","0","1");
INSERT INTO resources VALUES("87","2014-05-31 14:04:08","1","Simple","Simple is a high performance XML serialization and configuration framework for Java. Its goal is to provide an XML framework that enables rapid development of XML configuration and communication syste","http://simple.sourceforge.net","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","18","0","1");
INSERT INTO resources VALUES("88","2014-05-31 14:04:08","1","DevAppsDirect - Demo Market","Developer Apps Direct is a large and growing collection of library demos.","http://play.google.com/store/apps/details?id=com.inappsquared.devappsdirect","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","19","0","1");
INSERT INTO resources VALUES("89","2014-05-31 14:04:08","1","mockito","Mockito lets you write beautiful tests with clean & simple API","http://code.google.com/p/mockito","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","20","0","1");
INSERT INTO resources VALUES("90","2014-05-31 15:29:53","1","Android-RSS-Reader-Library","A RSS reader library to fetch a RSS feed from the web and parse it to workable objects","https://github.com/matshofman/Android-RSS-Reader-Library","","1","2768092","145","54","2014-05-30 16:19:12","2014-05-31 15:29:53","72","0","1");
INSERT INTO resources VALUES("91","2014-05-31 15:29:54","1","android-validation-komensky","A simple library for validating user input in forms using annotations.","https://github.com/inmite/android-validation-komensky","","1","13663078","253","24","2014-05-30 11:46:35","2014-05-31 15:29:54","27","0","1");
INSERT INTO resources VALUES("92","2014-05-31 15:29:55","1","Android-Validator","Form Validator Library for Android","https://github.com/throrin19/Android-Validator","","1","4794215","306","84","2014-05-29 05:43:21","2014-05-31 15:29:55","73","0","1");
INSERT INTO resources VALUES("93","2014-05-31 14:04:09","1","Google Play In-app Billing","In-app Billing is a Google Play service that lets you sell digital content from inside your applications","http://developer.android.com/google/play/billing/index.html","","0","0","0","0","0000-00-00 00:00:00","0000-00-00 00:00:00","15","0","1");



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




