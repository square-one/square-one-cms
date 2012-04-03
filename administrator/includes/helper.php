<?php
/**
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// no direct access
defined('_JEXEC') or die;

/**
 * Joomla! Administrator Application helper class.
 * Provide many supporting API functions.
 *
 * @package		Joomla.Administrator
 * @subpackage	Application
 */
class JAdministratorHelper
{
	/**
	 * Return the application option string [main component].
	 *
	 * @return	string		Option.
	 * @since	1.5
	 */
	public static function findOption()
	{
		$option = strtolower(JRequest::getCmd('option'));

		$user = JFactory::getUser();
		if (!$user->authorise('core.login.admin')) {
			$option = 'com_login';
		}

		if (empty($option)) {
			$menu = JTable::getInstance('Menu', 'JTable');
			$menu->load(array('home' => '1', 'client_id' => '1'));
			$uri = JURI::getInstance();
			$uri->parse($menu->link);
			$vars = $uri->getQuery(true);

			foreach ($vars as $var => $key)
			{
				JRequest::setVar($var, $key);
				if ($var == 'option') $option = $key;
			}
		}

		return ($option) ? $option : 'com_cpanel';
	}
}
