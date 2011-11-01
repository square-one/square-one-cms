<?php
/**
 * @version		$Id$
 * @package		Joomla.Site
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

$left = $this->countModules('left');
$right = $this->countModules('right');

?>
<!DOCTYPE html>  
<html lang="<?php echo substr($this->language, 0, 2); ?>">  
<head>
    
    <meta charset="utf-8" />  
    <jdoc:include type="head" />
    <link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/system/css/general.css" type="text/css" />
    <link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/system/css/template.css" type="text/css" />
    
</head>  
<body>
    
    <div id="header">
        <a href="<?php echo $this->baseurl ?>"><img src="<?php echo $this->baseurl ?>/templates/system/images/square-one-logo.png" /></a>
        <jdoc:include type="modules" name="menu" />
        <div class="clear"></div>
    </div>
    
    <div id="main">
        
        <?php if ($left) : ?>
        <div id="left">
            <jdoc:include type="modules" name="left" style="xhtml" />
        </div>
        <?php endif; ?>
        
        <div id="content<?php echo ($left) ? '_left' : ''; echo ($right) ? '_right' : '' ?>">
            <jdoc:include type="message" />
            <jdoc:include type="component" />
        </div>
        
        <?php if ($right) : ?>
        <div id="right">
            <jdoc:include type="modules" name="right" style="xhtml" />
        </div>
        <?php endif; ?>
        
        <div class="clear"></div>
    </div>
    <div id="footer">
        <jdoc:include type="modules" name="footer" style="xhtml" />
    </div>
    
</body>
</html>