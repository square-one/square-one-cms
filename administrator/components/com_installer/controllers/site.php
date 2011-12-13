<?php
/**
 * @version		$Id$
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License, see LICENSE.php
 */

// No direct access
defined('_JEXEC') or die;

// Import dependencies
require_once JPATH_COMPONENT_ADMINISTRATOR . '/models/extension.php';

/**
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 */
class InstallerControllerSite extends JController {
    
    /**
	 * Install a set of extensions.
	 *
	 * @since	1.7
	 */
	function install()
	{
		// Check for request forgeries
		JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));

		$model	= $this->getModel('site');
		$eid	= JRequest::getVar('eid', array(), '', 'array');

		JArrayHelper::toInteger($eid, array());
		if ($model->install($eid)) {
			$cache = JFactory::getCache('mod_menu');
			$cache->clean();
		}

		$app = JFactory::getApplication();
		$redirect_url = $app->getUserState('com_installer.redirect_url');
		if(empty($redirect_url)) {
			$redirect_url = JRoute::_('index.php?option=com_installer&view=site',false);
		} else
		{
			// wipe out the user state when we're going to redirect
			$app->setUserState('com_installer.redirect_url', '');
			$app->setUserState('com_installer.message', '');
			$app->setUserState('com_installer.extension_message', '');
		}
		$this->setRedirect($redirect_url);
	}

	/**
	 * Find new updates.
	 *
	 * @since	1.6
	 */
	function find()
	{
		// Find updates
		// Check for request forgeries
		JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
		$model	= $this->getModel('site');
		$model->purge();
		$result = $model->findUpdates();
        
        // Workaround for removing extentions that are already installed without
        // overwriting the Platform. Major breech of MVC but I can live with myself for the time being.
        $db = JFactory::getDBO();
        $updates = $model->getUpdates();
        $extensions = $model->getExtensions();
        $installed = array();
        foreach ($updates as $update)
        {
            if ($update->extension_id) continue;
            foreach ($extensions as $extension)
            {
                if ($extension->element == $update->element && $extension->folder == $update->folder && $extension->type == $update->type)
                {
                    $installed[] = $update->update_id;
                    continue;
                }
            }
        }
        
        if (count($installed))
        {
            
            $db->setQuery('DELETE FROM #__updates WHERE update_id IN ('.implode(',', $installed).')');
            if (!$db->query())
            {
                $this->setRedirect(JRoute::_('index.php?option=com_installer&view=site'), JText::_('COM_INSTALLER_MSG_UPDATEERROR'));
            }
        }
        // End Workaround
        
		$this->setRedirect(JRoute::_('index.php?option=com_installer&view=site', false));
	}

	/**
	 * Purges updates.
	 *
	 * @since	1.6
	 */
	function purge()
	{
		// Purge updates
		// Check for request forgeries
		JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
		$model = $this->getModel('core');
		$model->purge();
		$model->enableSites();
		$this->setRedirect(JRoute::_('index.php?option=com_installer&view=site',false), $model->_message);
	}
}
