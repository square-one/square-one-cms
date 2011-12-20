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
$class = 'class="disabled icon-16-'.($item->img ? str_replace('class:', '', $item->img) : 'default').'"';
?><a <?php echo $class ?>><?php echo JText::_($item->title); ?></a>