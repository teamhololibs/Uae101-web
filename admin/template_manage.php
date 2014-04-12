<?
require_once '../admin.common.prepend.php';

CheckPermissions("prog_languages");

if (isset($_GET['x'])) {
    $fields = $_GET['x'];
    foreach ($fields as $k => $v) {
        $fields[$k] = TextToDB(trim($v));
    }
    $where_array = array();

    switch ($fields['scope']) {
        case '0' :
            $where_array[] = "active = 0";
            $var = 'deleted';
            break;
        case '1' :
        default :
            $where_array[] = "active = 1";
            $var = 'active';
            break;
    }

    $$var = 'selected';
    $where = implode(" AND ", $where_array);
    $where = trim($where, 'AND');
} else {
    $where = 'active = 1';
    $active = 'selected';
}

$langs = GetRowsAsAssocArray("SELECT * FROM prog_languages WHERE $where");
$scope_prefix = GetUrlPrefix();

PreparePage(array(
    'title' => 'Prog Languages :: SP', // Required
    'page_type' => 'Prog Languages', // Required
    'page_action' => 'Manage', // Optional
    'page_heading' => 'Prog Languages', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="prog_languages_modify.php?action=create">Create a New Programming Language</a>', // Optional
));
?>
<? if (VIEW) { ?>
    <div class="data_top_options">
        <span class="<?= $active ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=1">Active</a>
        </span>
        <span class="<?= $deleted ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=0">Deleted</a>
        </span>
    </div>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>#</th>
                <th>Language Name</th>
                <th>Last Updated</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($langs as $lang) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $lang['prog_lang_id'] ?></td>
                    <td><?= $lang['name'] ?></td>
                    <td><?= $lang['created_or_last_updated'] ?></td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" title="<?= $lang['filename'] ?>" href="prog_languages_modify.php?action=edit&id=<?= $lang['prog_lang_id'] ?>"/>Edit</a><br/><? } ?>
                            <?
                            if (DELETE) {
                                if ($lang['active'] == '1') {
                                    ?>
                                    <a onclick="return confirm('Are you sure you want to delete?');" href="prog_languages_modify.php?action=delete&id=<?= $lang['prog_lang_id'] ?>"/>Delete</a><br/>
                                <? } else { ?>
                                    <a onclick="return confirm('Are you sure you want to enable?');" href="prog_languages_modify.php?action=enable&id=<?= $lang['prog_lang_id'] ?>"/>Enable</a><br/>
                                <? } ?>
                            </td>
                        <? } ?>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
