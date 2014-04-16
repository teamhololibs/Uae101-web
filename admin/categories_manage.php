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

$cats_parent = GetRowsAsAssocArray("SELECT * FROM $table_name WHERE parent_id = 0 ORDER BY name");
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
<script type="text/javascript" src="js/category.js"></script>
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
                <th>Parent #</th>
                <th>Parent Category</th>
                <th>Child #</th>
                <th>Child Category</th>
                <th># of Resources</th>
                <th>Updated</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($cats_parent as $cp) {
                $cc = GetRowsAsAssocArray("SELECT * FROM {$table_name} WHERE $where AND parent_id = {$cp['cat_id']} ORDER BY name"); //cats_child
                $cccount = count($cc);
                if ($cccount == 0) {
                    $class = ($i++ % 2 != 0) ? "class='odd'" : '';
                    echo "<tr $class>";
                    echo "<td>{$cp['cat_id']}</td>";
                    echo "<td>{$cp['name']}</td>";
                    echo "<td></td>";
                    echo "<td></td>";
                    echo "<td>#</td>";
                    echo "<td>{$cp['updated']}</td>";
                    if (ACTION) {
                        echo "<td>";
                        if (EDIT) {
                            echo "<a class='make_dialog' title='{$cp['name']}' href='{$table_name}'_modify.php?action=edit&id={$cp['cat_id']}'>Edit</a><br/>";
                        }
                        if (DELETE) {
                            if ($cp['active'] == '1') {
                                echo "<a onclick='return confirm(\"Are you sure you want to delete?\");' "
                                . "href='{$table_name}_modify.php?action=delete&id={$cp['cat_id']}'>Delete</a><br/>";
                            } else {
                                echo "<a onclick='return confirm(\"Are you sure you want to enable?\");' "
                                . "href='{$table_name}_modify.php?action=enable&id={$cp['cat_id']}'>Enable</a><br/>";
                            }
                        }
                        echo "</td>";
                    }
                    echo "</tr>";
                } else {
                    $class = ($i++ % 2 != 0) ? "class='odd'" : '';
                    echo "<tr $class>";
                    echo "<td rowspan='$cccount' >{$cp['cat_id']}</td>";
                    echo "<td rowspan='$cccount' >{$cp['name']}</td>";
                    $j = 0;
                    foreach ($cc as $c) {
                        echo "<td>{$c['cat_id']}</td>";
                        echo "<td>{$c['name']}</td>";
                        echo "<td>#</td>";
                        echo "<td>{$cp['updated']}</td>";
                        if (ACTION) {
                            echo "<td>";
                            if (EDIT) {
                                echo "<a class='make_dialog' title='{$c['name']}' href='{$table_name}'_modify.php?action=edit&id={$c['cat_id']}'>Edit</a><br/>";
                            }
                            if (DELETE) {
                                if ($c['active'] == '1') {
                                    echo "<a onclick='return confirm(\"Are you sure you want to delete?\");' "
                                    . "href='{$table_name}_modify.php?action=delete&id={$c['cat_id']}'>Delete</a><br/>";
                                } else {
                                    echo "<a onclick='return confirm(\"Are you sure you want to enable?\");' "
                                    . "href='{$table_name}_modify.php?action=enable&id={$c['cat_id']}'>Enable</a><br/>";
                                }
                            }
                            echo "</td>";
                        }
                        if ($j != $cccount - 1) {
                            echo "</tr>";
                            $class = ($i++ % 2 != 0) ? "class='odd'" : '';
                            echo "<tr $class>";
                        }
                        $j++;
                    }
                    echo "</tr>";
                }
            }
            ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
