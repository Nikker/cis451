CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_online` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gold` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `user_profile` (
  `user_id` int(11) NOT NULL,
  `content` text,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_profile_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_friend` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `friend_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`friend_id`),
  KEY `friend_user_ref2` (`friend_id`),
  CONSTRAINT `friend_user_ref1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `friend_user_ref2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_signature` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `sig_num` int(11) NOT NULL AUTO_INCREMENT,
  `before` text,
  `after` text,
  PRIMARY KEY (`sig_num`,`user_id`),
  KEY `sig_user_ref` (`user_id`),
  CONSTRAINT `sig_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `user_role_rel` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_role_ref2` (`role_id`),
  CONSTRAINT `user_role_ref1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_role_ref2` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_alert` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `alert_num` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`alert_num`,`user_id`),
  KEY `alert_user_ref` (`user_id`),
  CONSTRAINT `alert_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `char_color` (
  `color_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(15) NOT NULL,
  `name` varchar(25) NOT NULL,
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`color_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

CREATE TABLE `char_species` (
  `species_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(15) NOT NULL,
  `name` varchar(25) NOT NULL DEFAULT '',
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`species_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `char_image` (
  `species_id` int(11) NOT NULL DEFAULT '0',
  `color_id` int(11) NOT NULL DEFAULT '0',
  `image` longblob,
  `thumb` longblob,
  PRIMARY KEY (`species_id`,`color_id`),
  KEY `image_color_ref` (`color_id`),
  CONSTRAINT `image_species_ref` FOREIGN KEY (`species_id`) REFERENCES `char_species` (`species_id`) ON DELETE CASCADE,
  CONSTRAINT `image_color_ref` FOREIGN KEY (`color_id`) REFERENCES `char_color` (`color_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `character` (
  `char_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `species_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `owned_since` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`char_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `char_user_ref` (`user_id`),
  KEY `char_species_ref` (`species_id`),
  KEY `char_color_ref` (`color_id`),
  CONSTRAINT `char_color_ref` FOREIGN KEY (`color_id`) REFERENCES `char_color` (`color_id`) ON DELETE SET NULL,
  CONSTRAINT `char_species_ref` FOREIGN KEY (`species_id`) REFERENCES `char_species` (`species_id`) ON DELETE SET NULL,
  CONSTRAINT `char_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `char_desc` (
  `char_id` int(11) NOT NULL,
  `content` text,
  PRIMARY KEY (`char_id`),
  CONSTRAINT `char_desc_ref` FOREIGN KEY (`char_id`) REFERENCES `character` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `char_page` (
  `char_id` int(11) NOT NULL,
  `content` longtext,
  PRIMARY KEY (`char_id`),
  CONSTRAINT `char_page_ref` FOREIGN KEY (`char_id`) REFERENCES `character` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `forum_category` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `order` (`order`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `forum` (
  `forum_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) NOT NULL,
  `slug` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`forum_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `forum_cat_ref` (`cat_id`),
  CONSTRAINT `forum_cat_ref` FOREIGN KEY (`cat_id`) REFERENCES `forum_category` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `forum_thread` (
  `thread_id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`thread_id`),
  KEY `thread_forum_ref` (`forum_id`),
  KEY `thread_user_ref` (`user_id`),
  CONSTRAINT `thread_forum_ref` FOREIGN KEY (`forum_id`) REFERENCES `forum` (`forum_id`) ON DELETE CASCADE,
  CONSTRAINT `thread_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

CREATE TABLE `forum_post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `post_thread_ref` (`thread_id`),
  KEY `post_user_ref` (`user_id`),
  CONSTRAINT `post_thread_ref` FOREIGN KEY (`thread_id`) REFERENCES `forum_thread` (`thread_id`) ON DELETE CASCADE,
  CONSTRAINT `post_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

CREATE TABLE `item_type` (
  `item_type_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`item_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `item_def` (
  `item_def_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`item_def_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `item_def_type_rel` (
  `item_def_id` int(11) NOT NULL DEFAULT '0',
  `item_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_def_id`,`item_type_id`),
  KEY `item_def_type_ref2` (`item_type_id`),
  CONSTRAINT `item_def_type_ref1` FOREIGN KEY (`item_def_id`) REFERENCES `item_def` (`item_def_id`) ON DELETE CASCADE,
  CONSTRAINT `item_def_type_ref2` FOREIGN KEY (`item_type_id`) REFERENCES `item_type` (`item_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_def_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `place_id` int(11) DEFAULT NULL,
  `place_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `item_def_ref` (`item_def_id`),
  KEY `item_user_ref` (`user_id`),
  CONSTRAINT `item_def_ref` FOREIGN KEY (`item_def_id`) REFERENCES `item_def` (`item_def_id`) ON DELETE CASCADE,
  CONSTRAINT `item_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `conversation` (
  `convo_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`convo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `convo_user_rel` (
  `convo_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`convo_id`,`user_id`),
  KEY `convo_user_rel1` (`user_id`),
  CONSTRAINT `convo_user_rel1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `convo_user_rel2` FOREIGN KEY (`convo_id`) REFERENCES `conversation` (`convo_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `convo_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `convo_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `message_convo_ref` (`convo_id`),
  KEY `message_user_ref` (`user_id`),
  CONSTRAINT `message_convo_ref` FOREIGN KEY (`convo_id`) REFERENCES `conversation` (`convo_id`) ON DELETE CASCADE,
  CONSTRAINT `message_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `game` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `game_score` (
  `game_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`,`user_id`,`time`),
  KEY `game_score_user_ref` (`user_id`),
  CONSTRAINT `game_score_ref` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`),
  CONSTRAINT `game_score_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  PRIMARY KEY (`news_id`),
  KEY `news_user_ref` (`user_id`),
  CONSTRAINT `news_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

