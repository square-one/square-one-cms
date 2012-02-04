<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

defined('_JEXEC') or die;

// Include the component HTML helpers.
JHtml::addIncludePath(JPATH_COMPONENT.'/helpers/html');

$lang = JFactory::getLanguage();
$lang->load('mod_menu', JPATH_ADMINISTRATOR);

// Load the tooltip behavior.
JHtml::_('behavior.tooltip');
JHtml::_('behavior.formvalidation');
JHtml::_('behavior.modal');
?>

<script type="text/javascript">
	Joomla.submitbutton = function(task, type)
	{
		if (task == 'adminitem.cancel' || document.formvalidator.isValid(document.id('item-form'))) {
			Joomla.submitform(task, document.id('item-form'));
		} else {
			// special case for modal popups validation response
			$$('#item-form .modal-value.invalid').each(function(field){
				var idReversed = field.id.split("").reverse().join("");
				var separatorLocation = idReversed.indexOf('_');
				var name = idReversed.substr(separatorLocation).split("").reverse().join("")+'name';
				document.id(name).addClass('invalid');
			});
		}
	}
</script>

<form action="<?php echo JRoute::_('index.php?option=com_menus&view=adminitem&layout=edit&id='.(int) $this->item->id); ?>" method="post" name="adminForm" id="item-form" class="form-validate">

<div class="width-100 fltlft">
	<fieldset class="adminform">
		<legend><?php echo JText::_('COM_MENUS_ITEM_DETAILS');?></legend>
			<ul class="adminformlist">

                <li><?php echo $this->form->getLabel('type'); ?>
				<?php echo $this->form->getInput('type'); ?></li>
                
				<li><?php echo $this->form->getLabel('component_id'); ?>
				<?php echo $this->form->getInput('component_id'); ?></li>

				<li><?php echo $this->form->getLabel('title'); ?>
				<?php echo $this->form->getInput('title'); ?></li>

				<?php if ($this->item->type =='url'): ?>
					<?php $this->form->setFieldAttribute('link', 'readonly', 'false');?>
					<li><?php echo $this->form->getLabel('link'); ?>
					<?php echo $this->form->getInput('link'); ?></li>
				<?php endif; ?>

				<?php if ($this->item->type == 'alias'): ?>
					<li> <?php echo $this->form->getLabel('aliastip'); ?></li>
				<?php endif; ?>

				<?php if ($this->item->type !='url'): ?>
					<li><?php echo $this->form->getLabel('alias'); ?>
					<?php echo $this->form->getInput('alias'); ?></li>
				<?php endif; ?>
                
                <li><?php echo $this->form->getLabel('img'); ?>
				<?php echo $this->form->getInput('img'); ?></li>

				<li><?php echo $this->form->getLabel('note'); ?>
				<?php echo $this->form->getInput('note'); ?></li>

				<?php if ($this->item->type !=='url'): ?>
					<li><?php echo $this->form->getLabel('link'); ?>
					<?php echo $this->form->getInput('link'); ?></li>
				<?php endif ?>

				<li><?php echo $this->form->getLabel('published'); ?>
				<?php echo $this->form->getInput('published'); ?></li>

				<li><?php echo $this->form->getLabel('menutype'); ?>
				<?php echo $this->form->getInput('menutype'); ?></li>

				<li><?php echo $this->form->getLabel('parent_id'); ?>
				<?php echo $this->form->getInput('parent_id'); ?></li>

				<li><?php echo $this->form->getLabel('menuordering'); ?>
				<?php echo $this->form->getInput('menuordering'); ?></li>

				<li><?php echo $this->form->getLabel('browserNav'); ?>
				<?php echo $this->form->getInput('browserNav'); ?></li>

				<li><?php echo $this->form->getLabel('id'); ?>
				<?php echo $this->form->getInput('id'); ?></li>
		</ul>

	</fieldset>
</div>


	<input type="hidden" name="task" value="" />
	<?php echo JHtml::_('form.token'); ?>
	<input type="hidden" id="fieldtype" name="fieldtype" value="" />

</form>
