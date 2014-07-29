<?
require_once '../admin.common.prepend.php';

$table_name = 'emirates';
CheckPermissions($table_name);

if (isset($_GET['x'])) {
    $fields = $_GET['x'];
    foreach ($fields as $k => $v) {
        $fields[$k] = TextToDB(trim($v));
    }
    $where_array = array();
    $where_array[] = "1";

    if ($fields['name'] != '') {
        $where_array[] = "name LIKE '%" . $fields['name'] . "%'";
    }
    $scope_where = trim(implode(" AND ", $where_array), "AND");

    $where = implode(" AND ", $where_array);
    $where = trim($where, 'AND');
} else {
    $where = '1';
}

$emirates = GetRowsAsAssocArray("SELECT * FROM $table_name WHERE $where ");
$active_count = GetCount($table_name, "$scope_where");
$scope_prefix = GetUrlPrefix();

PreparePage(array(
    'title' => 'Emirates', // Required
    'page_type' => "Emirates ", // Required
    'page_action' => '', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => "Emirates ($active_count)", // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="' . $table_name . '_modify.php?action=create">Create a New Emirate</a>' // Optional
));
?>
<? if (SEARCH) { ?>
    <div class="search_options">
        <a class="anchor_button search_button_text">Search Options <span class="indicator">+</span><span class="indicator minus">-</span></a>
        <div class="search_elements">
            <form action="" id="form_x_search" method="get" enctype="text/plain" accept-charset="UTF-8">
                Search Options:
                <ul>
                    <li>
                        <input id="name" type="text" name="x[name]" value="<?= $_GET['x']['name'] ?>" placeholder="Name"/>
                    </li>
                </ul>
                <input class="button" type="submit" value="Search"/>
                <input class="button cancel" type="button" onclick="window.location.href = '<?= $table_name ?>_manage.php'" value="Clear"/>
            </form>
        </div>
    </div>
<? } ?>
<? if (VIEW) { ?>
    <!--div class="data_top_options">
        <span class="<?= $active ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=1">Active<span> (<?= $active_count ?>)</span></a>
        </span>
    </div-->
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Short Form</th>
                <th># of Resources</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($emirates as $emirate) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $emirate['emirate_id'] ?></td>
                    <td><?= TextFromDB($emirate['name']) ?></td>
                    <td><?= $emirate['shortform'] ?></td>
                    <td><a href='resources_manage.php?x[emirate_id]=<?= $emirate['emirate_id'] ?>'><?= GetCount('resources', "active = 1 AND emirate_id = {$emirate['emirate_id']}") ?></td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" title="<?= TextFromDB($emirate['name']) ?>" href="<?= $table_name ?>_modify.php?action=edit&id=<?= $emirate['emirate_id'] ?>"/>Edit</a><br/><? } ?>
                        </td>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
