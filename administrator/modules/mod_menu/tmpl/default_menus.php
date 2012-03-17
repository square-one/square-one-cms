<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

// No direct access.
defined('_JEXEC') or die;

require_once(JPATH_ADMINISTRATOR.'/components/com_menus/models/menus.php');
$model = JModel::getInstance('Menus', 'MenusModel');
$menus = $model->getItems();

// Note. It is important to remove spaces between elements.
$class = ((strpos($item->img, 'class:') === 0) ? 'class="icon-16-'. str_replace('class:', '', $item->img).'"' : 'style="background-image: url('.$item->img.');"');
$linkclass = 'class="icon-16-'.($item->img ? str_replace('class:', '', $item->img) : 'default').'"';
$linktype = JText::_($item->title);

for ($i = 0; $i < count($menus); $i++) : 
	if ($menus[$i]->menutype == 'admin') $view = 'adminitems';
	else $view = 'items';
    $link = JRoute::_('index.php?option=com_menus&view='.$view.'&menutype='.$menus[$i]->menutype);
    if ($i > 0) : ?><li class="node"><?php endif; ?>
    <a <?php echo $linkclass; ?> href="<?php echo $link; ?>" title="<?php echo $menus[$i]->title; ?>"><?php echo $menus[$i]->title; ?></a>
    <ul>
        <li>
            <a class="icon-16-newarticle" title="<?php echo JText::_('MOD_MENU_MENU_MANAGER_NEW_MENU') ?>" href="<?php echo JRoute::_('index.php?option=com_menus&view=item&menutype='.$menus[$i]->menutype.'&layout=edit') ?>"><?php echo JText::_('MOD_MENU_MENU_MANAGER_NEW_MENU') ?></a>
        </li>
    </ul>
    <?php if ($i < (count($menus)-1)) : ?></li><?php endif; ?>
<?php endfor; ?>
