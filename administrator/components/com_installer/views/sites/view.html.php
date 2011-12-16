<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    
 * @package     
 */

defined('_JEXEC') or die;

include_once dirname(__FILE__).'/../default/view.php';

class InstallerViewSites extends InstallerViewDefault
{
    public function display($tpl = null)
    {
        if ($this->getLayout() == 'export')
        {
            $model = $this->getModel('sites');
            $this->items = $model->getUnprotectedExtensions();
        }
        else
        {
            $this->state = $this->get('State');
            $this->items = $this->get('Items');
            $this->pagination = $this->get('Pagination');
        }
        
        parent::display($tpl);
    }
    
    protected function addToolbar()
    {
        $canDo = InstallerHelper::getActions();
        
        JToolBarHelper::custom('sites.refresh', 'refresh', 'refresh', 'COM_INSTALLER_TOOLBAR_REFRESH', false, false);
        JToolBarHelper::divider();
        JToolBarHelper::publish('sites.publish', 'JTOOLBAR_ENABLE', true);
        JToolBarHelper::unpublish('sites.unpublish', 'JTOOLBAR_DISABLE', true);
        JToolBarHelper::divider();
        JToolBarHelper::custom('sites.export', 'download', 'download', 'COM_INSTALLER_TOOLBAR_EXPORT', false, false);
        JToolBarHelper::custom('sites.import', 'upload', 'upload', 'COM_INSTALLER_TOOLBAR_IMPORT', false, false);
        JToolBarHelper::divider();
        parent::addToolbar();
        
        if ($this->getLayout() == 'export')
        {
            JToolBarHelper::title(JText::_('COM_INSTALLER_HEADER_EXPORT'), 'install');
            $doc = JFactory::getDocument();
            $doc->setTitle(JText::_('COM_INSTALLER_TITLE_EXPORT'));
        }
    }
}