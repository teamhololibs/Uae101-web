<?php
require_once '../admin.common.prepend.php';
CheckPermissions("backup", 'super');


if ($_POST['update_libraries']) {
    $count = Resource::UpdateAllGithubLibraries();
    if ($count > 0) {
        SetConfirmationMessage("$count Libraries updated!");
    }
} else {
    $show_form = 1;
}

PreparePage(array(
    'title' => 'Update Libraries', // Required
    'page_heading' => 'Update Libraries', // Required
));
if ($show_form == 1) {
    ?>
    <form method="post" action="">
        <input class="ui-button" type = "submit" name = "update_libraries" value = "Update Libraries"/>
    </form>

    <?
}
footer();
?>

