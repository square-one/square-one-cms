<?php
/**
 * @version		$Id$
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 * @since		1.5
 */

// no direct access
defined('_JEXEC') or die;

include_once dirname(__FILE__).'/../default/view.php';

/**
 * Extension Manager Install View
 *
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 * @since		1.5
 */
class InstallerViewInstall extends InstallerViewDefault
{
	/**
	 * @since	1.5
	 */
	function display($tpl=null)
	{
		$paths = new stdClass();
		$paths->first = '';

		$this->assignRef('paths', $paths);
		$this->state = $this->get('State');
        $core = JModel::getInstance('Core', 'InstallerModel');
        $this->items        = $core->getItems();
		$this->pagination	= $this->get('Pagination');
        $this->form			= $this->get('Form');
        
        if ($this->getLayout() == 'distribution')
        {
            jimport('joomla.installer.installer');
            
            // Extract the list and return it
            $installer = JInstaller::getInstance();
            $installer->setPath('source', $state->get('install.directory'));
            $manifest = $installer->getManifest();
            
            $result = false;
            
            if ($manifest)
            {
                $result->extensions = isset($manifest->extensions) ? $manifest->extensions : false;
                $result->sql = isset($manifest->install) ? true : false;
                $result->script = isset($manifest->scriptfile) ? true : false;
            }
            
            $this->result = $result;
        }
        
        

		parent::display($tpl);
	}

	/**
	 * Add the page title and toolbar.
	 *
	 * @since	1.6
	 */
	protected function addToolbar()
	{
        JToolBarHelper::custom('install.install_remote', 'upload', 'upload', 'JTOOLBAR_INSTALL', true, false);
		JToolBarHelper::custom('install.find', 'refresh', 'refresh', 'COM_INSTALLER_TOOLBAR_FIND_EXTENSIONS',false,false);
		JToolBarHelper::custom('install.purge', 'purge', 'purge', 'JTOOLBAR_PURGE_CACHE', false,false);
		JToolBarHelper::divider();
		parent::addToolbar();
		JToolBarHelper::help('JHELP_EXTENSIONS_EXTENSION_MANAGER_INSTALL');
	}
}
