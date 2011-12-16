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
    
    public function export()
    {
        JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('sites');
        $list = $model->getUnprotectedExtensions();
        
        // Render XML
        $xml = new JXMLElement('<extensionset></extensionset>');
        $xml->addAttribute('name', 'My Distro');
        $xml->addAttribute('description', 'My Distro Description');
        
        // Bind additional data from manifest and add to xml
        foreach ($list as $item)
        {
            $child = $xml->addChild('extension');
            $child->addAttribute('name', $item->name);
            $child->addAttribute('element', $item->element);
            $child->addAttribute('type', $item->type);
            
            switch ($item->type)
            {
                case 'component' :
                    $file = JFile::read(JPATH_ADMINISTRATOR.'/components/'.$item->element.'/'.substr($item->element, 4).'.xml');
                    break;
                case 'module' : 
                    if ($item->client_id) $file = JFile::read(JPATH_ADMINISTRATOR.'/modules/'.$item->element.'/'.substr($item->element, 4).'.xml');
                    else $file = JFile::read(JPATH_SITE.'/modules/'.$item->element.'/'.substr($item->element, 4).'.xml');
                    break;
                case 'plugin' :
                    $file = JFile::read(JPATH_PLUGINS.'/'.$item->folder.'/'.$item->element.'/'.$item->element.'.xml');
                    break;
                case 'template' : 
                    if ($item->client_id) $file = JFile::read(JPATH_ADMINISTRATOR.'/templates/'.$item->element.'/templateDetails.xml');
                    else $file = JFile::read(JPATH_SITE.'/templates/'.$item->element.'/templateDetails.xml');
                    break;
            }
            $extension = simplexml_load_string($file);
            
            $child->addAttribute('version', $extension->version);
            $child->addAttribute('detailsurl', $extension->detailsurl);
        }
        
        header('Content-Type: text/xml');
        header('Content-Disposition: attachment; filename="distro.xml"');
        header('Content-Transfer-Encoding: binary');
        print $xml->asXML();
        
        exit();
        
        //$this->setRedirect(JRoute::_('index.php?option=com_installer&view=sites', false));
    }
    
    public function import()
    {
        
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