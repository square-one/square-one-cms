<?php
/**
 * @package     Square One
 * @link        www.squareonecms.org
 * @copyright   Copyright 2011 Square One and Open Source Matters. All Rights Reserved.
 */

// No direct access.
defined('_JEXEC') or die;

// Note. It is important to remove spaces between elements.
$class = ((strpos($item->img, 'class:') === 0) ? 'class="disabled icon-16-'. str_replace('class:', '', $item->img).'"' : 'class="disabled" style="background-image: url('.$item->img.');"');
?>
<a <?php echo $class; ?>href="<?php echo $item->flink; ?>" title="<?php echo JText::_($item->title); ?>"><?php echo JText::_($item->title); ?></a>