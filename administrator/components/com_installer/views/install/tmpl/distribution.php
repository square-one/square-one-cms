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

	<table class="adminlist" id="distro_tasks">
		<thead>
			<tr>
				<th width="20">
					
				</th>
				<th width="150">
					<?php echo JText::_('COM_INSTALLER_HEADING_NAME'); ?>
				</th>
				<th width="100">
					<?php echo JText::_('COM_INSTALLER_HEADING_TYPE'); ?>
				</th>
				<th width="50" class="center">
					<?php echo JText::_('JVERSION'); ?>
				</th>
                <th>
                    <?php echo JText::_('COM_INSTALLER_RESULT') ?>
                </th>
			</tr>
		</thead>
		<tbody>
		<?php foreach ($this->result->extensions->xpath('//extension') as $i => $extension) : if (isset($extension['detailsurl'])) : ?>
			<tr class="row<?php echo $i%2; ?> extension" data-detailsurl="<?php echo $extension['detailsurl']; ?>">
				<td class="jgrid">
                    <span class="state unpublish">&nbsp;</span>
				</td>
				<td>
					<?php echo $extension['name']; ?>
				</td>
				<td class="center">
					<?php echo JText::_('COM_INSTALLER_TYPE_'.$extension['type']); ?>
				</td>
				<td class="center">
					<?php echo $extension['version']; ?>
				</td>
                <td class="result">
                    
                </td>
			</tr>
		<?php endif; endforeach; ?>
		</tbody>
	</table>
        
<?php else : ?>
<?php echo JText::_('COM_INSTALLER_DISTRIBUTION_NOTHING_TO_DO') ?>
<?php endif; ?>

<script type="text/javascript">
    
window.addEvent('domready', function() {

    var extensions = $$('#distro_tasks tr.extension');
    var i = 0;
    
    var installer = new DistroInstaller();
    
    // Loop through extensions to install
    for (i = 0; i < extensions.length; i++)
    {
        installer.addItem(extensions[i]);
    }
    
    installer.process();
});
    
var DistroInstaller = new Class({
    
    request : false,
    response : false,
    queue : new Array(),
    errors : false,
    
    addItem : function(item) {
        this.queue.push(item);
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
        
        //window.location.href = '<?php echo JRoute::_('index.php?option=com_installer&view=installer') ?>';
    },
    
    install : function() {
        this.request = new Request({
            url:    'index.php?option=com_installer',
            data:   '<?php echo JUtility::getToken(); ?>=1&task=install.distro_install&dir='+this.response.dir+'&extractdir='+this.response.extractdir+'&packagefile='+this.response.packagefile+'&type='+this.response.type,
            onFailure : function() {
                this.queue[0].getFirst('td.result').set('text', '<?php echo JText::_('COM_INSTALLER_INSTALL_FAILED') ?>');
                this.queue[0].getFirst('td.jgrid span').set('class', 'state unpublish');
                this.queue.shift();
                this.process();
            },
            onSuccess : function(response) {
                this.response = JSON.decode(response);
                this.queue[0].getFirst('td.result').set('text', this.response.message);
                if (this.response.result == true) {
                    this.queue[0].getFirst('td.jgrid span').set('class', 'state publish');
                } else {
                    this.queue[0].getFirst('td.jgrid span').set('class', 'state unpublish');
                }
                this.queue.shift();
                this.process();
            }.bind(this)
        }).send();
    },
    
    extract : function() {
        this.request = new Request({
            url:    'index.php?option=com_installer',
            data:   '<?php echo JUtility::getToken(); ?>=1&task=install.distro_extract&file='+this.response.file,
            onFailure : function() {
                this.queue[0].getFirst('td.result').set('text', '<?php echo JText::_('COM_INSTALLER_EXTRACT_FAILED') ?>');
                this.queue[0].getFirst('td.jgrid span').set('class', 'state unpublish');
                this.queue.shift();
                this.process();
            },
            onSuccess : function(response) {
                this.response = JSON.decode(response);
                this.queue[0].getFirst('td.result').set('text', this.response.message);
                if (this.response.result == true) {
                    this.install();
                } else {
                    this.queue[0].getFirst('td.jgrid span').set('class', 'state unpublish');
                    this.queue.shift();
                    this.process();
                }
            }.bind(this)
        }).send();
    },
    
    download : function() {
        this.queue[0].getFirst('td.jgrid span').set('class', 'state progress');
        this.request = new Request({
            url:    'index.php?option=com_installer',
            data:   '<?php echo JUtility::getToken(); ?>=1&task=install.distro_download&detailsurl='+this.queue[0].get('data-detailsurl'),
            onFailure : function() {
                this.queue[0].getFirst('td.result').set('text', '<?php echo JText::_('COM_INSTALLER_DOWNLOAD_FAILED') ?>');
                this.queue[0].getFirst('td.jgrid span').set('class', 'state unpublish');
                this.queue.shift();
                this.process();
            },
            onSuccess : function(response) {
                this.response = JSON.decode(response);
                this.queue[0].getFirst('td.result').set('text', this.response.message);
                if (this.response.result == true) {
                    this.extract();
                } else {
                    this.queue[0].getFirst('td.jgrid span').set('class', 'state unpublish');
                    this.queue.shift();
                    this.process();
                }
                
            }.bind(this)
        }).send();
    }

});
    
</script>