<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    
 * @package     
 */

defined('_JEXEC') or die;

jimport('joomla.application.component.controlleradmin');

class InstallerControllerSites extends JControllerAdmin 
{
    
    public function refresh()
    {
        JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('sites');
        $model->refreshList();
        
        $this->setRedirect(JRoute::_('index.php?option=com_installer&view=sites', false));
    }
    
}