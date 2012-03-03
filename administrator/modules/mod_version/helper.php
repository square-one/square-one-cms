<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	mod_version
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// no direct access
defined('_JEXEC') or die;

/**
 * @package		Joomla.Administrator
 * @subpackage	mod_version
 * @since		1.6
 */
abstract class modVersionHelper
{
	/**
	 * Get the member items of the submenu.
	 *
	 * @return	mixed	An arry of menu items, or false on error.
	 */
	public static function getVersion(&$params)
	{
		$format = $params->get('format', 'short');
		$product = $params->get('product', 0);
		$method = 'get' . ucfirst($format) . "Version";
		$jmethod = 'get' . ucfirst($format) . "JVersion";

		// Get the joomla version
		$instance = new JVersion();
		$version = call_user_func(array($instance, $method));//$instance->{$method};
		$jversion = call_user_func(array($instance, $jmethod));//$instance->{$method};

		if ($format=='short' && !empty($product)) {
			//add the product name to short format only (in long format it's included)
			$version = $instance->PRODUCT . ' ' . $version . ', based on ' . $instance->JPRODUCT . ' ' . $jversion;
		}
		return $version;
	}
}
