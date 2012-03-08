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
	 * A quick and dirty check to see if jQuery has already been loaded.
	 * Assumes that jQuery is already loaded if a JavaScript file with the
	 * string 'jquery' is present.
	 *
	 * @return boolean
	 */
	static public function jquery_loaded()
	{
		$document = JFactory::getDocument();

		$head_data = $document->getHeadData();

		foreach (array_keys($head_data['scripts']) as $script) {
			if (stristr($script, 'jquery')) {
				return true;
			}
		}

		return false;
	}

	/**
	 * This function would determine if MooTools is loaded. Would be useful in
	 * cases where pulling a CDN copy is desired.
	 *
	 * @return boolean
	 */
	static public function mootools_loaded()
	{
		// TODO
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
	static public function register($name, $min_version, $path)
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

	/**
	 * This function takes the accumulated JavaScript libraries and adds them
	 * into the document object before it is used to generate the head
	 * section of the document
	 *
	 * @return void
	 * @throws JavascriptException
	 */
	static public function seed_document_head()
	{
		$doc = JFactory::getDocument();

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
			if ( ($lib_name != 'jquery') || ($lib_name == 'jquery' && !self::jquery_loaded()) ) {
				if (stripos($records[$min_version], 'http') === 0) {
					$doc->addScript($records[$min_version]);
				} else {
					$doc->addScript(JURI::base() . $records[$min_version]);
				}
			}
		}
	}
}
