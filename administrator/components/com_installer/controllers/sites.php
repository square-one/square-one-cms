<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    
 * @package     
 */

defined('_JEXEC') or die;

class InstallerControllerSites extends JController {
    
    public function refresh()
    {
        JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('sites');
        $model->refreshList();
        
        $this->setRedirect(JRoute::_('index.php?option=com_installer&view=sites', false));
    }
    
    public function publish()
    {
        JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
        $ids = JRequest::getVar('cid', array(), '', 'array');
        if (empty($ids))
        {
            JError::raiseWarning(500, JText::_('COM_INSTALLER_ERROR_NO_DISTRIBUTIONS_SELECTED'));
        }
        else
        {
            $model = $this->getModel('sites');
            
            if ($model->publish($ids, 1))
            {
                $this->setMessage(JText::plural('COM_INSTALLER_MSG_DISTRIBUTIONS_PUBLISHED', count($ids)));
            }
            else
            {
                JError::raiseWarning(500, implode('<br />', $model->getErrors()));
            }
        }
        
        
        $this->setRedirect(JRoute::_('index.php?option=com_installer&view=sites', false));
    }
    
    public function unpublish()
    {
        JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
        $ids = JRequest::getVar('cid', array(), '', 'array');
        if (empty($ids))
        {
            JError::raiseWarning(500, JText::_('COM_INSTALLER_ERROR_NO_DISTRIBUTIONS_SELECTED'));
        }
        else
        {
            $model = $this->getModel('sites');
            
            if ($model->publish($ids, 0))
            {
                $this->setMessage(JText::plural('COM_INSTALLER_MSG_DISTRIBUTIONS_UNPUBLISHED', count($ids)));
            }
            else
            {
                JError::raiseWarning(500, implode('<br />', $model->getErrors()));
            }
        }
        
        
        $this->setRedirect(JRoute::_('index.php?option=com_installer&view=sites', false));
    }
    
}