# Square-one

Square-one is a light distribution of Joomla! It is being designed to meet the needs of developers who want a cleaner installation than Joomla. It removes many of the core extensions that are not required, so that you can install only the extensions that you need for your website.

## Can I use Square-one?

I wouldn't just yet. The update notification system has not been reconfigured yet to make this a self-updating distribution like Joomla. Feel free to test it out and provide some feedback. For production websites, please do not use this until its ready.

## Differences between Joomla! and Square-one

At this point, the only real differences are what is missing. In the future it might include some minor tweaks or additions.

The Joomla! Platform (also known as the framework) will remain as is. The only changes pushed to the platform will be extreme circumstances where a removed portion of the CMS is coupled with the platform. In those cases the patch will be forwarded to the platform project if necessary. The idea is to retain full Joomla compatibility by keeping the framework in sync with Joomla.

Square-one will also function on a release cycle along with Joomla! Once it is ready for public use, whenever Joomla! has a new release, Square-one will follow shortly after with the same numbering system.

####Items removed:

* Weblinks component 
* Weblinks module
* Weblinks search plugin
* Banners component
* Banners module
* Newsfeeds component
* Newsfeeds search plugin
* Contacts component
* Contacts search plugin
* Contactcreator user plugin
* Messages component 
* Footer module (frontend)
* Stats module (frontend)
* Random Image module (frontend)
* Who is online module (frontend)
* Latest users module (frontend)
* Gmail authentication plugin
* LDAP authentication plugin
* Codemirror editor plugin
* Geshi content plugin
* Beez5 template (frontend)
* Beez_20 template (frontend)
* Atomic template (frontend)
* Hathor template (administrator)
* Sample data from installer

## This sounds great, but how do I get started?

If you are having trouble getting this setup or running, you should clone the git repository into your local server. Then you can install Joomla like normal.

If you want to contribute, you will need a github account, and a working knowledge of how to use git for source code management. Please open a new issue for any ideas or suggestions, especially if code will be committed to it.

## Who is running this?

Jeremy Wilken of Gnome on the run (www.gnomeontherun.com) is heading this initiative to give the Joomla community an option for a lighter weight distribution.

## Legal info

Joomla! is Copyright (C) 2005 - 2011 Open Source Matters. All rights reserved.
Joomla! and Square-one are both distributed under the GNU General Public License v2.0 or later