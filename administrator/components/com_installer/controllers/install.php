<?php
/**
 * @version		$Id$
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License, see LICENSE.php
 */

// No direct access.
defined('_JEXEC') or die;

/**
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 */
class InstallerControllerInstall extends JController
{
	/**
	 * Install an extension.
	 *
	 * @return	void
	 * @since	1.5
	 */
	public function install()
	{
		// Check for request forgeries
		JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
		$model = $this->getModel('install');
        
        $result = $model->install();
        
        if ($result == true) {
            $cache = JFactory::getCache('mod_menu');
            $cache->clean();
            // TODO: Reset the users acl here as well to kill off any missing bits
        }
        
		$app = JFactory::getApplication();
		$redirect_url = $app->getUserState('com_installer.redirect_url');
		if(empty($redirect_url)) {
			$redirect_url = JRoute::_('index.php?option=com_installer&view=install',false);
		} else
		{
			// wipe out the user state when we're going to redirect
			$app->setUserState('com_installer.redirect_url', '');
			$app->setUserState('com_installer.message', '');
			$app->setUserState('com_installer.extension_message', '');
		}
		$this->setRedirect($redirect_url);
	}
        
    public function distro_download()
    {
        JRequest::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('install');
        
        echo json_encode($model->distro_download());
        
        JFactory::getApplication()->close();
    }
    
    public function distro_extract()
    {
        JRequest::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('install');
        
        echo json_encode($model->distro_extract());
        
        JFactory::getApplication()->close();
    }
    
    public function distro_install()
    {
        JRequest::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('install');
        
        echo json_encode($model->distro_install());
        
        JFactory::getApplication()->close();
    }
    
    public function install_script()
    {
        
    }
    
    public function install_sql()
    {
        
    }
}
