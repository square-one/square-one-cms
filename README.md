# Square One CMS

Square One is a distribution of Joomla! It is being designed to be a base to build custom distributions on top of as well as a light version of Joomla. 

## How to use Square One

If you know Joomla, then you will find Square One to be almost exactly the same. The major differences are many core extensions were removed, there are no additional frontend templates, you can reinstall the removed core extensions, the installer does not have sample content, and the branding was changed to Square One.

You can download Square One two ways. Go to https://github.com/square-one/square-one-cms/downloads and you will see a list of download packages. These are the official releases. If you want to test the more recent version, use the 'Download as zip/tar.gz' buttons to get a copy of the most current code. Be sure you are on the staging branch, which you should be on by default.

To use the new Core Extensions installer, simply to go the Extension Manager. There you can find the list of extensions, and select ones to install. They are downloaded and installed directly without having to do it manually.

## Goals for Square One

Square One is being designed to fit specific needs, which primarily focus around making a more streamlined version of Joomla that doesn't include a lot of what are called 'core' extensions. It does not attempt to do suit everyone's needs or wishes though, as it has a specific purpose to fill. The main goals are:

 * Simplify Joomla by removing core extensions, particularly ones that are old.
 * Make it possible to reinstall most of the removed extensions as separate packages.
 * Tweak the CMS slightly to provide some additional basic features that improve simplicity.
 * Keep a focus on simplicity and being a solid base for development.
 * Stay in sync with the Joomla Platform and Joomla CMS.

Just because Square One has removed a feature or functionality doesn't mean that it isn't useful. The mindset is to create a baseline for Joomla! which has the fewest number of default extensions while still being capable of being a CMS.

## Differences between Joomla! and Square One

See the wiki for full details, but the main differences are the removed core extensions, tweaks to the administrator and front-end templates, addition of new installation features, and a different administrator menu system.

The Joomla! Platform (also known as the framework) will remain as is. The only changes pushed to the platform will be extreme circumstances where a removed portion of the CMS is coupled with the platform. In those cases the patch will be forwarded to the platform project if necessary. The idea is to retain full Joomla compatibility by keeping the framework in sync with Joomla.

Square One will also function on a release cycle along with Joomla! Once it is ready for public use, whenever Joomla! has a new release, Square One will follow shortly after with the same numbering system.

#### Items removed (60 extensions)

##### Components

* com_banners - Banners component
* com_contact - Contacts component
* com_finder - Finder component
* com_messages - Messages component 
* com_newsfeeds - Newsfeeds component
* com_redirect - Redirect component
* com_search - Search component
* com_weblinks - Weblinks component 
* com_wrapper - Wrapper component

##### Frontend Modules

* mod_articles_archive - Archived Articles module
* mod_articles_categories - Content Categories module
* mod_articles_category - Content Category module
* mod_articles_latest - Latest Articles module
* mod_articles_news - Articles Newsflash module
* mod_articles_popular - Most Popular Articles module
* mod_banners - Banners module
* mod_finder - Finder module
* mod_footer - Footer module
* mod_random_image - Random Image module
* mod_related_items - Related Items module
* mod_search - Search module
* mod_stats - Stats module
* mod_syndicate - Syndicate module
* mod_users_latest - Latest users module
* mod_weblinks - Weblinks module
* mod_whoisonline - Who is online module
* mod_wrapper - Wrapper module

##### Plugins

* plg_authentication_gmail - Gmail authentication plugin
* plg_authentication_ldap - LDAP authentication plugin
* plg_content_emailcloak - Emailcloak content plugin
* plg_content_geshi - Geshi content plugin
* plg_content_loadmodule - Load Module content plugin
* plg_content_pagebreak - Page Break content plugin
* plg_content_pagenavigation - Page Navigation content plugin
* plg_content_vote - Vote content plugin
* plg_editors_codemirror - Codemirror editor plugin
* plg_editors_tinymce - TinyMCE editor plugin
* plg_editors-xtd_article - Article editor button plugin
* plg_editors-xtd_image - Image editor button plugin
* plg_editors-xtd_pagebreak - Page Break editor button plugin
* plg_editors-xtd_readmore - Readmore editor button plugin
* plg_finder_categories - Categories finder plugin
* plg_finder_contacts - Contacts finder plugin
* plg_finder_content - Content finder plugin
* plg_finder_newsfeeds - Newsfeeds finder plugin
* plg_finder_weblinks - Weblinks finder plugin
* plg_search_categories - Categories search plugin
* plg_search_contacts - Contacts search plugin
* plg_serach_content - Content search plugin
* plg_search_newsfeeds - Newsfeeds search plugin
* plg_search_weblinks - Weblinks search plugin
* plg_system_highlight - Highlight system plugin
* plg_system_redirect - Redirect system plugin
* plg_user_contactcreator - Contactcreator user plugin
* plg_user_profile - Profile user plugin

##### Templates

* tpl_beez5 - Beez5 template
* tpl_beez_20 - Beez_20 template
* tpl_atomic - Atomic template
* tpl_hathor - Hathor Administrator template

##### Miscellaneous

* Sample data from installer

#### Changes
 * Administrator menu is now customizable and managed in the Menu Manager
 * Improved installation process, new distribution package
 * Updated templates
 * Updater system syncs with a new update feed for Square One
 * Renamed to Square One
 * Installer process no longer has sample data as an option
 * New panel in Extension Manager to install core extensions

## This sounds great, but how do I get started?

If you are having trouble getting this setup or running, you should clone the git repository into your local server. Then you can just go to the web root of that directory and install. When cloning, you do not need to delete the installation directory, as the security check is disabled except on the official releases.

If you want to contribute, you will need a github account, and a working knowledge of how to use git for source code management. Please open a new issue for any ideas or suggestions, especially if code will be committed to it.

## Who is running this?

Jeremy Wilken of [Gnome on the run](www.gnomeontherun.com) is heading this initiative. You can help too, just check out the mailing list to start, and more information is on the wiki.

## Legal info

Square One is primarily Joomla! code, and except in cases where code has been modified or added for Square One, the Joomla! project retains the copyright on those materials. The rest is copyright of the individual authors.

Joomla! is Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.
Square One is Copyright (C) 2011-2012 Gnome on the run. All rights reserved.
Joomla! and Square One are both distributed under the GNU General Public License v2.0 or later