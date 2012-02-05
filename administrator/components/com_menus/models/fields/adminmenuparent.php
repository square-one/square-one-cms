<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

defined('JPATH_BASE') or die;

jimport('joomla.html.html');
jimport('joomla.form.formfield');
jimport('joomla.form.helper');
JFormHelper::loadFieldClass('list');

/**
 * Form Field class for the Joomla Framework.
 *
 * @package		Joomla.Administrator
 * @subpackage	com_menus
 * @since		1.6
 */
class JFormFieldAdminmenuParent extends JFormFieldList
{
	/**
	 * The form field type.
	 *
	 * @var		string
	 * @since	1.6
	 */
	protected $type = 'AdminmenuParent';

	/**
	 * Method to get the field options.
	 *
	 * @return	array	The field option objects.
	 * @since	1.6
	 */
	protected function getOptions()
	{
		// Initialize variables.
		$options = array();

		$db = JFactory::getDbo();
		$query = $db->getQuery(true);

		$query->select('a.id AS value, a.title AS text, a.level');
		$query->from('#__menu AS a');
		$query->join('LEFT', '#__menu AS b ON a.lft > b.lft AND a.rgt < b.rgt');
		$query->where('a.menutype = '.$db->quote('admin'));

		// Prevent parenting to children of this item.
		if ($id = $this->form->getValue('id')) {
			$query->join('LEFT', '#__menu AS p ON p.id = '.(int) $id);
			$query->where('NOT(a.lft >= p.lft AND a.rgt <= p.rgt)');
		}

		$query->where('a.published != -2');
        $query->where('a.client_id = 1');
		$query->group('a.id, a.title, a.level, a.lft');
		$query->order('a.lft ASC');

		// Get the options.
		$db->setQuery($query);

		$options = $db->loadObjectList();

		// Check for a database error.
		if ($db->getErrorNum()) {
			JError::raiseWarning(500, $db->getErrorMsg());
		}

		// Pad the option text with spaces using depth level as a multiplier.
		for ($i = 0, $n = count($options); $i < $n; $i++) {
			$options[$i]->text = str_repeat('- ',$options[$i]->level).JText::_($options[$i]->text);
		}

		// Merge any additional options in the XML definition.
		$options = array_merge(parent::getOptions(), $options);

		return $options;
	}
}
