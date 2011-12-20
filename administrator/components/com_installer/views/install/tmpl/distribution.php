<?php

/**
 * @author      Jeremy Wilken - Gnome on the run
 * @link        www.gnomeontherun.com
 * @copyright   Copyright 2011 Gnome on the run. All Rights Reserved.
 * @category    
 * @package     
 */

defined('_JEXEC') or die;
?>

<?php if ($this->result) : ?>

Tasks to run:

<ul id="distro_tasks">
    <?php foreach ($this->result->extensions->xpath('//extension') as $extension) : if (isset($extension['detailsurl'])) : ?>
    <li data-detailsurl="<?php echo urlencode($extension['detailsurl']); ?>" data-type="extension">
        <?php echo $extension['name']; ?>
    </li>
    <?php endif; endforeach; ?>
    <?php if (isset($this->result->install)) : ?>
    <li>Install SQL</li>
    <?php endif; ?>
    <?php if (isset($this->result->scriptfile)) : ?>
    <li>Install Script</li>
    <?php endif; ?>
</ul>
        
<?php else : ?>
<?php echo JText::_('COM_INSTALLER_DISTRIBUTION_NOTHING_TO_DO') ?>
<?php endif; ?>

<script type="text/javascript">
    
window.addEvent('domready', function() {

    var extensions = $$('#distro_tasks li');
    var i = 0;
    
    var installer = new DistroInstaller();
    
    // Loop through extensions to install
    for (i = 0; i < extensions.length; i++)
    {
        installer.addItem(extensions[i].get('data-detailsurl'));
    }
    
    installer.process();
});
    
var DistroInstaller = new Class({
    
    request : false,
    response : false,
    queue : new Array(),
    errors : false,
    
    addItem : function(url) {
        this.queue.push(url);
    },
    
    process : function() {
        if (this.queue.length) this.download();
        else this.complete();
    },
    
    error : function() {
        alert(this.options.message);
        
        return this;
    },
    
    complete: function() {
        
        window.location.href = '<?php echo JRoute::_('index.php?option=com_installer&view=installer') ?>';
    },
    
    install : function() {
        this.request = new Request({
            url:    'index.php?option=com_installer',
            data:   '<?php echo JUtility::getToken(); ?>=1&task=install.distro_install&dir='+this.response.dir+'&extractdir='+this.response.extractdir+'&packagefile='+this.response.packagefile+'&type='+this.response.type,
            link: 'chain',
            onSuccess : function(response) {
                this.response = JSON.decode(response);
                this.queue.shift();
                this.process();
            }.bind(this)
        }).send();
    },
    
    extract : function() {
        this.request = new Request({
            url:    'index.php?option=com_installer',
            data:   '<?php echo JUtility::getToken(); ?>=1&task=install.distro_extract&file='+this.response.file,
            link: 'chain',
            onStart : function() {
                console.info(this.response.file);
            },
            onSuccess : function(response) {
                this.response = JSON.decode(response);
                this.install();
            }.bind(this)
        }).send();
    },
    
    download : function() {
        this.request = new Request({
            url:    'index.php?option=com_installer',
            data:   '<?php echo JUtility::getToken(); ?>=1&task=install.distro_download&detailsurl='+this.queue[0],
            link: 'chain',
            onSuccess : function(response) {
                this.response = JSON.decode(response);
                this.extract();
            }.bind(this)
        }).send();
    }

});
    
</script>