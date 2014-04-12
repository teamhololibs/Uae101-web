<?
require_once '../admin.common.prepend.php';

CheckPermissions("adminpages", 'super');

if (isset($_GET['x'])) {
    $fields = $_GET['x'];
    foreach ($fields as $k => $v) {
        $fields[$k] = TextToDB(trim($v));
    }
    $where_array = array();

    if ($fields['page_type'] != '') {
        $where_array[] = "page_type LIKE '%" . $fields['page_type'] . "%'";
    }

    if ($fields['file_description'] != '') {
        $where_array[] = "file_description LIKE '%" . $fields['file_description'] . "%'";
    }

    $scope_where = trim(implode(" AND ", $where_array), "AND");
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

if ($scope_where != '')
    $scope_where = " AND $scope_where";

$pages = GetRowsAsAssocArray("SELECT * FROM admin_pages WHERE $where ORDER BY page_type");
$active_count = GetCount('admin_pages', "active = 1 $scope_where");
$delete_count = GetCount('admin_pages', "active = 0 $scope_where");
$scope_prefix = GetUrlPrefix();

PreparePage(array(
    'title' => 'Pages in Admin Panel', // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Pages in Admin Panel', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => 'Admin Panel Pages', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="adminpanelpages_modify.php?action=create">Create a New Page</a>', // Optional
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
                        <label for="page_type">
                            Page Type:
                        </label>
                        <input id="page_type" type="text" name="x[page_type]" value="<?= $_GET['x']['page_type'] ?>" placeholder="Filename"/>
                    </li>
                    <li>
                        <label for="file_description">
                            File Desciption:
                        </label>
                        <input id="file_description" type="text" name="x[file_description]" value="<?= $_GET['x']['file_description'] ?>" placeholder="File Description"/>
                    </li>
                </ul>
                <input class="button" type="submit" value="Search"/>
                <input class="button cancel" type="button" onclick="window.location.href = 'adminpanelpages_manage.php'" value="Clear"/>
            </form>
        </div>
    </div>
<? } ?>
<? if (VIEW) { ?>
    <div class="data_top_options">
        <span class="<?= $active ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=1">Active<span> (<?= $active_count ?>)</span></a>
        </span>
        <span class="<?= $deleted ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=0">Deleted<span> (<?= $delete_count ?>)</span></a>
        </span>
    </div>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>#</th>
                <th>Page Type</th>
                <th>File Description</th>
                <th>Last Updated</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($pages as $page) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $page['page_id'] ?></td>
                    <td><?= $page['page_type'] ?></td>
                    <td><?= $page['file_description'] ?></td>
                    <td><?= $page['created_or_last_updated'] ?></td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" title="<?= $page['page_type'] ?>" href="adminpanelpages_modify.php?action=edit&id=<?= $page['page_id'] ?>"/>Edit</a><br/><? } ?>

                            <?
                            if (DELETE) {
                                if ($page['active'] == '1') {
                                    ?>
                                    <a onclick="return confirm('Are you sure you want to delete?');" href="adminpanelpages_modify.php?action=delete&id=<?= $page['page_id'] ?>"/>Delete</a><br/>
                                <? } else { ?>
                                    <a onclick="return confirm('Are you sure you want to enable?');" href="adminpanelpages_modify.php?action=enable&id=<?= $page['page_id'] ?>"/>Enable</a><br/>
                                <? } ?>
                            <? } ?>
                        </td>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
