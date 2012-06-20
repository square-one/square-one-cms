ALTER TABLE `#__users` ADD COLUMN `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset';
ALTER TABLE `#__users` ADD COLUMN `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime';
UPDATE `#__menu` SET `link` = "index.php?option=com_menus&task=menu.add" WHERE `link` = "index.php?option=com_menu&task=menu.add"