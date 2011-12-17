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
            $model = JModel::getInstance('Extensions', 'InstallerModel');
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
        $toolbar = JToolbar::getInstance();
        $toolbar->appendButton('Popup', 'download', 'COM_INSTALLER_TOOLBAR_EXPORT', 'index.php?option=com_installer&view=sites&layout=export&tmpl=component', 800, 600);
        $toolbar->appendButton('Popup', 'upload', 'COM_INSTALLER_TOOLBAR_IMPORT', 'index.php?option=com_installer&view=sites&layout=import&tmpl=component', 600, 200);
        JToolBarHelper::divider();
        parent::addToolbar();
    }
}