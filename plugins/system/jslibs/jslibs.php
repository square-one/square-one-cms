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
		JavascriptLibraries::seed_document_head();

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
	 * @return void
	 * @throws JavascriptException
	 */
	static public function seed_document_head()
	{
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
			 * TODO: handle CDNs. Adding the script to the document object may
			 * ultimately work best as a separate function.
			 *
			 */
			if ($lib_name == 'jquery') {
				self::add_jquery($records[$min_version]);
			} else {
				self::add_javascript_path($records[$min_version]);
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

		// finally, send into noConflict mode immediately
		self::add_javascript_path('plugins/system/jslibs/jquery_no_conflict.js');
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
