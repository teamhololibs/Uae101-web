<?
require_once '../admin.common.prepend.php';

$table_name = 'resources';
CheckPermissions($table_name);

if (isset($_GET['x'])) {
    $fields = $_GET['x'];
    foreach ($fields as $k => $v) {
        $fields[$k] = TextToDB(trim($v));
    }
    $where_array = array();

    if ($fields['cat_id'] != '') {
        $res_with_cats = GetColumnInfoByQuery("SELECT distinct(res_id) res_id FROM res_cat WHERE cat_id = {$fields['cat_id']} ");
        $where_array[] = "resource_id IN (" . implode(" , ", $res_with_cats) . ")";
    }
    if ($fields['cat_name'] != '') {
        $cats = GetColumnInfo("categories", "cat_id", "name like '%{$fields['cat_name']}%' ");
        if (count($cats) > 0) {
            $res_with_cats = GetColumnInfoByQuery("SELECT distinct(res_id) res_id FROM res_cat WHERE cat_id IN (" . implode(" , ", $cats) . ") ");
            $where_array[] = "resource_id IN (" . implode(" , ", $res_with_cats) . ")";
        }
    }


    if ($fields['name'] != '') {
        $where_array[] = "name LIKE '%" . $fields['name'] . "%'";
    }

    $scope_where = trim(implode(" AND ", $where_array), "AND");
    switch ($fields['scope']) {
        case '0' :
            $where_array[] = "active = 0";
            $var = 'deleted';
            break;
        case '-1' :
            $where_array[] = "is_approved = 0";
            $var = 'notapproved';
            break;
        case '1' :
        default :
            $where_array[] = "active = 1";
            $where_array[] = "is_approved = 1";
            $var = 'active';
            break;
    }

    $$var = 'selected';
    $where = implode(" AND ", $where_array);
    $where = trim($where, 'AND');
} else {
    $where = 'active = 1 AND is_approved = 1';
    $active = 'selected';
    $order = 'name';
}

if ($scope_where != '')
    $scope_where = " AND $scope_where";

$resources = GetRowsAsAssocArray("SELECT * FROM $table_name WHERE $where ");
$active_count = GetCount($table_name, "active = 1 AND is_approved = 1 $scope_where");
$delete_count = GetCount($table_name, "active = 0 AND is_approved = 1 $scope_where");
$notapproved_count = GetCount($table_name, "is_approved = 0 $scope_where");
$scope_prefix = GetUrlPrefix();

$res = new Resource();
$category = new Category();

PreparePage(array(
    'title' => 'Resources', // Required
    'page_type' => 'Resources', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => 'Resources', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="' . $table_name . '_modify.php?action=create">Create a New Resource</a>' // Optional
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
                    <li>
                        <input id="name" type="text" name="x[description]" value="<?= $_GET['x']['description'] ?>" placeholder="Description"/>
                    </li>
                    <li>
                        <input id="name" type="text" name="x[cat_name]" value="<?= $_GET['x']['cat_name'] ?>" placeholder="Category"/>
                    </li>
                    <li>
                        <input id="name" type="text" name="x[name]" value="<?= $_GET['x']['name'] ?>" placeholder="Author xxx"/>
                    </li>
                    <li>
                        <input id="name" type="text" name="x[name]" value="<?= $_GET['x']['name'] ?>" placeholder="Submitter xxx"/>
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
        <span class="<?= $notapproved ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=-1">Not Approved<span> (<?= $notapproved_count ?>)</span></a>
        </span>
    </div>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>Resource #</th>
                <th>Name</th>
                <th>Description</th>
                <th>Category</th>
                <th style="width: 11%;">Information</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($resources as $resource) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td style="width: 7%;"><?= $resource['resource_id'] ?></td>
                    <td><a href='<?= $resource['url'] ?>'><?= $resource['name'] ?></a></td>
                    <td><?= TextFromDB($resource['description']) ?></td>
                    <td>
                        <?
                        $res_cats = $res->GetResourceCategories($resource['resource_id']);
                        foreach ($res_cats as $res_cat) {
                            echo $category->GetCategoryFullName($res_cat) . "<br/><br/>";
                        }
                        ?>
                    </td>
                    <td>
                        <?
                        echo "Author: ". GetInfoById("authors", "author_id", $resource['author_id'], "name") ."<br/><br/>";
                        echo "Submitter: subbb<br/><br/>";
                        echo "Points: " . $resource['points'] . "<br/><br/>";
                        echo "Views: " . $resource['views'] . "<br/><br/>";
                        echo "Updated: " . $resource['updated'] . "<br/><br/>";
                        ?>
                    </td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if ($resource['is_approved'] == '0') { ?>
                                <a onclick="return confirm('Are you sure you want to approve?');" href="<?= $table_name ?>_modify.php?action=approve&id=<?= $resource['resource_id'] ?>"/>Approve</a><br/>
                            <? } else { ?>
                                <a onclick="return confirm('Are you sure you want to disapprove?');" href="<?= $table_name ?>_modify.php?action=disapprove&id=<?= $resource['resource_id'] ?>"/>Disapprove</a><br/>
                                <?
                            }
                            if (EDIT) {
                                ?>
                                <a class="make_dialog" title="<?= $resource['name'] ?>" href="<?= $table_name ?>_modify.php?action=edit&id=<?= $resource['resource_id'] ?>"/>Edit</a><br/>
                                <?
                            }
                            if (DELETE) {
                                if ($resource['active'] == '1') {
                                    ?>
                                    <a onclick="return confirm('Are you sure you want to delete?');" href="<?= $table_name ?>_modify.php?action=delete&id=<?= $resource['resource_id'] ?>"/>Delete</a><br/>
                                <? } else { ?>
                                    <a onclick="return confirm('Are you sure you want to enable?');" href="<?= $table_name ?>_modify.php?action=enable&id=<?= $resource['resource_id'] ?>"/>Enable</a><br/>
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
