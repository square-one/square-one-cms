<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    Administrator
 * @package     com_installer
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

jimport('joomla.application.component.modellist');

class InstallerModelSites extends JModelList
{
    
    protected function populateState($ordering = null, $direction = null)
    {
        parent::populateState('name', 'asc');
    }
    
    protected function getListQuery()
    {
        $db = $this->getDbo();
        $query = $db->getQuery(true);
        
        $query->select('*')
              ->from('#__update_sites')
              ->order($this->getState('list.ordering').' '.$this->getState('list.direction'));
        
        return $query;
    }
    
    public function refreshList()
    {
        jimport('joomla.utilities.xmlelement');
        jimport('joomla.client.http');
        
        $http = new JHttp();
        
        $file = $http->get('http://update.squareonecms.org/updatesites.xml');
        $list = new JXMLElement($file->body);
        
        $db = $this->getDbo();
        $query = $db->getQuery(true);
        $query->select('location')
              ->from('#__update_sites');
        $locations = $db->setQuery($query)->loadResultArray();
        
        JTable::addIncludePath(JPATH_COMPONENT_ADMINISTRATOR.'/tables');
        $update_site = JTable::getInstance('Updatesites', 'InstallerTable');
        
        foreach ($list->xpath('//site') as $site)
        {
            if (!in_array($site->getAttribute('location'), $locations))
            {
                $update_site->bind(array(
                    'name' => $site->getAttribute('name'),
                    'location' => $site->getAttribute('location'),
                    'type' => $site->getAttribute('type'),
                ));
                
                if (!$update_site->store())
                {
                    JError::raiseWarning('500', JText::_('COM_INSTALLER_MSG_FAILEDTOREFRESHSITES'));
                }
            }
        }
        
        return true;
    }
    
    public function publish($ids = array(), $value = 1)
    {
        $result = true;
        
        if (!is_array($ids))
        {
            JError::raiseWarning(500, 'COM_INSTALLER_NO_SELECTION');
        }
        
        $db = JFactory::getDBO();
        JTable::addIncludePath(JPATH_COMPONENT_ADMINISTRATOR.'/tables');
        $table = JTable::getInstance('Updatesites', 'InstallerTable');
        
        foreach ($ids as $i => $id)
        {
            $table->load($id);
            $table->enabled = $value;
            if (!$table->store())
            {
                $this->setError($table->getError());
                $result = false;
            }
        }
        
        return $result;
    }
}