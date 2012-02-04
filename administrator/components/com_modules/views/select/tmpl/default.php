<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	com_modules
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access.
defined('_JEXEC') or die;

// Include the component HTML helpers.
JHtml::addIncludePath(JPATH_COMPONENT.'/helpers/html');
JHtml::_('behavior.tooltip');

$split = ceil(count($this->items) / 2);

?>

<h2 class="modal-title"><?php echo JText::_('COM_MODULES_TYPE_CHOOSE')?></h2>

<ul class="new-modules-list">
<?php for ($i = 0; $i < $split; $i++) : ?>
	<li>
		<?php
		// Prepare variables for the link.
        $item   = $this->items[$i];
		$link	= 'index.php?option=com_modules&task=module.add&eid='. $item->extension_id;
		$name	= $this->escape($item->name);
		$desc	= $this->escape($item->desc);
		?>
		<span class="editlinktip hasTip" title="<?php echo $name.' :: '.$desc; ?>">
			<a href="<?php echo JRoute::_($link);?>" target="_top">
				<?php echo $name; ?></a></span>
	</li>
<?php endfor; ?>
</ul>

<ul class="new-modules-list">
<?php for ($i = $split; $i < count($this->items); $i++) : ?>
	<li>
		<?php
		// Prepare variables for the link.
        $item   = $this->items[$i];
		$link	= 'index.php?option=com_modules&task=module.add&eid='. $item->extension_id;
		$name	= $this->escape($item->name);
		$desc	= $this->escape($item->desc);
		?>
		<span class="editlinktip hasTip" title="<?php echo $name.' :: '.$desc; ?>">
			<a href="<?php echo JRoute::_($link);?>" target="_top">
				<?php echo $name; ?></a></span>
	</li>
<?php endfor; ?>
</ul>

<div class="clr"></div>
