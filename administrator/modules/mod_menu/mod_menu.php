<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

// no direct access
defined('_JEXEC') or die;

// Include the syndicate functions only once
require_once dirname(__FILE__).'/helper.php';

$disabled	= JRequest::getInt('hidemainmenu') ? true : false;
$list	= modMenuHelper::getList($disabled);
$menu		= JMenu::getInstance('administrator');
$active	= $menu->getActive();
$active_id = isset($active) ? $active->id : $menu->getDefault()->id;


if(count($list)) {
	require JModuleHelper::getLayoutPath('mod_menu', 'default');
}
