<?php

defined('JPATH_BASE') or die;

jimport('joomla.html.html');
jimport('joomla.form.formfield');
jimport('joomla.form.helper');
JFormHelper::loadFieldClass('list');

class JFormFieldComponents extends JFormFieldList
{

	protected $type = 'Components';
    
    protected function getOptions()
    {
        $options = array();
        $lang = JFactory::getLanguage();
        
        foreach ($this->_getComponents() as $component) 
        {
            $lang->load($component->element.'.sys', JPATH_ADMINISTRATOR, null, false, false)
							||	$lang->load($component->element.'.sys', JPATH_ADMINISTRATOR.'/components/'.$component->element, null, false, false)
							||	$lang->load($component->element.'.sys', JPATH_ADMINISTRATOR, $lang->getDefault(), false, false)
							||	$lang->load($component->element.'.sys', JPATH_ADMINISTRATOR.'/components/'.$component->element, $lang->getDefault(), false, false);
			$options[] = JHtml::_('select.option', $component->extension_id, JText::_($component->name));
		}
        
        return $options;
    }

	protected function _getComponents()
	{
		// Get the list of components.
		$db = JFactory::getDBO();
		$db->setQuery(
			'SELECT `extension_id`, `name`, `element` ' .
			' FROM `#__extensions`' .
			' WHERE `type` = "component"' .
			' AND `enabled` = 1' .
			' ORDER BY `name`'
		);
		$components = $db->loadObjectList();

		return $components;
	}
}
