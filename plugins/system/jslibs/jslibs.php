<?php
/**
 * @copyright	Copyright (C) 2012 Joseph L. LeBlanc
 * @license		GNU General Public License version 2 or later
 */

defined( '_JEXEC' ) or die;

/**
 * This class strictly responds to plugin events, leaving the heavy lifting
 * to the JavascriptLibraries class.
 *
 */
class plgSystemJslibs extends JPlugin
{
	/**
	 * This event handler calls the JavaScript library to seed the document
	 * header.
	 *
	 * @return boolean
	 */
	public function onBeforeCompileHead()
	{
		JavascriptLibraries::seed_document_head($this->params);

		return true;
	}
}

/**
 * Ideally, this would be installed as a library. For the sake of
 * simplicity, we're currently placing the class here to avoid the
 * overhead of creating a completely different extension for one class.
 *
 */

class JavascriptException extends Exception {}

class JavascriptLibraries
{
	/**
	 * A catalog of libraries and paths
	 *
	 * @var array
	 */
	static public $libraries = array();

	/**
	 * Keeps track of scripts depending on libraries, keyed by library name
	 *
	 * @var array
	 */
	static public $scripts = array();


	/**
	 * Toggles whether jQuery.noConflict() gets called.
	 *
	 * @var bool
	 */
	static public $jquery_no_conflict = true;

	/**
	 * A quick and dirty check to see if a particular library has already been
	 * loaded. Assumes that the library is already loaded if a JavaScript file
	 * with the search string is present.
	 *
	 * @param string $lib_name
	 * @return boolean
	 * @author Joseph LeBlanc
	 */
	static public function library_loaded($lib_name)
	{
		$document = JFactory::getDocument();

		$head_data = $document->getHeadData();

		foreach (array_keys($head_data['scripts']) as $script) {
			if (stristr($script, $lib_name)) {
				return true;
			}
		}

		return false;
	}

	/**
	 * A convenience wrapper for library_loaded.
	 *
	 * @return boolean
	 * @author Joseph LeBlanc
	 */
	static public function jquery_loaded()
	{
		return self::library_loaded('jquery');
	}

	/**
	 * Convenience function for setting jquery_no_conflict
	 *
	 * @param bool $value
	 * @return void
	 * @author Joseph LeBlanc
	 */
	static public function jquery_no_conflict($value)
	{
		self::$jquery_no_conflict = (bool) $value;
	}

	/**
	 * Registers a request to use a specific JavaScript library with a desired
	 * minimum version. The name is set to lowercase before use. If the path
	 * is to a JavaScript file on the local filesystem, it is checked before
	 * being added. If it does not exist, an error is thrown.
	 *
	 * @param string $name
	 * @param string $min_version
	 * @param string $path
	 * @throws JavascriptException
	 * @author Joseph LeBlanc
	 */
	static public function register_library($name, $min_version, $path)
	{
		$name = strtolower($name);

		// if it's a local file, check to make sure it exists before adding.
		if (stripos($path, 'http') !== 0) {
			if (!JFile::exists(JPATH_ROOT . '/' . $path)) {
				$error = JText::sprintf('PLG_SYSTEM_JSLIBS_EXCEPTION_FILE_NOT_FOUND', $name, $path);
				throw new JavascriptException($error);
			}
		}

		self::$libraries[$name][$min_version] = $path;
	}

	public function register_script($path, $relies_on)
	{
		$relies_on = strtolower($relies_on);

		if (is_array(self::$scripts[$relies_on]) && !in_array($path, self::$scripts[$relies_on])) {
			self::$scripts[$relies_on][] = $path;
		} else {
			self::$scripts[$relies_on] = array($path);
		}
	}

	/**
	 * This function takes the accumulated JavaScript libraries and scripts,
	 * adding them into the document object before it is used to generate the
	 * head section of the document. The minimum acceptable version of the
	 * JavaScript library is used.
	 *
	 * @param JRegistry $params - Object with the plugin's configuration info
	 * @return void
	 * @throws JavascriptException
	 */
	static public function seed_document_head($params)
	{
		$cdn = new JavascriptLibrariesCDN($params);

		foreach (self::$libraries as $lib_name => $records) {

			$min_version = '0.0.0';

			foreach ($records as $version => $record) {
				if (version_compare($min_version, $version, '<')) {
					$min_version = $version;
				}
			}

			/**
			 * If somehow version_compare failed and no acceptable minimum
			 * version is found, throw an exception
			 *
			 */
			if ($min_version == '0.0.0') {
				$error = JText::sprintf('PLG_SYSTEM_JSLIBS_EXCEPTION_NO_ACCEPTABLE_LIB', $lib_name);
				throw new JavascriptException($error);
			}

			/**
			 * Get the CDN URL for the library. If none is available, fallback.
			 * to the local copy
			 *
			 */
			$lib_path = $cdn->get_cdn_url($lib_name, $min_version);

			if (!$lib_path) {
				$lib_path = $records[$min_version];
			}

			/**
			 * TODO: handle CDNs. Adding the script to the document object may
			 * ultimately work best as a separate function.
			 *
			 */
			if ($lib_name == 'jquery') {
				self::add_jquery($lib_path);
			} else {
				self::add_javascript_path($lib_path);
			}

			/**
			 * Finally, add all of the scripts that rely on this library
			 *
			 */
			if (isset(self::$scripts[$lib_name])) {
				foreach (self::$scripts[$lib_name] as $script) {
					self::add_javascript_path($script);
				}
			}
		}
	}

	/**
	 * This function handles adding jQuery specifically, putting it into
	 * noConflict mode immediately.
	 *
	 * @param string $min_version_path
	 * @return void
	 * @author Joseph LeBlanc
	 */
	static public function add_jquery($min_version_path)
	{
		if (self::jquery_loaded()) {
			return false;
		}

		self::add_javascript_path($min_version_path);

		// finally, send into noConflict mode immediately (if set)
		if (self::$jquery_no_conflict) {
			self::add_javascript_path('plugins/system/jslibs/jquery_no_conflict.js');
		}
	}

	/**
	 * Given a local path or a URL to a JavaScript file, this function adds
	 * it to the document head.
	 *
	 * @param string $path
	 * @return void
	 * @author Joseph LeBlanc
	 */
	static public function add_javascript_path($path)
	{
		$doc = JFactory::getDocument();

		if (stripos($path, 'http') === 0) {
			$doc->addScript($path);
		} else {
			$doc->addScript(JURI::base() . $path);
		}
	}
}

class JavascriptLibrariesCDN
{
	public $bases = array(
		'google' => 'ajax.googleapis.com/ajax/libs/',
		'microsoft' => 'ajax.aspnetcdn.com/ajax/'
	);

	public $min_versions = array(
		'google' => array(
			'chrome-frame' => '1.0.0',
			'dojo' => '1.1.1',
			'ext-core' => '3.0.0',
			'jquery' => '1.2.3',
			'jqueryui' => '1.5.2',
			'mootools' => '1.1.1',
			'prototype' => '1.6.0.2',
			'scriptaculous' => '1.8.1',
			'swfobject' => '2.1',
			'webfont' => '1.0.0'
		),
		'microsoft' => array( // uses dots instead of dashes, and jqueryui is jquery.ui
			'jquery' => '1.3.2',
			'jqueryui' => '1.8.5'
		)
	);

	public $cdn_formats = array(
		'google' => array(
			'chrome-frame' => 'chrome-frame/%s/CFInstall.min.js',
			'dojo' => 'dojo/%s/dojo/dojo.js',
			'ext-core' => 'ext-core/%s/ext-core.js',
			'jquery' => 'jquery/%s/jquery.min.js',
			'jqueryui' => 'jqueryui/%s/jquery-ui.min.js',
			'mootools' => 'mootools/%s/mootools-yui-compressed.js',
			'prototype' => 'prototype/%s/prototype.js',
			'scriptaculous' => 'scriptaculous/%s/scriptaculous.js',
			'swfobject' => 'swfobject/%s/swfobject.js',
			'webfont' => 'webfont/%s/webfont.js'
		),
		'microsoft' => array(
			'jquery' => 'jQuery/jquery-%s.min.js',
			'jqueryui' => 'jquery.ui/%s/jquery-ui.min.js'
		)
	);

	public $params; // Plugin preferences
	public $overrides;

	public function __construct($params)
	{
		$this->params = $params;
	}

	public function get_cdn_url($library, $version)
	{
		// check for override, if it exists for the library, use regardless of version
		$override = $this->get_cdn_override($library);

		if ($override) {
			return $override;
		}

		// check for the selected CDN. If 'none' is selected, skip the rest
		$selected_cdn = $this->params->get('cdn');

		if ($selected_cdn == '') {
			return false;
		}

		return $this->make_cdn_url($selected_cdn, $library, $version);
	}

	public function make_cdn_url($cdn, $library, $version)
	{
		if (!isset($this->min_versions[$cdn][$library])) {
			return false;
		}

		if (version_compare($version, $this->min_versions[$cdn][$library], '<')) {
			return false;
		}

		$uri = JURI::getInstance();

		return $uri->getScheme() . '://' . $this->bases[$cdn] . sprintf($this->cdn_formats[$cdn][$library], $version);
	}

	public function get_cdn_override($library)
	{
		if (!isset($this->overrides)) {
			$this->overrides = array();

			$lines = explode("\n", $this->params->get('overrides'));

			foreach ($lines as $line) {
				if (strlen($line)) {
					list($lib, $url) = explode(',', $line);
					$this->overrides[$lib] = $url;
				}
			}
		}

		if (isset($this->overrides[$library])) {
			return $this->overrides[$library];
		}

		return false;
	}
}
