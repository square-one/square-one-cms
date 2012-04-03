<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

// No direct access.
defined('_JEXEC') or die;

// Note. It is important to remove spaces between elements.
$class = ((strpos($item->img, 'class:') === 0) ? 'class="icon-16-'. str_replace('class:', '', $item->img).'"' : 'style="background-image: url('.$item->img.');"');
?>
<a href="#" <?php echo $class ?>><?php echo JText::_($item->title); ?></a>