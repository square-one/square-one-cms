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

// Note. It is important to remove spaces between elements.
?>

<ul id="menu">
<?php
foreach ($list as $i => &$item) :
	$class = '';
	if ($item->id == $active_id) {
		$class .= ' current';
	}

	if ($item->parent) {
		$class .= ' node';
	}

	if (!empty($class)) {
		$class = ' class="'.trim($class) .'"';
	}
    
    if ($disabled) {
		$class = ' class="disabled"';
	}
    
    if ($item->type == 'separator') {
        $class = ' class="separator"';
    }

	echo '<li'.$class.'>';

	// Render the menu item.
    if ($disabled) {
        require JModuleHelper::getLayoutPath('mod_menu', 'default_disabled');
        
    }
    else 
    {
        switch ($item->type) :
            case 'separator':
            case 'url':
            case 'component':
                require JModuleHelper::getLayoutPath('mod_menu', 'default_'.$item->type);
                break;

            default:
                require JModuleHelper::getLayoutPath('mod_menu', 'default_url');
                break;
        endswitch;
    }

	// The next item is deeper.
	if ($item->deeper) {
		echo '<ul>';
	}
	// The next item is shallower.
	elseif ($item->shallower) {
		echo '</li>';
		echo str_repeat('</ul></li>', $item->level_diff);
	}
	// The next item is on the same level.
	else {
		echo '</li>';
	}
endforeach;
?></ul>
