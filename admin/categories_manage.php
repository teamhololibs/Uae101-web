<?
require_once '../admin.common.prepend.php';

$table_name = 'categories';
CheckPermissions($table_name);

if (isset($_GET['x'])) {
    $fields = $_GET['x'];
    foreach ($fields as $k => $v) {
        $fields[$k] = TextToDB(trim($v));
    }
    $where_array = array();

    if ($fields['name'] != '') {
        $where_array[] = "name LIKE '%" . $fields['name'] . "%'";
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

$cats = GetRowsAsAssocArray("SELECT * FROM $table_name WHERE $where ORDER BY name");
$active_count = GetCount($table_name, "active = 1 $scope_where");
$delete_count = GetCount($table_name, "active = 0 $scope_where");
$scope_prefix = GetUrlPrefix();

PreparePage(array(
    'title' => 'Categories', // Required
    'page_type' => 'Categories', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => 'Categories', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="' . $table_name . '_modify.php?action=create">Create a New Category</a>' // Optional
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
                <th>Name</th>
                <th>Updated</th>
                <th># of Resources</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($cats as $cat) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $cat['cat_id'] ?></td>
                    <td><?= TextFromDB($cat['name']) ?></td>
                    <td><?= $cat['updated'] ?></td>
                    <td><a href='resources_manage.php?x[cat_id]=<?= $cat['cat_id'] ?>'><?= GetCount("res_cat", "cat_id = '{$cat['cat_id']}'", "DISTINCT(res_id)") ?></td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" title="<?= TextFromDB($cat['name']) ?>" href="<?= $table_name ?>_modify.php?action=edit&id=<?= $cat['cat_id'] ?>"/>Edit</a><br/><?
                            }
                            if (DELETE) {
                                if ($cat['active'] == '1') {
                                    ?>
                                    <a onclick="return confirm('Are you sure you want to delete?');" href="<?= $table_name ?>_modify.php?action=delete&id=<?= $cat['cat_id'] ?>"/>Delete</a><br/>
                                <? } else { ?>
                                    <a onclick="return confirm('Are you sure you want to enable?');" href="<?= $table_name ?>_modify.php?action=enable&id=<?= $cat['cat_id'] ?>"/>Enable</a><br/>
                                    <?
                                }
                            }
                            ?>
                        </td>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
