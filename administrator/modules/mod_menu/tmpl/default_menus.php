<?php
/**
 * @version		$Id$
 * @package		Joomla.Site
 * @subpackage	mod_menu
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
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
    $link = JRoute::_('index.php?option=com_menus&view=items&menutype='.$menus[$i]->menutype);
    if ($i > 0) : ?><li<?php echo $class ?>><?php endif; ?>
    <a <?php echo $linkclass; ?>href="<?php echo $link; ?>" title="<?php echo $menus[$i]->title; ?>"><?php echo $menus[$i]->title; ?></a>
    <?php if ($i < (count($menus)-1)) : ?></li><?php endif; ?>
<?php endfor; ?>
