<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	mod_version
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access.
defined('_JEXEC') or die;

if (!empty($version)) :
echo '<p align="center">' . str_replace('Joomla!', 'Square One', $version);
if ($params->get('product', 1)) echo ' (Joomla! '.JVERSION.')';
echo '</p>';
endif;