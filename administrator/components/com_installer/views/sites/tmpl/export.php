<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    
 * @package     
 */

defined('_JEXEC') or die;

JHtml::_('behavior.multiselect');

$listOrder	= $this->escape($this->state->get('list.ordering'));
$listDirn	= $this->escape($this->state->get('list.direction'));

?>

<form action="<?php echo JRoute::_('index.php?option=com_installer&view=sites');?>" method="post" name="adminForm" id="adminForm">
  
    <fieldset>
		<div class="fltrt">
			<button type="button" onclick="Joomla.submitform('sites.export', this.form);">
				<?php echo JText::_('COM_INSTALLER_TOOLBAR_EXPORT');?></button>
			<button type="button" onclick="<?php echo JRequest::getBool('refresh', 0) ? 'window.parent.location.href=window.parent.location.href;' : '';?>  window.parent.SqueezeBox.close();">
				<?php echo JText::_('JCANCEL');?></button>
		</div>
        <div class="fltlft configuration">
			<?php echo JText::_('COM_INSTALLER_SELECT_EXTENSIONS_TO_EXPORT') ?>
		</div>
	</fieldset>
    
    <fieldset class="adminform">
        <legend>Distribution Details</legend>
        
        <label>Name: </label><input type="text" name="distro[name]" size="40" />
        <label>Description: </label><input type="text" name="distro[description]" size="40" />
    </fieldset>
    
	<?php if (count($this->items)) : ?>
    <table class="adminlist" cellspacing="1">
		<thead>
			<tr>
				<th width="20"><input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)" /></th>
				<th class="nowrap"><?php echo JText::_('COM_INSTALLER_HEADING_NAME'); ?></th>
				<th width="30px"><?php echo JText::_('COM_INSTALLER_HEADING_TYPE'); ?></th>
				<th width="30px"><?php echo JText::_('COM_INSTALLER_HEADING_FOLDER'); ?></th>
				<th><?php echo JText::_('COM_INSTALLER_HEADING_CLIENT'); ?></th>
				<th><?php echo JText::_('COM_INSTALLER_HEADING_DETAILSURL'); ?></th>
			</tr>
		</thead>
		<tbody>
		<?php foreach($this->items as $i=>$item) : ?>
			<tr class="row<?php echo $i%2; ?>">
				<td><?php echo JHtml::_('grid.id', $i, $item->extension_id, false, 'cid'); ?></td>
				<td><?php echo JText::_($item->name); ?></td>
				<td class="center"><?php echo JText::_('COM_INSTALLER_TYPE_' . $item->type) ?></td>
				<td class="center"><?php echo ($item->folder != '') ? $item->folder : JText::_('COM_INSTALLER_TYPE_NONAPPLICABLE'); ?></td>
				<td class="center"><?php echo $item->client_id ? JText::_('JADMINISTRATOR') : JText::_('JSITE'); ?></td>
				<td><?php echo $item->detailsurl ?></td>
			</tr>
		<?php endforeach;?>
		</tbody>
	</table>
	<?php else : ?>
		<p class="nowarning"><?php echo JText::_('COM_INSTALLER_MSG_NOEXTENSIONS'); ?></p>
	<?php endif; ?>

	<div>
		<input type="hidden" name="task" value="export" />
		<?php echo JHtml::_('form.token'); ?>
	</div>
</form>
