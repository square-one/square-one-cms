<?php
/**
 * @package		Joomla.Site
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

$app		= JFactory::getApplication();
$doc 		= JFactory::getDocument();
$template 	= 'templates/'.$this->template;

$column1 	= $this->countModules('column-1');
$column2 	= $this->countModules('column-2');

$doc->addStyleSheet($template.'/css/normalize.css','text/css','screen');
$doc->addStyleSheet($template.'/css/general.css','text/css','screen');
$doc->addStyleSheet($template.'/css/template.css','text/css','screen');

// Always force latest IE rendering engine (even in intranet) & Chrome Frame
$doc->addCustomTag('<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">');
// Mobile viewport optimized: j.mp/bplateviewport
$doc->addCustomTag('<meta name="viewport" content="width=device-width, initial-scale=1.0">');
$doc->addCustomTag('<meta name="copyright" content="'.$app->getCfg('sitename').'" />');

// Site icons
$doc->addFavicon($template.'/favicon.png','image/png','shortcut icon');
$doc->addFavicon($template.'/apple-touch-icon-iphone.png','image/png','apple-touch-icon');
$doc->addCustomTag('<link rel="apple-touch-icon" sizes="72x72" href="' . $template . '/apple-touch-icon-ipad.png"    />');
$doc->addCustomTag('<link rel="apple-touch-icon" sizes="114x114" href="' . $template . '/apple-touch-icon-iphone4.png" />');

// Internet Explorer Fixes
$doc->addCustomTag("\n".'  <!--[if lt IE 9]>');
$doc->addCustomTag("\n".'  <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>');
$doc->addCustomTag('<![endif]-->');
?>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="<?php echo substr($this->language, 0, 2) ?>" dir="<?php echo $this->direction ?>"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="<?php echo substr($this->language, 0, 2) ?>" dir="<?php echo $this->direction ?>"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="<?php echo substr($this->language, 0, 2) ?>" dir="<?php echo $this->direction ?>"> <![endif]-->
<!--[if gt IE 8]> <!--> <html class="no-js" lang="<?php echo substr($this->language, 0, 2) ?>" dir="<?php echo $this->direction ?>"> <!--<![endif]-->
<head>
<jdoc:include type="head" />
<!--[if !IE 7]>
	<style type="text/css">
		#footer-push {display:table;height:100%}
	</style>
<![endif]-->
</head>
<body<?php echo ($column1 || $column2) ? ' class="' . (($column1) ? 'column-1' : '') . (($column1 && $column2) ? ' ' : '') . (($column2) ? 'column-2' : ''). '"':'' ?>>

  <header class="clearfix">
	  <div class="inner">
		<h1>
		  <a href="<?php echo $this->baseurl; ?>" title="<?php echo $app->getCfg('sitename');?>"><?php echo $app->getCfg('sitename');?></a>
		</h1>

		<?php if ($this->countModules('nav')) : ?>
		<nav>
			<jdoc:include type="modules" name="nav" />
		</nav>
		<?php endif; ?>

		<jdoc:if module="header">
		<span>
			<jdoc:include type="modules" name="header" style="xhtml" />
		</span>
		</jdoc:if>
	  </div>
  </header>

  <section class="content">
    <div id="content-container" class="clearfix">
	    <div id="content-main">
			<?php if (count($app->getMessageQueue())) : ?>
				<jdoc:include type="message" />
			<?php endif; ?>

            <jdoc:include type="component" />
        </div>

        <?php if ($column2) : ?>
        <div id="column-2">
            <jdoc:include type="modules" name="column-2" style="xhtml" />
        </div>
        <?php endif; ?>

		<?php if ($column1) : ?>
		<div id="column-1">
			<jdoc:include type="modules" name="column-1" style="xhtml" />
		</div>
		<?php endif; ?>
        </div>
    </div>
  </section>


    <footer>
        <jdoc:include type="modules" name="footer" style="xhtml" />
    </footer>

</body>
</html>

