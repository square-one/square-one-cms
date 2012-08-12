#
# Table structure for table `#__assets`
#

CREATE TABLE IF NOT EXISTS `#__assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) DEFAULT CHARSET=utf8;

#
# Dumping data for table `#__assets`
#

INSERT INTO `#__assets` (`id`, `parent_id`, `lft`, `rgt`, `level`, `name`, `title`, `rules`) VALUES
(1, 0, 1, 42, 0, 'root.1', 'Root Asset', '{"core.login.site":{"6":1,"2":1},"core.login.admin":{"6":1},"core.login.offline":{"6":1},"core.admin":{"8":1},"core.manage":{"7":1},"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(2, 1, 2, 3, 1, 'com_admin', 'com_admin', '{}'),
(3, 1, 4, 5, 1, 'com_cache', 'com_cache', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(4, 1, 6, 7, 1, 'com_checkin', 'com_checkin', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(5, 1, 8, 9, 1, 'com_config', 'com_config', '{}'),
(6, 1, 10, 15, 1, 'com_content', 'com_content', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":[]}'),
(7, 1, 16, 17, 1, 'com_cpanel', 'com_cpanel', '{}'),
(8, 1, 18, 19, 1, 'com_installer', 'com_installer', '{"core.admin":{"7":1},"core.manage":{"7":1},"core.delete":[],"core.edit.state":[]}'),
(9, 1, 20, 21, 1, 'com_languages', 'com_languages', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(10, 1, 22, 23, 1, 'com_login', 'com_login', '{}'),
(11, 1, 24, 25, 1, 'com_mailto', 'com_mailto', '{}'),
(12, 1, 26, 27, 1, 'com_massmail', 'com_massmail', '{}'),
(13, 1, 28, 29, 1, 'com_media', 'com_media', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":{"5":1}}'),
(14, 1, 30, 31, 1, 'com_menus', 'com_menus', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(15, 1, 32, 33, 1, 'com_modules', 'com_modules', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(16, 1, 34, 35, 1, 'com_plugins', 'com_plugins', '{"core.admin":{"7":1},"core.manage":[],"core.edit":[],"core.edit.state":[]}'),
(17, 1, 36, 37, 1, 'com_templates', 'com_templates', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(18, 1, 38, 41, 1, 'com_users', 'com_users', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.own":{"6":1},"core.edit.state":[]}'),
(19, 6, 11, 14, 2, 'com_content.category.2', 'Uncategorised', '{"core.create":{"8":1},"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(20, 19, 12, 13, 3, 'com_content.article.1', 'Welcome to Square One', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(21, 18, 39, 40, 1, 'com_users.notes.category.3','Uncategorised','{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}');

# -------------------------------------------------------

#
# Table structure for table `#__associations`
#

CREATE TABLE IF NOT EXISTS `#__associations` (
  `id` VARCHAR(50) NOT NULL COMMENT 'A reference to the associated item.',
  `context` VARCHAR(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` CHAR(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY `idx_context_id` (`context`, `id`),
  INDEX `idx_key` (`key`)
) DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__categories`
#

CREATE TABLE `#__categories` (
  `id` int(11) NOT NULL auto_increment,
  `asset_id` INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL default '0',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `level` int(10) unsigned NOT NULL default '0',
  `path` varchar(255) NOT NULL default '',
  `extension` varchar(50) NOT NULL default '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL default '',
  `note` varchar(255) NOT NULL default '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `access` integer unsigned NOT NULL default '0',
  `params` TEXT NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL default '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL default '0',
  `modified_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL default '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  INDEX `idx_language` (`language`)
)  DEFAULT CHARSET=utf8;

INSERT INTO `#__categories` VALUES
(1, 0, 0, 0, 13, 0, '', 'system', 'ROOT', 'root', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{}', '', '', '', 0, '2009-10-18 16:07:09', 0, '0000-00-00 00:00:00', 0, '*'),
(2, 19, 1, 1, 2, 1, 'uncategorised', 'com_content', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:26:37', 0, '0000-00-00 00:00:00', 0, '*'),
(3, 21, 1, 3, 4, 1, 'uncategorised', 'com_users', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:33', 0, '0000-00-00 00:00:00', 0, '*');

# -------------------------------------------------------

#
# Table structure for table `#__content`
#

CREATE TABLE `#__content` (
  `id` integer unsigned NOT NULL auto_increment,
  `asset_id` INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `title_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT 'Deprecated in Joomla! 3.0',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL default '0',
  `sectionid` integer unsigned NOT NULL default '0',
  `mask` integer unsigned NOT NULL default '0',
  `catid` integer unsigned NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` integer unsigned NOT NULL default '0',
  `created_by_alias` varchar(255) NOT NULL default '',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_by` integer unsigned NOT NULL default '0',
  `checked_out` integer unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` integer unsigned NOT NULL default '1',
  `parentid` integer unsigned NOT NULL default '0',
  `ordering` integer NOT NULL default '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` integer unsigned NOT NULL default '0',
  `hits` integer unsigned NOT NULL default '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY  (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
)  DEFAULT CHARSET=utf8;

INSERT INTO `#__content` (`id`, `asset_id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`, `featured`, `language`, `xreference`) VALUES
(1, 20, 'Welcome to Square One', 'welcome-to-square-one', '', '<p>If you are familiar with <a href="http://www.joomla.org">Joomla!</a>, you should find <a href="http://www.squareonecms.org">Square One</a> to be very easy to pick up. The major differences are:</p>\r\n<ul>\r\n<li>Many core extensions were removed from the package</li>\r\n<li>There are no templates except the system template for the front</li>\r\n<li>You can reinstall them by going to the Extensions Manager -&gt; Core Extensions to find and install them remotely</li>\r\n<li>The installer does not contain sample content</li>\r\n<li>Joomla! branding was changed to Square One</li>\r\n</ul>\r\n<p>Other than that, its what you are familiar with!</p>\r\n<h3>If you have a problem</h3>\r\n<p>If you find a bug in Square One, and you can report it on the <a href="http://github.com/square-one/square-one-cms/issues">Square One Github tracker</a>. You will need an account to submit a new issue or to comment. Please check if there is an existing issue related to your report first.</p>', '', 1, 0, 0, 2, '2011-12-06 17:14:11', 42, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2011-12-06 17:14:11', '0000-00-00 00:00:00', '', '', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","alternative_readmore":"","article_layout":""}', 1, 0, 0, '', '', 1, 1, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', '');

# -------------------------------------------------------

#
# Table structure for table `#__content_frontpage`
#

CREATE TABLE `#__content_frontpage` (
  `content_id` integer NOT NULL default '0',
  `ordering` integer NOT NULL default '0',
  PRIMARY KEY  (`content_id`)
)  DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__content_rating`
#

CREATE TABLE `#__content_rating` (
  `content_id` integer NOT NULL default '0',
  `rating_sum` integer unsigned NOT NULL default '0',
  `rating_count` integer unsigned NOT NULL default '0',
  `lastip` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`content_id`)
)  DEFAULT CHARSET=utf8;


# -------------------------------------------------------

#
# Table structure for table `#__extensions`
#

CREATE TABLE `#__extensions` (
  `extension_id` INT  NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100)  NOT NULL,
  `type` VARCHAR(20)  NOT NULL,
  `element` VARCHAR(100) NOT NULL,
  `folder` VARCHAR(100) NOT NULL,
  `client_id` TINYINT(3) NOT NULL,
  `enabled` TINYINT(3) NOT NULL DEFAULT '1',
  `access` integer UNSIGNED NOT NULL DEFAULT '1',
  `protected` TINYINT(3) NOT NULL DEFAULT '0',
  `manifest_cache` TEXT  NOT NULL,
  `params` TEXT NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) default '0',
  `state` int(11) default '0',
  PRIMARY KEY (`extension_id`),
  INDEX `element_clientid`(`element`, `client_id`),
  INDEX `element_folder_clientid`(`element`, `folder`, `client_id`),
  INDEX `extension`(`type`,`element`,`folder`,`client_id`)
) AUTO_INCREMENT=10000 CHARACTER SET utf8;

# Components
INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(1, 'com_mailto', 'component', 'com_mailto', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(3, 'com_admin', 'component', 'com_admin', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(5, 'com_cache', 'component', 'com_cache', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(6, 'com_categories', 'component', 'com_categories', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(7, 'com_checkin', 'component', 'com_checkin', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(9, 'com_cpanel', 'component', 'com_cpanel', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10, 'com_installer', 'component', 'com_installer', '', 1, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(11, 'com_languages', 'component', 'com_languages', '', 1, 1, 1, 1, '', '{"administrator":"en-GB","site":"en-GB"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(12, 'com_login', 'component', 'com_login', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(13, 'com_media', 'component', 'com_media', '', 1, 1, 0, 1, '', '{"upload_extensions":"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS","upload_maxsize":"10","file_path":"images","image_path":"images","restrict_uploads":"1","allowed_media_usergroup":"3","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip","upload_mime_illegal":"text\\/html","enable_flash":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(14, 'com_menus', 'component', 'com_menus', '', 1, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(16, 'com_modules', 'component', 'com_modules', '', 1, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(18, 'com_plugins', 'component', 'com_plugins', '', 1, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(20, 'com_templates', 'component', 'com_templates', '', 1, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(22, 'com_content', 'component', 'com_content', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_content","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONTENT_XML_DESCRIPTION","group":""}', '{"article_layout":"_:default","show_title":"1","link_titles":"1","show_intro":"1","show_category":"1","link_category":"1","show_parent_category":"0","link_parent_category":"0","show_author":"1","link_author":"0","show_create_date":"0","show_modify_date":"0","show_publish_date":"1","show_item_navigation":"1","show_vote":"0","show_readmore":"1","show_readmore_title":"1","readmore_limit":"100","show_icons":"1","show_print_icon":"1","show_email_icon":"1","show_hits":"1","show_noauth":"0","show_publishing_options":"1","show_article_options":"1","show_urls_images_frontend":"0","show_urls_images_backend":"1","targeta":0,"targetb":0,"targetc":0,"float_intro":"left","float_fulltext":"left","category_layout":"_:blog","show_category_title":"0","show_description":"0","show_description_image":"0","maxLevel":"1","show_empty_categories":"0","show_no_articles":"1","show_subcat_desc":"1","show_cat_num_articles":"0","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_num_articles_cat":"1","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","multi_column_order":"0","show_subcategory_content":"0","show_pagination_limit":"1","filter_field":"hide","show_headings":"1","list_show_date":"0","date_format":"","list_show_hits":"1","list_show_author":"1","orderby_pri":"order","orderby_sec":"rdate","order_date":"published","show_pagination":"2","show_pagination_results":"1","show_feed_link":"1","feed_summary":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(23, 'com_config', 'component', 'com_config', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_config","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONFIG_XML_DESCRIPTION","group":""}', '{"filters":{"1":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"6":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"7":{"filter_type":"NONE","filter_tags":"","filter_attributes":""},"2":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"3":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"4":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"5":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"10":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"12":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"8":{"filter_type":"NONE","filter_tags":"","filter_attributes":""}}}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(25, 'com_users', 'component', 'com_users', '', 1, 1, 0, 1, '', '{"allowUserRegistration":"1","new_usertype":"2","useractivation":"1","frontend_userparams":"1","mailSubjectPrefix":"","mailBodySuffix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# Libraries
INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(100, 'PHPMailer', 'library', 'phpmailer', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(101, 'SimplePie', 'library', 'simplepie', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(102, 'phputf8', 'library', 'phputf8', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(103, 'Joomla! Web Application Framework', 'library', 'joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"Joomla! Web Application Framework","type":"library","creationDate":"2008","author":"Joomla","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"2.5.0","description":"The Joomla! Web Application Framework is the Core of the Joomla! Content Management System","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# Modules
## Site
INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(204, 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(205, 'mod_custom', 'module', 'mod_custom', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(206, 'mod_feed', 'module', 'mod_feed', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(208, 'mod_login', 'module', 'mod_login', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(209, 'mod_menu', 'module', 'mod_menu', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(221, 'mod_languages', 'module', 'mod_languages', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

## Administrator
INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(300, 'mod_custom', 'module', 'mod_custom', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(301, 'mod_feed', 'module', 'mod_feed', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(302, 'mod_latest', 'module', 'mod_latest', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(303, 'mod_logged', 'module', 'mod_logged', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(304, 'mod_login', 'module', 'mod_login', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(305, 'mod_menu', 'module', 'mod_menu', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(307, 'mod_popular', 'module', 'mod_popular', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(308, 'mod_quickicon', 'module', 'mod_quickicon', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(309, 'mod_status', 'module', 'mod_status', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(310, 'mod_submenu', 'module', 'mod_submenu', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(311, 'mod_title', 'module', 'mod_title', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(312, 'mod_toolbar', 'module', 'mod_toolbar', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(313, 'mod_multilangstatus', 'module', 'mod_multilangstatus', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_multilangstatus","type":"module","creationDate":"September 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"1.7.1","description":"MOD_MULTILANGSTATUS_XML_DESCRIPTION","group":""}', '{"cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(314, 'mod_version', 'module', 'mod_version', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_version","type":"module","creationDate":"January 2012","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_VERSION_XML_DESCRIPTION","group":""}', '{"format":"short","product":"1","cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# Plug-ins

INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(401, 'plg_authentication_joomla', 'plugin', 'joomla', 'authentication', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(411, 'plg_editors_none', 'plugin', 'none', 'editors', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(422, 'plg_system_languagefilter', 'plugin', 'languagefilter', 'system', 0, 0, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(423, 'plg_system_p3p', 'plugin', 'p3p', 'system', 0, 1, 1, 1, '', '{"headers":"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(424, 'plg_system_cache', 'plugin', 'cache', 'system', 0, 0, 1, 1, '', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '0000-00-00 00:00:00', 9, 0),
(425, 'plg_system_debug', 'plugin', 'debug', 'system', 0, 1, 1, 1, '', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"1","strip-first":"1","strip-prefix":"","strip-suffix":""}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(426, 'plg_system_log', 'plugin', 'log', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(428, 'plg_system_remember', 'plugin', 'remember', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(429, 'plg_system_sef', 'plugin', 'sef', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 8, 0),
(430, 'plg_system_logout', 'plugin', 'logout', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(432, 'plg_user_joomla', 'plugin', 'joomla', 'user', 0, 1, 1, 1, '', '{"autoregister":"1"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(434, 'plg_extension_joomla', 'plugin', 'joomla', 'extension', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(435, 'plg_content_joomla', 'plugin', 'joomla', 'content', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(436, 'plg_system_languagecode', 'plugin', 'languagecode', 'system', 0, 0, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 10, 0),
(437, 'plg_quickicon_joomlaupdate', 'plugin', 'joomlaupdate', 'quickicon', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(438, 'plg_quickicon_extensionupdate', 'plugin', 'extensionupdate', 'quickicon', 0, 1, 1, 1, '', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(439, 'plg_captcha_recaptcha', 'plugin', 'recaptcha', 'captcha', 0, 1, 1, 1, '{}', '{"public_key":"","private_key":"","theme":"clean"}', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# Templates

INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(502, 'system', 'template', 'system', '', 1, 1, 1, 1, '{"legacy":false,"name":"system","type":"template","creationDate":"07\\/02\\/09","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"1.6.0","description":"TPL_BLUESTORK_XML_DESCRIPTION","group":""}', '{"useRoundedCorners":"1","showSiteName":"0","textBig":"0","highContrast":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(503, 'system', 'template', 'system', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# Languages
INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(600, 'English (United Kingdom)', 'language', 'en-GB', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(601, 'English (United Kingdom)', 'language', 'en-GB', '', 1, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(700, 'Square One CMS', 'file', 'squareone', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

INSERT INTO `#__extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(800, 'joomla', 'package', 'pkg_joomla', '', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# -------------------------------------------------------

#
# Table structure for table `#__languages`
#

CREATE TABLE `#__languages` (
  `lang_id` int(11) unsigned NOT NULL auto_increment,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `sef` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `sitename` varchar(1024) NOT NULL default '',
  `published` int(11) NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`lang_id`),
  UNIQUE `idx_sef` (`sef`),
  UNIQUE `idx_image` (`image`),
  UNIQUE `idx_langcode` (`lang_code`),
  INDEX `idx_ordering` (`ordering`)
)  DEFAULT CHARSET=utf8;

INSERT INTO `#__languages` (`lang_id`,`lang_code`,`title`,`title_native`,`sef`,`image`,`description`,`metakey`,`metadesc`, `published`, `ordering`)
VALUES
(1, 'en-GB', 'English (UK)', 'English (UK)', 'en', 'en', '', '', '', 1, 1);
#
# Table structure for table `#__menu`
#

CREATE TABLE `#__menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `ordering` int(11) NOT NULL DEFAULT '0' COMMENT 'The relative ordering of the menu item in the tree.',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` integer unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` TEXT NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`, `language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(333)),
  KEY `idx_language` (`language`)
)   DEFAULT CHARSET=utf8;


INSERT INTO `#__menu` (`id`, `menutype`, `title`, `alias`, `note`, `path`, `link`, `type`, `published`, `parent_id`, `level`, `component_id`, `ordering`, `checked_out`, `checked_out_time`, `browserNav`, `access`, `img`, `template_style_id`, `params`, `lft`, `rgt`, `home`, `language`, `client_id`) VALUES
(1, '', 'Menu_Item_Root', 'root', '', '', '', '', 1, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, '', 0, '', 0, 75, 0, '*', 0),
(101, 'mainmenu', 'Home', 'home', '', 'home', 'index.php?option=com_content&view=article&id=1', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_title":"1","link_titles":"0","show_intro":"","show_category":"0","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"0","link_author":"","show_create_date":"0","show_modify_date":"0","show_publish_date":"0","show_item_navigation":"0","show_vote":"0","show_icons":"0","show_print_icon":"0","show_email_icon":"0","show_hits":"0","show_noauth":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 1, 2, 1, '*', 0),
(107, 'admin', 'MOD_MENU_COM_CONTENT_ARTICLE_MANAGER', 'comcontent', '', 'modmenucomcontent/comcontent', 'index.php?option=com_content', 'component', 1, 128, 2, 20, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:article', 0, '', 48, 51, 0, '*', 1),
(108, 'admin', 'MOD_MENU_COM_CONTENT_NEW_ARTICLE', 'modmenucomcontentnewarticle', '', 'modmenucomcontent/comcontent/modmenucomcontentnewarticle', 'index.php?option=com_content&task=article.add', 'component', 1, 107, 3, 20, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newarticle', 0, '', 49, 50, 0, '*', 1),
(109, 'admin', 'MOD_MENU_CONTROL_PANEL', 'modmenucontrolpanel', '', 'modmenucontrolpanel', 'index.php', 'component', 1, 1, 1, 9, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:cpanel', 0, '', 3, 20, 0, '*', 1),
(110, 'admin', 'MOD_MENU_CONFIGURATION', 'modmenuconfiguration', '', 'modmenucontrolpanel/modmenuconfiguration', 'index.php?option=com_config', 'component', 1, 109, 2, 23, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:config', 0, '', 4, 5, 0, '*', 1),
(111, 'admin', 'MOD_MENU_SYSTEM_INFORMATION', 'modmenusysteminformation', '', 'modmenucontrolpanel/modmenusysteminformation', 'index.php?option=com_admin&view=sysinfo', 'component', 1, 109, 2, 3, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:maintenance', 0, '', 6, 7, 0, '*', 1),
(112, 'admin', 'MOD_MENU_LOGOUT', 'modmenulogout', '', 'modmenucontrolpanel/modmenulogout', 'index.php?option=com_login&task=logout', 'component', 1, 109, 2, 12, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:logout', 0, '', 18, 19, 0, '*', 1),
(113, 'admin', 'MOD_MENU_MAINTENANCE', 'modmenumaintenance', '', 'modmenucontrolpanel/modmenumaintenance', 'index.php?option=com_checkin', 'component', 1, 109, 2, 7, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:maintenance', 0, '', 8, 15, 0, '*', 1),
(114, 'admin', 'MOD_MENU_GLOBAL_CHECKIN', 'modmenuglobalcheckin', '', 'modmenucontrolpanel/modmenumaintenance/modmenuglobalcheckin', 'index.php?option=com_checkin', 'component', 1, 113, 3, 7, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:checkin', 0, '', 9, 10, 0, '*', 1),
(115, 'admin', 'MOD_MENU_CLEAR_CACHE', 'modmenuclearcache', '', 'modmenucontrolpanel/modmenumaintenance/modmenuclearcache', 'index.php?option=com_cache', 'component', 1, 113, 3, 5, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:clear', 0, '', 11, 12, 0, '*', 1),
(116, 'admin', 'MOD_MENU_PURGE_EXPIRED_CACHE', 'modmenupurgeexpiredcache', '', 'modmenucontrolpanel/modmenumaintenance/modmenupurgeexpiredcache', 'index.php?option=com_cache&view=purge', 'component', 1, 113, 3, 5, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:purge', 0, '', 13, 14, 0, '*', 1),
(117, 'admin', 'MOD_MENU_COM_USERS_USERS', 'modmenucomusersusers', '', 'modmenucomusersusers', 'index.php?option=com_users&view=users', 'component', 1, 1, 1, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:user', 0, '', 21, 36, 0, '*', 1),
(118, 'admin', 'MOD_MENU_COM_USERS_USER_MANAGER', 'modmenucomusersusermanager', '', 'modmenucomusersusers/modmenucomusersusermanager', 'index.php?option=com_users&view=users', 'component', 1, 117, 2, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:user', 0, '', 22, 25, 0, '*', 1),
(119, 'admin', 'MOD_MENU_COM_USERS_ADD_USER', 'modmenucomusersadduser', '', 'modmenucomusersusers/modmenucomusersusermanager/modmenucomusersadduser', 'index.php?option=com_users&task=user.add', 'component', 1, 118, 3, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newuser', 0, '', 23, 24, 0, '*', 1),
(120, 'admin', 'MOD_MENU_COM_USERS_GROUPS', 'modmenucomusersgroups', '', 'modmenucomusersusers/modmenucomusersgroups', 'index.php?option=com_users&view=groups', 'component', 1, 117, 2, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newgroup', 0, '', 26, 29, 0, '*', 1),
(121, 'admin', 'MOD_MENU_COM_USERS_ADD_GROUP', 'modmenucomusersaddgroup', '', 'modmenucomusersusers/modmenucomusersgroups/modmenucomusersaddgroup', 'index.php?option=com_users&task=group.add', 'component', 1, 120, 3, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newgroup', 0, '', 27, 28, 0, '*', 1),
(122, 'admin', 'MOD_MENU_COM_USERS_LEVELS', 'modmenucomuserslevels', '', 'modmenucomusersusers/modmenucomuserslevels', 'index.php?option=com_users&view=levels', 'component', 1, 117, 2, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:levels', 0, '', 30, 33, 0, '*', 1),
(123, 'admin', 'MOD_MENU_COM_USERS_ADD_LEVEL', 'modmenucomusersaddlevel', '', 'modmenucomusersusers/modmenucomuserslevels/modmenucomusersaddlevel', 'index.php?option=com_users&task=level.add', 'component', 1, 122, 3, 25, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newlevel', 0, '', 31, 32, 0, '*', 1),
(124, 'admin', 'MOD_MENU_MASS_MAIL_USERS', 'modmenumassmailusers', '', 'modmenucomusersusers/modmenumassmailusers', 'index.php?option=com_users&view=mail', 'component', 1, 117, 2, 23, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:massmail', 0, '', 34, 35, 0, '*', 1),
(125, 'admin', 'MOD_MENU_MENUS', 'modmenumenus', '', 'modmenumenus', 'index.php?option=com_menus&view=menus', 'component', 1, 1, 1, 14, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:menumgr', 0, '', 37, 46, 0, '*', 1),
(126, 'admin', 'MOD_MENU_MENU_MANAGER', 'modmenumenumanager', '', 'modmenumenus/modmenumenumanager', 'index.php?option=com_menus&view=menus', 'component', 1, 125, 2, 14, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:menumgr', 0, '', 38, 41, 0, '*', 1),
(127, 'admin', 'MOD_MENU_MENU_MANAGER_NEW_MENU', 'modmenumenumanagernewmenu', '', 'modmenumenus/modmenumenumanager/modmenumenumanagernewmenu', 'index.php?option=com_menu&task=menu.add', 'component', 1, 126, 3, 14, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newarticle', 0, '', 39, 40, 0, '*', 1),
(128, 'admin', 'MOD_MENU_COM_CONTENT', 'modmenucomcontent', '', 'modmenucomcontent', 'index.php?option=com_content', 'component', 1, 1, 1, 20, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:content', 0, '', 47, 60, 0, '*', 1),
(129, 'admin', 'MOD_MENU_COM_CONTENT_CATEGORY_MANAGER', 'modmenucomcontentcategorymanager', '', 'modmenucomcontent/modmenucomcontentcategorymanager', 'index.php?option=com_categories&extension=com_content', 'component', 1, 128, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:category', 0, '', 52, 55, 0, '*', 1),
(130, 'admin', 'MOD_MENU_COM_CONTENT_NEW_CATEGORY', 'modmenucomcontentnewcategory', '', 'modmenucomcontent/modmenucomcontentcategorymanager/modmenucomcontentnewcategory', 'index.php?option=com_categories&task=category.add&extension=com_content', 'component', 1, 129, 3, 6, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newcategory', 0, '', 53, 54, 0, '*', 1),
(131, 'admin', 'MOD_MENU_COM_CONTENT_FEATURED', 'modmenucomcontentfeatured', '', 'modmenucomcontent/modmenucomcontentfeatured', 'index.php?option=com_content&view=featured', 'component', 1, 128, 2, 20, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:featured', 0, '', 56, 57, 0, '*', 1),
(132, 'admin', 'MOD_MENU_MEDIA_MANAGER', 'modmenumediamanager', '', 'modmenucomcontent/modmenumediamanager', 'index.php?option=com_media', 'component', 1, 128, 2, 3, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:media', 0, '', 58, 59, 0, '*', 1),
(133, 'admin', 'MOD_MENU_EXTENSIONS_EXTENSIONS', 'modmenuextensionsextensions', '', 'modmenuextensionsextensions', 'index.php?option=com_installer', 'component', 1, 1, 1, 10, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:install', 0, '', 61, 72, 0, '*', 1),
(134, 'admin', 'MOD_MENU_EXTENSIONS_EXTENSION_MANAGER', 'modmenuextensionsextensionmanager', '', 'modmenuextensionsextensions/modmenuextensionsextensionmanager', 'index.php?option=com_installer', 'component', 1, 133, 2, 10, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:install', 0, '', 62, 63, 0, '*', 1),
(135, 'admin', 'MOD_MENU_EXTENSIONS_MODULE_MANAGER', 'modmenuextensionsmodulemanager', '', 'modmenuextensionsextensions/modmenuextensionsmodulemanager', 'index.php?option=com_modules', 'component', 1, 133, 2, 10, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:module', 0, '', 64, 65, 0, '*', 1),
(136, 'admin', 'MOD_MENU_EXTENSIONS_PLUGIN_MANAGER', 'modmenuextensionspluginmanager', '', 'modmenuextensionsextensions/modmenuextensionspluginmanager', 'index.php?option=com_plugins', 'component', 1, 133, 2, 10, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:plugin', 0, '', 66, 67, 0, '*', 1),
(137, 'admin', 'MOD_MENU_EXTENSIONS_TEMPLATE_MANAGER', 'modmenuextensionstemplatemanager', '', 'modmenuextensionsextensions/modmenuextensionstemplatemanager', 'index.php?option=com_templates', 'component', 1, 133, 2, 10, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:themes', 0, '', 68, 69, 0, '*', 1),
(138, 'admin', 'MOD_MENU_EXTENSIONS_LANGUAGE_MANAGER', 'modmenuextensionslanguagemanager', '', 'modmenuextensionsextensions/modmenuextensionslanguagemanager', 'index.php?option=com_languages', 'component', 1, 133, 2, 11, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:language', 0, '', 70, 71, 0, '*', 1),
(139, 'admin', 'Separator', 'separator', '', 'modmenucontrolpanel/separator', '', 'separator', 1, 109, 2, 0, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '', 16, 17, 0, '*', 1),
(140, 'admin', 'COM_MENUS_SUBMENU_MENUS', 'commenussubmenumenus', '', 'modmenumenus/commenussubmenumenus', '', 'menus', 1, 125, 2, 0, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:menu', 0, '', 44, 45, 0, '*', 1),
(141, 'admin', 'MOD_MENU', 'adminmodmenu', '', 'modmenumenus/adminmodmenu', 'index.php?option=com_menus&view=adminitems', 'component', 1, 125, 2, 14, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:menu', 0, '', 42, 43, 0, '*', 1);

# -------------------------------------------------------

#
# Table structure for table `#__menu_types`
#

CREATE TABLE `#__menu_types` (
  `id` integer unsigned NOT NULL auto_increment,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE `idx_menutype` (`menutype`)
)  DEFAULT CHARSET=utf8;

INSERT INTO `#__menu_types` VALUES (1, 'mainmenu', 'Main Menu', 'The main menu for the site');

# -------------------------------------------------------

#
# Table structure for table `#__modules`
#

CREATE TABLE `#__modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL default '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` integer unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` TEXT NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
)  DEFAULT CHARSET=utf8;


INSERT INTO `#__modules` VALUES
(1, 'Main Menu', '', '', 1, 'nav', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 1, 0, '{"menutype":"mainmenu","startLevel":"0","endLevel":"0","showAllChildren":"0","tag_id":"","class_sfx":"","window_open":"","layout":"","moduleclass_sfx":"_menu","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(2, 'Login', '', '', 1, 'login', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_login', 1, 1, '', 1, '*'),
(3, 'Popular Articles', '', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_popular', 3, 1, '{"count":"5","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(4, 'Recently Added Articles', '', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_latest', 3, 1, '{"count":"5","ordering":"c_dsc","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(8, 'Toolbar', '', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_toolbar', 3, 1, '', 1, '*'),
(9, 'Quick Icons', '', '', 1, 'icon', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_quickicon', 3, 1, '', 1, '*'),
(10, 'Logged-in Users', '', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_logged', 3, 1, '{"count":"5","name":"1","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(12, 'Admin Menu', '', '', 1, 'menu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 3, 1, '{"layout":"","moduleclass_sfx":"","shownew":"1","showhelp":"1","cache":"0"}', 1, '*'),
(13, 'Admin Submenu', '', '', 1, 'submenu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_submenu', 3, 1, '', 1, '*'),
(14, 'User Status', '', '', 2, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_status', 3, 1, '', 1, '*'),
(15, 'Title', '', '', 1, 'title', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_title', 3, 1, '', 1, '*'),
(79, 'Multilanguage status', '', '', 1, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_multilangstatus', 3, 1, '{"layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(80, 'Version', '', '', 1, 'footer', 42, '2012-03-10 18:15:01', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_version', 1, 1, '{"format":"short","product":"1","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*');

# -------------------------------------------------------

#
# Table structure for table `#__modules_menu`
#

CREATE TABLE `#__modules_menu` (
  `moduleid` integer NOT NULL default '0',
  `menuid` integer NOT NULL default '0',
  PRIMARY KEY  (`moduleid`,`menuid`)
)  DEFAULT CHARSET=utf8;

#
# Dumping data for table `#__modules_menu`
#

INSERT INTO `#__modules_menu` VALUES
(1,0),
(2,0),
(3,0),
(4,0),
(8,0),
(9,0),
(10,0),
(12,0),
(13,0),
(14,0),
(15,0),
(79,0),
(80,0);


# -------------------------------------------------------

#
# Table structure for table `#__overrider`
#

CREATE TABLE IF NOT EXISTS `#__overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) DEFAULT CHARSET=utf8;


# -------------------------------------------------------
# Table structure for table `#__schemas`
#

CREATE TABLE `#__schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`, `version_id`)
)  DEFAULT CHARSET=utf8;
# -------------------------------------------------------

#
# Table structure for table `#__session`
#

CREATE TABLE `#__session` (
  `session_id` varchar(200) NOT NULL default '',
  `client_id` tinyint(3) unsigned NOT NULL default '0',
  `guest` tinyint(4) unsigned default '1',
  `time` varchar(14) default '',
  `data` mediumtext default NULL,
  `userid` int(11) default '0',
  `username` varchar(150) default '',
  `usertype` varchar(50) default '',
  PRIMARY KEY  (`session_id`),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
)  DEFAULT CHARSET=utf8;


# -------------------------------------------------------

# Update Sites
CREATE TABLE  `#__updates` (
  `update_id` int(11) NOT NULL auto_increment,
  `update_site_id` int(11) default '0',
  `extension_id` int(11) default '0',
  `categoryid` int(11) default '0',
  `name` varchar(100) default '',
  `description` text NOT NULL,
  `element` varchar(100) default '',
  `type` varchar(20) default '',
  `folder` varchar(20) default '',
  `client_id` tinyint(3) default '0',
  `version` varchar(10) default '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  `infourl` text NOT NULL,
  PRIMARY KEY  (`update_id`)
)  DEFAULT CHARSET=utf8 COMMENT='Available Updates';

CREATE TABLE  `#__update_sites` (
  `update_site_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default '',
  `type` varchar(20) default '',
  `location` text NOT NULL,
  `enabled` int(11) default '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  PRIMARY KEY  (`update_site_id`)
)  DEFAULT CHARSET=utf8 COMMENT='Update Sites';

INSERT INTO `#__update_sites` VALUES
(1, 'Square One', 'collection', 'http://update.squareonecms.org/list.xml', 1, 0);

CREATE TABLE `#__update_sites_extensions` (
  `update_site_id` INT DEFAULT 0,
  `extension_id` INT DEFAULT 0,
  PRIMARY KEY(`update_site_id`, `extension_id`)
) DEFAULT CHARSET=utf8 COMMENT = 'Links extensions to update sites';

INSERT INTO `#__update_sites_extensions` VALUES
(1, 700);


CREATE TABLE  `#__update_categories` (
  `categoryid` int(11) NOT NULL auto_increment,
  `name` varchar(20) default '',
  `description` text NOT NULL,
  `parent` int(11) default '0',
  `updatesite` int(11) default '0',
  PRIMARY KEY  (`categoryid`)
)  DEFAULT CHARSET=utf8 COMMENT='Update Categories';


# -------------------------------------------------------

#
# Table structure for table `#__template_styles`
#

CREATE TABLE IF NOT EXISTS `#__template_styles` (
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` TEXT NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
)  DEFAULT CHARSET=utf8 ;

INSERT INTO `#__template_styles` VALUES (1, 'system', 1, 1, 'System - Default', '{"useRoundedCorners":"1","showSiteName":"0"}');
INSERT INTO `#__template_styles` VALUES (2, 'system', 0, 1, 'System - Default', '');

# -------------------------------------------------------
#
# Table structure for table `#__user_usergroup_map`
#

CREATE TABLE IF NOT EXISTS `#__user_usergroup_map` (
  `user_id` integer unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` integer unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY  (`user_id`,`group_id`)
)  DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__usergroups`
#

CREATE TABLE IF NOT EXISTS `#__usergroups` (
  `id` integer unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `parent_id` integer unsigned NOT NULL default '0' COMMENT 'Adjacency List Reference Id',
  `lft` integer NOT NULL default '0' COMMENT 'Nested set lft.',
  `rgt` integer NOT NULL default '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` USING BTREE (`lft`,`rgt`)
)  DEFAULT CHARSET=utf8;

INSERT INTO `#__usergroups` (`id` ,`parent_id` ,`lft` ,`rgt` ,`title`)
VALUES
(1, 0, 1, 20, 'Public'),
	(2, 1, 6, 17, 'Registered'),
		(3, 2, 7, 14, 'Author'),
			(4, 3, 8, 11, 'Editor'),
				(5, 4, 9, 10, 'Publisher'),
(6, 1, 2, 5, 'Manager'),
	(7, 6, 3, 4, 'Administrator'),
(8, 1, 18, 19, 'Super Users');

# -------------------------------------------------------

#
# Table structure for table `#__users`
#

CREATE TABLE `#__users` (
  `id` integer NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `username` varchar(150) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `password` varchar(100) NOT NULL default '',
  `usertype` varchar(25) NOT NULL default '',
  `block` tinyint(4) NOT NULL default '0',
  `sendEmail` tinyint(4) default '0',
  `registerDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL default '',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
)  DEFAULT CHARSET=utf8;

# -------------------------------------------------------

CREATE TABLE IF NOT EXISTS `#__user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) DEFAULT CHARSET=utf8;

# -------------------------------------------------------

CREATE TABLE IF NOT EXISTS `#__user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` varchar(255) NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
)  DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

# -------------------------------------------------------

#
# Table structure for table `#__viewlevels`
#

CREATE TABLE IF NOT EXISTS `#__viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
)   DEFAULT CHARSET=utf8;

#
# Dumping data for table `#__viewlevels`
#

INSERT INTO `#__viewlevels` (`id`, `title`, `ordering`, `rules`) VALUES
(1, 'Public', 0, '[1]'),
(2, 'Registered', 1, '[6,2,8]'),
(3, 'Special', 2, '[6,3,8]');

# -------------------------------------------------------
