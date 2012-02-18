<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

// No direct access.
defined('_JEXEC') or die;

// Note. It is important to remove spaces between elements.
$class = 'class="disabled icon-16-'.($item->img ? str_replace('class:', '', $item->img) : 'default').'"';
?>
<a <?php echo $class ?>><?php echo JText::_($item->title); ?></a>