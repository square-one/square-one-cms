<?php
/**
 * @version		$Id$
 * @package		Joomla.Site
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

$baseUrl	= JURI::base();
$doc 		= JFactory::getDocument();
$template 	= 'templates/'.$this->template;

$column1 	= $this->countModules('column-1');
$column2 	= $this->countModules('column-2');

$doc->addStyleSheet($template.'/css/normalize.css','text/css','screen');
$doc->addStyleSheet($template.'/css/general.css','text/css','screen');
$doc->addStyleSheet($template.'/css/template.css','text/css','screen');

// Internet Explorer Fixes
$doc->addCustomTag("\n".'  <!--[if lt IE 9]>');
$doc->addCustomTag("\n".'  <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>');
$doc->addCustomTag('<![endif]-->');
?>
<!doctype html>
<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="<?php echo substr($this->language, 0, 2); ?>"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="<?php echo substr($this->language, 0, 2); ?>"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="<?php echo substr($this->language, 0, 2); ?>"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="<?php echo substr($this->language, 0, 2); ?>"> <!--<![endif]-->
<head>
<jdoc:include type="head" />
</head>
<body<?php echo ($column1 || $column2) ? ' class="' . (($column1) ? 'column-1' : '') . (($column1 && $column2) ? ' ' : '') . (($column2) ? 'column-2' : ''). '"':'' ?>>
  <div id="footer-push">

  <header class="clearfix">
    <h1>
      <a href="<?php echo $baseUrl; ?>"><img src="<?php echo $baseUrl.$template; ?>/images/square-one-logo.png" /></a>
    </h1>

	<?php if ($this->countModules('nav')) : ?>
	<nav>
		<jdoc:include type="modules" name="nav" />
	</nav>
	<?php endif; ?>

    <?php if ($this->countModules('header')) : ?>
    <div>
    <jdoc:include type="modules" name="header" style="xhtml" />
    </div>
    <?php endif; ?>

  </header>

    <div id="main">

	    <div id="content-main">
			<?php if ($this->getBuffer('message')) : ?>
				<jdoc:include type="message" />
			<?php endif; ?>

            <jdoc:include type="component" />
        </div>

		<?php if ($column1) : ?>
		<div id="column-1">
			<jdoc:include type="modules" name="column-1" style="xhtml" />
		</div>
		<?php endif; ?>
        
        <?php if ($column2) : ?>
        <div id="column-2">
            <jdoc:include type="modules" name="column-2" style="xhtml" />
        </div>
        <?php endif; ?>
    </div>
</div>

    <footer>
        <jdoc:include type="modules" name="footer" style="xhtml" />
    </footer>
    
</body>
</html>