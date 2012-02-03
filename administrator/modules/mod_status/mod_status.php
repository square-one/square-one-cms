<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	mod_status
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access.
defined('_JEXEC') or die;

// Initialise variables.
$config	= JFactory::getConfig();
$user	= JFactory::getUser();
$db		= JFactory::getDbo();
$lang	= JFactory::getLanguage();
$query	= $db->getQuery(true);

// Get the number of back-end logged in users.
$query->clear();
$query->select('COUNT(session_id)');
$query->from('#__session');
$query->where('guest = 0 AND client_id = 1');

$db->setQuery($query);
$count = (int) $db->loadResult();

// Get the number of frontend logged in users.
$query->clear();
$query->select('COUNT(session_id)');
$query->from('#__session');
$query->where('guest = 0 AND client_id = 0');

$db->setQuery($query);
$online_num = (int) $db->loadResult();

require JModuleHelper::getLayoutPath('mod_status', $params->get('layout', 'default'));
