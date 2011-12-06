# Square One CMS

Square One is a light distribution of Joomla! It is being designed to meet the needs of developers who want a cleaner installation than Joomla. It removes many of the core extensions that are not required, so that you can install only the extensions that you need for your website.

## How to use Square One

If you know Joomla, then you will find Square One to be almost exactly the same. The major differences are many core extensions were removed, there are no additional frontend templates, you can reinstall the removed core extensions, the installer does not have sample content, and the branding was changed to Square One.

You can download Square One two ways. Go to https://github.com/gnomeontherun/square-one-cms/downloads and you will see a list of download packages. These are the official releases. If you want to test the more recent version, use the 'Download as zip/tar.gz' buttons to get a copy of the most current code. Be sure you are on the staging branch, which you should be on by default.

To use the new Core Extensions installer, simply to go the Extension Manager -> Core Extensions. There you can find the list of extensions, and select ones to install. They are downloaded and installed directly without having to do it manually.

## Goals for Square One

Square One is being designed to fit specific needs, which primarily focus around making a more streamlined version of Joomla that doesn't include a lot of what are called 'core' extensions. It does not attempt to do suit everyone's needs or wishes though, as it has a specific purpose to fill. The main goals are:

 * Simplify Joomla by removing core extensions, particularly ones that are old.
 * Make it possible to reinstall most of the removed extensions as separate packages.
 * Tweak the CMS slightly to provide some additional basic features that improve simplicity.
 * Keep a focus on simplicity and being a solid base for development.
 * Stay in sync with the Joomla Platform and Joomla CMS.

Just because Square One has removed a feature or functionality doesn't mean that it isn't useful. The mindset is to create a baseline for Joomla! which has the fewest number of default extensions while still being capable of being a CMS.
 
## Can I use Square One?

You can use Square One for testing, and the timeline is to provide a stable release soon after the Joomla 2.5 release is made. Using it for a production website is not advised until then.

## Differences between Joomla! and Square One

At this point, the only real differences are what is missing. In the future it might include some minor tweaks or additions.

The Joomla! Platform (also known as the framework) will remain as is. The only changes pushed to the platform will be extreme circumstances where a removed portion of the CMS is coupled with the platform. In those cases the patch will be forwarded to the platform project if necessary. The idea is to retain full Joomla compatibility by keeping the framework in sync with Joomla.

Square One will also function on a release cycle along with Joomla! Once it is ready for public use, whenever Joomla! has a new release, Square One will follow shortly after with the same numbering system.

#### Items removed

#####Components

* Weblinks component 
* Banners component
* Newsfeeds component
* Contacts component
* Messages component 
* Redirect component
* Wrapper component

#####Modules

* Weblinks module
* Banners module
* Footer module (frontend)
* Syndicate module (frontend)
* Stats module (frontend)
* Random Image module (frontend)
* Who is online module (frontend)
* Latest users module (frontend)
* Wrapper module

#####Plugins

* Weblinks search plugin
* Newsfeeds search plugin
* Contacts search plugin
* Contactcreator user plugin
* Vote content plugin
* Page Navigation content plugin
* Gmail authentication plugin
* LDAP authentication plugin
* Codemirror editor plugin
* Geshi content plugin
* Emailcloak content plugin
* Redirect system plugin

#####Templates

* Beez5 template (frontend)
* Beez_20 template (frontend)
* Atomic template (frontend)
* Hathor template (administrator)

#####Miscellaneous

* Sample data from installer

#### Changes
 * Updater system syncs with a new update feed for Square One
 * Renamed to Square One
 * Installer process no longer has sample data as an option
 * New panel in Extension Manager to install core extensions

## This sounds great, but how do I get started?

If you are having trouble getting this setup or running, you should clone the git repository into your local server. Then you can just go to the web root of that directory and install. When cloning, you do not need to delete the installation directory, as the security check is disabled except on the official releases.

If you want to contribute, you will need a github account, and a working knowledge of how to use git for source code management. Please open a new issue for any ideas or suggestions, especially if code will be committed to it.

## Who is running this?

Jeremy Wilken of Gnome on the run (www.gnomeontherun.com) is heading this initiative to give the Joomla! community an option for a lighter weight distribution.

## Legal info

Square One is primarily Joomla! code, and except in cases where code has been modified or added for Square One, the Joomla! project retains the copyright on those materials. The rest is copyright of the individual authors.

Joomla! is Copyright (C) 2005 - 2011 Open Source Matters. All rights reserved.
Square One is Copyright (C) 2011 Gnome on the run. All rights reserved.
Joomla! and Square One are both distributed under the GNU General Public License v2.0 or later