<?php

/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

defined('_JEXEC') or die;

jimport('joomla.application.component.modellist');

/**
 * Menu Item List Model for Menus.
 *
 * @package		Joomla.Administrator
 * @subpackage	com_menus
 * @since		1.6
 */
class MenusModelAdminitems extends JModelList
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
				'id', 'a.id',
				'menutype', 'a.menutype',
				'title', 'a.title',
				'alias', 'a.alias',
				'published', 'a.published',
				'access', 'a.access', 'access_level',
				'language', 'a.language',
				'checked_out', 'a.checked_out',
				'checked_out_time', 'a.checked_out_time',
				'lft', 'a.lft',
				'rgt', 'a.rgt',
				'level', 'a.level',
				'path', 'a.path',
				'client_id', 'a.client_id',
				'home', 'a.home',
			);
			if (JFactory::getApplication()->get('menu_associations', 0)) {
				$config['filter_fields'][] = 'association';
			}
		}

		parent::__construct($config);
	}

	/**
	 * Method to auto-populate the model state.
	 *
	 * Note. Calling getState in this method will result in recursion.
	 *
	 * @return	void
	 * @since	1.6
	 */
	protected function populateState($ordering = null, $direction = null)
	{
		$app = JFactory::getApplication('administrator');

		$search = $this->getUserStateFromRequest($this->context.'.search', 'filter_search');
		$this->setState('filter.search', $search);

		$published = $this->getUserStateFromRequest($this->context.'.published', 'filter_published', '');
		$this->setState('filter.published', $published);

		$access = $this->getUserStateFromRequest($this->context.'.filter.access', 'filter_access', 0, 'int');
		$this->setState('filter.access', $access);

		$parentId = $this->getUserStateFromRequest($this->context.'.filter.parent_id', 'filter_parent_id', 0, 'int');
		$this->setState('filter.parent_id',	$parentId);

		$level = $this->getUserStateFromRequest($this->context.'.filter.level', 'filter_level', 0, 'int');
		$this->setState('filter.level', $level);

		$language = $this->getUserStateFromRequest($this->context.'.filter.language', 'filter_language', '');
		$this->setState('filter.language', $language);

		// Component parameters.
		$params	= JComponentHelper::getParams('com_menus');
		$this->setState('params', $params);

		// List state information.
		parent::populateState('a.lft', 'asc');
	}

	/**
	 * Method to get a store id based on model configuration state.
	 *
	 * This is necessary because the model is used by the component and
	 * different modules that might need different sets of data or different
	 * ordering requirements.
	 *
	 * @param	string		$id	A prefix for the store id.
	 *
	 * @return	string		A store id.
	 * @since	1.6
	 */
	protected function getStoreId($id = '')
	{
		// Compile the store id.
		$id	.= ':'.$this->getState('filter.access');
		$id	.= ':'.$this->getState('filter.published');
		$id	.= ':'.$this->getState('filter.language');
		$id	.= ':'.$this->getState('filter.search');
		$id	.= ':'.$this->getState('filter.parent_id');

		return parent::getStoreId($id);
	}

	/**
	 * Builds an SQL query to load the list data.
	 *
	 * @return	JDatabaseQuery	A query object.
	 */
	protected function getListQuery()
	{
		// Create a new query object.
		$db		= $this->getDbo();
		$query	= $db->getQuery(true);
		$user	= JFactory::getUser();
		$app	= JFactory::getApplication();

		// Select all fields from the table.
		$query->select($this->getState('list.select', 'a.*'));
		$query->from('#__menu AS a');

		// Join over the language
		$query->select('l.title AS language_title, l.image as image');
		$query->join('LEFT', '#__languages AS l ON l.lang_code = a.language');

		// Join over the users.
		$query->select('u.name AS editor');
		$query->join('LEFT', '#__users AS u ON u.id = a.checked_out');

		//Join over components
		$query->select('c.element AS componentname');
		$query->join('LEFT', '#__extensions AS c ON c.extension_id = a.component_id');

		// Join over the asset groups.
		$query->select('ag.title AS access_level');
		$query->join('LEFT', '#__viewlevels AS ag ON ag.id = a.access');

		// Join over the associations.
		if ($app->get('menu_associations', 0)) {
			$query->select('COUNT(asso2.id)>1 as association');
			$query->join('LEFT', '#__associations AS asso ON asso.id = a.id AND asso.context='.$db->quote('com_menus.item'));
			$query->join('LEFT', '#__associations AS asso2 ON asso2.key = asso.key');
			$query->group('a.id');
		}

		// Exclude the root category.
		$query->where('a.id > 1');
		$query->where('a.client_id = 1');

		// Filter on the published state.
		$published = $this->getState('filter.published');
		if (is_numeric($published)) {
			$query->where('a.published = '.(int) $published);
		} elseif ($published === '') {
			$query->where('(a.published IN (0, 1))');
		}

		// Filter by search in title, alias or id
		if ($search = trim($this->getState('filter.search'))) {
			if (stripos($search, 'id:') === 0) {
				$query->where('a.id = '.(int) substr($search, 3));
			} elseif (stripos($search, 'link:') === 0) {
				if ($search = substr($search, 5)) {
					$search = $db->Quote('%'.$db->getEscaped($search, true).'%');
					$query->where('a.link LIKE '.$search);
				}
			} else {
				$search = $db->Quote('%'.$db->getEscaped($search, true).'%');
				$query->where('('.'a.title LIKE '.$search.' OR a.alias LIKE '.$search.' OR a.note LIKE '.$search.')');
			}
		}

		// Filter the items over the parent id if set.
		$parentId = $this->getState('filter.parent_id');
		if (!empty($parentId)) {
			$query->where('p.id = '.(int)$parentId);
		}

		// Filter the items over the menu id if set.
        $query->where('a.menutype = '.$db->quote('admin'));

		// Filter on the access level.
		if ($access = $this->getState('filter.access')) {
			$query->where('a.access = '.(int) $access);
		}

		// Implement View Level Access
		if (!$user->authorise('core.admin'))
		{
		    $groups	= implode(',', $user->getAuthorisedViewLevels());
			$query->where('a.access IN ('.$groups.')');
		}

		// Filter on the level.
		if ($level = $this->getState('filter.level')) {
			$query->where('a.level <= '.(int) $level);
		}

		// Filter on the language.
		if ($language = $this->getState('filter.language')) {
			$query->where('a.language = '.$db->quote($language));
		}

		// Add the list ordering clause.
		$query->order($db->getEscaped($this->getState('list.ordering', 'a.lft')).' '.$db->getEscaped($this->getState('list.direction', 'ASC')));

		return $query;
	}
}
