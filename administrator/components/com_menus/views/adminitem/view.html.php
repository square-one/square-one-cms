<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

defined('_JEXEC') or die;

jimport('joomla.application.component.view');

/**
 * The HTML Menus Menu Item View.
 *
 * @package		Joomla.Administrator
 * @subpackage	com_menus
 * @since		1.6
 */
class MenusViewAdminitem extends JView
{
	protected $form;
	protected $item;
	protected $modules;
	protected $state;

	/**
	 * Display the view
	 */
	public function display($tpl = null)
	{
		$this->form		= $this->get('Form');
		$this->item		= $this->get('Item');
		$this->modules	= $this->get('Modules');
		$this->state	= $this->get('State');

		// Check for errors.
		if (count($errors = $this->get('Errors'))) {
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}

		parent::display($tpl);
		$this->addToolbar();
	}

	/**
	 * Add the page title and toolbar.
	 *
	 * @since	1.6
	 */
	protected function addToolbar()
	{
		JRequest::setVar('hidemainmenu', true);

		$user		= JFactory::getUser();
		$isNew		= ($this->item->id == 0);
		$checkedOut	= !($this->item->checked_out == 0 || $this->item->checked_out == $user->get('id'));
		$canDo		= MenusHelper::getActions($this->state->get('filter.parent_id'));

		JToolBarHelper::title(JText::_($isNew ? 'COM_MENUS_VIEW_NEW_ITEM_TITLE' : 'COM_MENUS_VIEW_EDIT_ITEM_TITLE'), 'menu-add');

		// If a new item, can save the item.  Allow users with edit permissions to apply changes to prevent returning to grid.
		if ($isNew && $canDo->get('core.create')) {
			if ($canDo->get('core.edit')) {
				JToolBarHelper::apply('adminitem.apply');
			}
			JToolBarHelper::save('adminitem.save');
		}

		// If not checked out, can save the item.
		if (!$isNew && !$checkedOut && $canDo->get('core.edit')) {
			JToolBarHelper::apply('adminitem.apply');
			JToolBarHelper::save('adminitem.save');
		}

		// If the user can create new items, allow them to see Save & New
		if ($canDo->get('core.create')) {
			JToolBarHelper::save2new('adminitem.save2new');
		}

		// If an existing item, can save to a copy only if we have create rights.
		if (!$isNew && $canDo->get('core.create')) {
			JToolBarHelper::save2copy('adminitem.save2copy');
		}

		if ($isNew)  {
			JToolBarHelper::cancel('adminitem.cancel');
		} else {
			JToolBarHelper::cancel('adminitem.cancel', 'JTOOLBAR_CLOSE');
		}

	}
}
