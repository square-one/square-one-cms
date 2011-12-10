<?php
/**
 * @version		$Id$
 * @package		Joomla.Site
 * @copyright	Copyright (C) 2005 - 2011 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;
if (!isset($this->error)) {
	$this->error = JError::raiseWarning(404, JText::_('JERROR_ALERTNOAUTHOR'));
	$this->debug = false;
}
//get language and direction
$doc = JFactory::getDocument();
$this->language = $doc->language;
$this->direction = $doc->direction;
$baseUrl	= JURI::base();
$template 	= 'templates/'.$this->template;
?>
<!doctype html>
<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="<?php echo substr($this->language, 0, 2); ?>"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="<?php echo substr($this->language, 0, 2); ?>"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="<?php echo substr($this->language, 0, 2); ?>"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="<?php echo substr($this->language, 0, 2); ?>"> <!--<![endif]-->
<head>
	<title><?php echo $this->error->getCode(); ?> - <?php echo $this->title; ?></title>
	<link rel="stylesheet" href="<?php echo $this->baseurl; ?>/templates/system/css/normalize.css" type="text/css" />
	<link rel="stylesheet" href="<?php echo $this->baseurl; ?>/templates/system/css/template.css" type="text/css" />
	<link rel="stylesheet" href="<?php echo $this->baseurl; ?>/templates/system/css/error.css" type="text/css" />
	<?php if ($this->direction == 'rtl') : ?>
	<link rel="stylesheet" href="<?php echo $this->baseurl; ?>/templates/system/css/error_rtl.css" type="text/css" />
	<?php endif; ?>
	<!--[if !IE 7]>
		<style type="text/css">
			#footer-push {display:table;height:100%}
		</style>
	<![endif]-->
</head>
<body>
<div id="footer-push">

	<header class="clearfix">
	 <div class="inner">
		<h1>
		  <a href="<?php echo $baseUrl; ?>"><img src="<?php echo $baseUrl.$template; ?>/images/square-one-logo.png" /></a>
		</h1>
	</div>
	</header>

	<div class="error">
		<div id="outline">
		<div id="errorboxoutline">
			<div id="errorboxheader"><?php echo $this->error->getCode(); ?> - <?php echo $this->error->getMessage(); ?></div>
			<div id="errorboxbody">
			<p><strong><?php echo JText::_('JERROR_LAYOUT_NOT_ABLE_TO_VISIT'); ?></strong></p>
				<ol>
					<li><?php echo JText::_('JERROR_LAYOUT_AN_OUT_OF_DATE_BOOKMARK_FAVOURITE'); ?></li>
					<li><?php echo JText::_('JERROR_LAYOUT_SEARCH_ENGINE_OUT_OF_DATE_LISTING'); ?></li>
					<li><?php echo JText::_('JERROR_LAYOUT_MIS_TYPED_ADDRESS'); ?></li>
					<li><?php echo JText::_('JERROR_LAYOUT_YOU_HAVE_NO_ACCESS_TO_THIS_PAGE'); ?></li>
					<li><?php echo JText::_('JERROR_LAYOUT_REQUESTED_RESOURCE_WAS_NOT_FOUND'); ?></li>
					<li><?php echo JText::_('JERROR_LAYOUT_ERROR_HAS_OCCURRED_WHILE_PROCESSING_YOUR_REQUEST'); ?></li>
				</ol>
			<p><strong><?php echo JText::_('JERROR_LAYOUT_PLEASE_TRY_ONE_OF_THE_FOLLOWING_PAGES'); ?></strong></p>

				<ul>
					<li><a href="<?php echo $this->baseurl; ?>/index.php" title="<?php echo JText::_('JERROR_LAYOUT_GO_TO_THE_HOME_PAGE'); ?>"><?php echo JText::_('JERROR_LAYOUT_HOME_PAGE'); ?></a></li>
				</ul>

			<p><?php echo JText::_('JERROR_LAYOUT_PLEASE_CONTACT_THE_SYSTEM_ADMINISTRATOR'); ?>.</p>
			<div id="techinfo">
			<p><?php echo $this->error->getMessage(); ?></p>
			<p>
				<?php if ($this->debug) :
					echo $this->renderBacktrace();
				endif; ?>
			</p>
			</div>
			</div>
		</div>
		</div>
	</div>
</div>

    <footer>
		<div class="moduletable">
		<div class="footer1">Copyright © 2011 Square One. All Rights Reserved.</div>
		<div class="footer2"><a href="http://www.joomla.org">Joomla!</a> is Free Software released under the <a href="http://www.gnu.org/licenses/gpl-2.0.html">GNU General Public License.</a></div>		</div>
    </footer>
</body>
</html>
