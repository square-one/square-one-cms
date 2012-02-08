<?php
/**
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die;

jimport('joomla.application.component.view');

/**
 * Displays the multilang status.
 *
 * @package		Joomla.Administrator
 * @subpackage	com_languages
 * @since		1.7.1
 */
class LanguagesViewMultilangstatus extends JView
{
	/**
	 * Display the view
	 */
	function display($tpl = null)
	{
		require_once JPATH_COMPONENT . '/helpers/multilangstatus.php';

		$this->homes			= multilangstatusHelper::getHomes();
		$this->language_filter	= multilangstatusHelper::getLangfilter();
		$this->switchers		= multilangstatusHelper::getLangswitchers();
		$this->contentlangs		= multilangstatusHelper::getContentlangs();
		$this->site_langs		= multilangstatusHelper::getSitelangs();
		$this->statuses			= multilangstatusHelper::getStatus();
		$this->homepages		= multilangstatusHelper::getHomepages();

		parent::display($tpl);
	}
}
