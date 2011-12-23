<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

// No direct access.
defined('_JEXEC') or die;

JModel::addIncludePath(JPATH_ADMINISTRATOR.'/components/com_menus/models');
$model = JModel::getInstance('Menus', 'MenusModel');
$menus = $model->getItems();

// Note. It is important to remove spaces between elements.
$linkclass = 'class="icon-16-'.($item->img ? str_replace('class:', '', $item->img) : 'default').'"';
$linktype = JText::_($item->title);

for ($i = 0; $i < count($menus); $i++) : 
	if ($menus[$i]->menutype == 'admin') $view = 'adminitems';
	else $view = 'items';
    $link = JRoute::_('index.php?option=com_menus&view='.$view.'&menutype='.$menus[$i]->menutype);
    if ($i > 0) : ?><li<?php echo $class ?>><?php endif; ?>
    <a <?php echo $linkclass; ?>href="<?php echo $link; ?>" title="<?php echo $menus[$i]->title; ?>"><?php echo $menus[$i]->title; ?></a>
    <?php if ($i < (count($menus)-1)) : ?></li><?php endif; ?>
<?php endfor; ?>
