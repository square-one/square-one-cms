<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    
 * @package     
 */

require_once "/usr/share/php/phing/Task.php";

class ChangelogTask extends Task {
    
    /**
     * Changelog file
     */
    private $tofile = 'installation/CHANGELOG';
    
    /**
     * Changelog template
     */
    private $template = 'squareone.txt';
    
    /**
     * Setter for $filename
     */
    public function setTofile($str)
    {
        $this->tofile = $str;
    }
    
    /**
     * Setter for $filename
     */
    public function setTemplate($str)
    {
        $this->template = $str;
    }
    
    /**
     * init step
     */
    public function init()
    {
        
    }
    
    /**
     * Main function
     */
    public function main()
    {
        $this->log('Starting changelog generation, please wait...');
        
        $command = 'git log --no-merges --format="%cd" --date=short | sort -u -r | while read DATE ; do
    echo
    echo [$DATE]
    GIT_PAGER=cat git log --no-merges --format=" * %s" --since=$DATE --until=$NEXT
    NEXT=$DATE
	';
        
        exec($command, $response);
        
        $template = file_get_contents(dirname(__FILE__).'/changelog/'.$this->template);
        
        $data = $template.implode(PHP_EOL, $response);
        
        file_put_contents($this->tofile, $data);
        
        $this->log('Generated changelog at ' . $this->tofile);
    }
}