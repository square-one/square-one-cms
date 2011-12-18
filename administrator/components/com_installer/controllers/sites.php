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
    
    public function export()
    {
        JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));
        
        $model = $this->getModel('sites');
        $list = $model->getUnprotectedExtensions();
        $ids = JRequest::getVar('cid', array(), '', 'array');
        $distro = JRequest::getVar('distro', array(), '', 'array');
        
        // Render XML
        $xml = new JXMLElement('<distribution></distribution>');
        $xml->addChild('name');
        $xml->name = $distro['name'];
        $xml->addChild('description');
        $xml->description = $distro['description'];
        
        $extensions = $xml->addChild('extensions');
        
        // Bind additional data from manifest and add to xml
        foreach ($list as $item)
        {
            if (!in_array($item->extension_id, $ids)) continue;
            
            $child = $extensions->addChild('extension');
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
        
        $host = JURI::getInstance();
        $filename = 'distro-'.$host->getHost();
        
        header('Content-Type: text/xml');
        header('Content-Disposition: attachment; filename="'.$filename.'.xml"');
        header('Content-Transfer-Encoding: binary');
        print $xml->asXML();
        
        exit();
    }
    
	public function &getModel($name = 'Sites', $prefix = 'InstallerModel', $config = array())
	{
		$model = parent::getModel($name, $prefix, array('ignore_request' => true));
		return $model;
	}
    
}