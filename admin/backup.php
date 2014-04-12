<?php
require_once '../admin.common.prepend.php';
CheckPermissions("backup", 'super');

PreparePage(array(
    'title' => 'Backup :: SP', // Required
    'page_type' => 'Backup', // Required
));

if ($_POST['create_backup']) {
    BackUpAndDownloadDatabase();
} else {
    ?>
    <form method="post" action="">
        <input class="ui-button" type = "submit" name = "create_backup" value = "Create Backup"/>
    </form>

    <?
}
footer();
?>

