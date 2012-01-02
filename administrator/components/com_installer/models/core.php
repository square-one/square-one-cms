<?php
/**
 * @version		$Id$
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access
defined('_JEXEC') or die;

// Import library dependencies
jimport('joomla.application.component.modellist');
jimport('joomla.installer.installer');
jimport('joomla.installer.helper');
jimport('joomla.updater.updater');
jimport('joomla.updater.update');

/**
 * @package		Joomla.Administrator
 * @subpackage	com_installer
 * @since		1.6
 */
class InstallerModelCore extends JModelList
{
	/**
	 * Constructor.
	 *
	 * @param	array	An optional associative array of configuration settings.
	 * @see		JController
	 * @since	1.6
	 */
	public function __construct($config = array())
	{
		if (empty($config['filter_fields'])) {
			$config['filter_fields'] = array(
				'name',
				'client_id',
				'type',
				'folder',
				'extension_id',
				'update_id',
				'update_site_id',
                'update_site',
			);
		}

		parent::__construct($config);
	}

	/**
	 * Method to auto-populate the model state.
	 *
	 * Note. Calling getState in this method will result in recursion.
	 *
	 * @since	1.6
	 */
	protected function populateState($ordering = null, $direction = null)
	{
        // Initialise variables.
		$app = JFactory::getApplication();
		$filters = JRequest::getVar('filters');
		if (empty($filters)) {
			$data = $app->getUserState($this->context.'.data');
			$filters = $data['filters'];
		}
		else {
			$app->setUserState($this->context.'.data', array('filters'=>$filters));
		}
        
		$this->setState('message',$app->getUserState('com_installer.message'));
		$this->setState('extension_message',$app->getUserState('com_installer.extension_message'));
		$app->setUserState('com_installer.message','');
		$app->setUserState('com_installer.extension_message','');
        $this->setState('filter.type', isset($filters['type']) ? $filters['type'] : '');
        $this->setState('filter.update_site_id', isset($filters['update_site_id']) ? $filters['update_site_id'] : '');
        $this->setState('filter.folder', isset($filters['folder']) ? $filters['folder'] : '');
        
		parent::populateState('name', 'asc');
	}

	/**
	 * Method to get the database query
	 *
	 * @return	JDatabaseQuery	The database query
	 * @since	1.6
	 */
	protected function getListQuery()
	{
		$db		= $this->getDbo();
		$query	= $db->getQuery(true);
		// grab updates ignoring new installs
		$query->select('a.*, u.name AS update_site')->from('#__updates AS a')->where('extension_id = 0');
		$query->order($this->getState('list.ordering').' '.$this->getState('list.direction'));
        
        if ($this->getState('filter.type') != '') $query->where('a.type = '.$db->quote($this->getState('filter.type')));
        if ($this->getState('filter.update_site_id') != '') $query->where('a.update_site_id = '.$db->quote($this->getState('filter.update_site_id')));
        if ($this->getState('filter.folder') != '') $query->where('a.folder = '.$db->quote($this->getState('filter.folder')));
        
        // Join update_sites
        $query->join('left', $db->nameQuote('#__update_sites').' AS u ON u.update_site_id = a.update_site_id');

		return $query;
	}

	/**
	 * Finds updates for an extension.
	 *
	 * @param	int		Extension identifier to look for
	 * @return	boolean Result
	 * @since	1.6
	 */
	public function findUpdates($eid=0)
	{
		$updater = JUpdater::getInstance();
		$results = $updater->findUpdates($eid);
		return true;
	}

	/**
	 * Removes all of the updates from the table.
	 *
	 * @return	boolean result of operation
	 * @since	1.6
	 */
	public function purge()
	{
		$db = JFactory::getDBO();
		// Note: TRUNCATE is a DDL operation
		// This may or may not mean depending on your database
		$db->setQuery('TRUNCATE TABLE #__updates');
		if ($db->Query()) {
			$this->_message = JText::_('COM_INSTALLER_PURGED_UPDATES');
			return true;
		} else {
			$this->_message = JText::_('COM_INSTALLER_FAILED_TO_PURGE_UPDATES');
			return false;
		}
	}
    
    /**
     * Get current extensions
     * 
     * @since   2.5
     * @return  object
     */
    public function getUpdates()
    {
        $db = JFactory::getDBO();
        $db->setQuery('SELECT * FROM #__updates');
        if ($updates = $db->loadObjectList())
        {
            return $updates;
        }
        return false;
    }
    
    /**
     * Get current extensions
     * 
     * @since   2.5
     * @return  object
     */
    public function getExtensions()
    {
        $db = JFactory::getDBO();
        $db->setQuery('SELECT * FROM #__extensions');
        if ($extensions = $db->loadObjectList())
        {
            return $extensions;
        }
        return false;
    }
    
    /**
	 * Install function.
	 *
	 * Sets the "result" state with the result of the operation.
	 *
	 * @param	Array[int] List of updates to apply
	 * @since	1.7
	 */
	public function install($eids)
	{
		$result = true;
		foreach($eids as $eid) {
			$update = new JUpdate();
			$instance = JTable::getInstance('update');
			$instance->load($eid);
			$update->loadFromXML($instance->detailsurl);
			// install sets state and enqueues messages
			$res = $this->install_install($update->get('downloadurl')->_data);

            // Disabling the purging of the update list, instead deleting specific row
			if ($res) {
				$instance->delete($ed);
			}

			$result = $res & $result;
		}
        
		// Set the final state
		$this->setState('result', $result);
	}
    
    function install_install($url)
	{
		jimport('joomla.client.helper');
		$this->setState('action', 'install');

		// Set FTP credentials, if given.
		JClientHelper::setCredentialsFromRequest('ftp');
		$app = JFactory::getApplication();
        
        $package = $this->_getPackageFromUrl($url);

		// Was the package unpacked?
		if (!$package) {
			$app->setUserState('com_installer.message', JText::_('COM_INSTALLER_UNABLE_TO_FIND_INSTALL_PACKAGE'));
			return false;
		}

		// Get an installer instance
		$installer = JInstaller::getInstance();

		// Install the package
		if (!$installer->install($package['dir'])) {
			// There was an error installing the package
			$msg = JText::sprintf('COM_INSTALLER_INSTALL_ERROR', JText::_('COM_INSTALLER_TYPE_TYPE_'.strtoupper($package['type'])));
			$result = false;
		} else {
			// Package installed sucessfully
			$msg = JText::sprintf('COM_INSTALLER_INSTALL_SUCCESS', JText::_('COM_INSTALLER_TYPE_TYPE_'.strtoupper($package['type'])));
			$result = true;
		}

		// Set some model state values
		$app	= JFactory::getApplication();
		$app->enqueueMessage($msg);
		$this->setState('name', $installer->get('name'));
		$this->setState('result', $result);
		$app->setUserState('com_installer.message', $installer->message);
		$app->setUserState('com_installer.extension_message', $installer->get('extension_message'));
		$app->setUserState('com_installer.redirect_url', $installer->get('redirect_url'));

		// Cleanup the install files
		if (!is_file($package['packagefile'])) {
			$config = JFactory::getConfig();
			$package['packagefile'] = $config->get('tmp_path') . '/' . $package['packagefile'];
		}

		JInstallerHelper::cleanupInstall($package['packagefile'], $package['extractdir']);


		return $result;
	}
    
    /**
	 * Install an extension from a URL
	 *
	 * @return	Package details or false on failure
	 * @since	1.5
	 */
	protected function _getPackageFromUrl($url)
	{
		// Get a database connector
		$db = JFactory::getDbo();

		// Did you give us a URL?
		if (!$url) {
			JError::raiseWarning('', JText::_('COM_INSTALLER_MSG_INSTALL_ENTER_A_URL'));
			return false;
		}

		// Download the package at the URL given
		$p_file = JInstallerHelper::downloadPackage($url);

		// Was the package downloaded?
		if (!$p_file) {
			JError::raiseWarning('', JText::_('COM_INSTALLER_MSG_INSTALL_INVALID_URL'));
			return false;
		}

		$config		= JFactory::getConfig();
		$tmp_dest	= $config->get('tmp_path');

		// Unpack the downloaded package file
		$package = JInstallerHelper::unpack($tmp_dest . '/' . $p_file);

		return $package;
	}

	/**
	 * Handles the actual update installation.
	 *
	 * @param	JUpdate	An update definition
	 * @return	boolean	Result of install
	 * @since	1.6
	 */
	private function install_update($update)
	{
		$app = JFactory::getApplication();
		if (isset($update->get('downloadurl')->_data)) {
			$url = $update->downloadurl->_data;
		} else {
			JError::raiseWarning('', JText::_('COM_INSTALLER_INVALID_EXTENSION_UPDATE'));
			return false;
		}

		jimport('joomla.installer.helper');
		$p_file = JInstallerHelper::downloadPackage($url);

		// Was the package downloaded?
		if (!$p_file) {
			JError::raiseWarning('', JText::sprintf('COM_INSTALLER_PACKAGE_DOWNLOAD_FAILED', $url));
			return false;
		}

		$config		= JFactory::getConfig();
		$tmp_dest	= $config->get('tmp_path');

		// Unpack the downloaded package file
		$package	= JInstallerHelper::unpack($tmp_dest . '/' . $p_file);

		// Get an installer instance
		$installer	= JInstaller::getInstance();
		$update->set('type', $package['type']);

		// Install the package
		if (!$installer->update($package['dir'])) {
			// There was an error updating the package
			$msg = JText::sprintf('COM_INSTALLER_MSG_UPDATE_ERROR', JText::_('COM_INSTALLER_TYPE_TYPE_'.strtoupper($package['type'])));
			$result = false;
		} else {
			// Package updated successfully
			$msg = JText::sprintf('COM_INSTALLER_MSG_UPDATE_SUCCESS', JText::_('COM_INSTALLER_TYPE_TYPE_'.strtoupper($package['type'])));
			$result = true;
		}

		// Quick change
		$this->type = $package['type'];

		// Set some model state values
		$app->enqueueMessage($msg);

		// TODO: Reconfigure this code when you have more battery life left
		$this->setState('name', $installer->get('name'));
		$this->setState('result', $result);
		$app->setUserState('com_installer.message', $installer->message);
		$app->setUserState('com_installer.extension_message', $installer->get('extension_message'));

		// Cleanup the install files
		if (!is_file($package['packagefile'])) {
			$config = JFactory::getConfig();
			$package['packagefile'] = $config->get('tmp_path') . '/' . $package['packagefile'];
		}

		JInstallerHelper::cleanupInstall($package['packagefile'], $package['extractdir']);

		return $result;
	}
    
    	/**
	 * Method to get the row form.
	 *
	 * @param	array	$data		Data for the form.
	 * @param	boolean	$loadData	True if the form is to load its own data (default case), false if not.
	 * @return	mixed	A JForm object on success, false on failure
	 * @since	1.6
	 */
	public function getForm($data = array(), $loadData = true)
	{
		// Get the form.
		$app = JFactory::getApplication();
		JForm::addFormPath(JPATH_COMPONENT . '/models/forms');
		JForm::addFieldPath(JPATH_COMPONENT . '/models/fields');
		$form = JForm::getInstance('com_installer.core', 'core', array('load_data' => $loadData));

		// Check for an error.
		if ($form == false) {
			$this->setError($form->getMessage());
			return false;
		}
		// Check the session for previously entered form data.
		$data = $this->loadFormData();

		// Bind the form data if present.
		if (!empty($data)) {
			$form->bind($data);
		}

		return $form;
	}

	/**
	 * Method to get the data that should be injected in the form.
	 *
	 * @return	mixed	The data for the form.
	 * @since	1.6
	 */
	protected function loadFormData()
	{
		// Check the session for previously entered form data.
		$data = JFactory::getApplication()->getUserState('com_installer.core.data', array());

		return $data;
	}
}
