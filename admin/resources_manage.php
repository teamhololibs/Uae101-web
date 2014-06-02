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

    if ($fields['author_id'] != '') {
        $where_array[] = "author_id = {$fields['author_id']}";
    }

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

    switch ($fields['order']) {
        case 'resource_id':
            $order = 'resource_id DESC';
            break;
        case 'github_api_last_checked':
            $order = 'github_api_last_checked ASC';
            break;
        case 'name':
        default:
            $order = 'name';
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
        case 'notgit' :
            $where_array[] = "is_github = 0";
            $var = 'notgit';
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

$resources = GetRowsAsAssocArray("SELECT * FROM $table_name WHERE $where ORDER BY $order");
$active_count = GetCount($table_name, "active = 1 AND is_approved = 1 $scope_where");
$delete_count = GetCount($table_name, "active = 0 AND is_approved = 1 $scope_where");
$notapproved_count = GetCount($table_name, "is_approved = 0 $scope_where");
$notgit_count = GetCount($table_name, "is_github = 0 $scope_where");
$scope_prefix = GetUrlPrefix();
$order_prefix = GetUrlPrefix('order');

$res = new Resource();
$category = new Category();

if (isset($fields['cat_id'])) {
    $cat_full_name = $category->GetCategoryFullInfo($fields['cat_id']);
    $cat_full_name = $cat_full_name['full_name'];
    $info = " (Category: $cat_full_name)";
}
if (isset($fields['author_id'])) {
    $author_name = GetInfoById("authors", "author_id", $fields['author_id'], 'name');
    $info = " (Author: $author_name)";
}

PreparePage(array(
    'title' => 'Resources', // Required
    'page_type' => 'Resources', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => "Resources $info", // Required
    'create_button' => '<a class="  anchor_button create_button_text" href="' . $table_name . '_modify.php?action=create">Create a New Resource</a>' // Optional
));
?>
<script type="text/javascript" src="js/resource.js"></script>
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
        <span class="<?= $notgit ?>">
            <a href="<?= $scope_prefix ?>&x[scope]=notgit">Not Github<span> (<?= $notgit_count ?>)</span></a>
        </span>
    </div>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th style="width: 3%;"><a href="<?= $order_prefix ?>&x[order]=resource_id">#</a></th>
                <th><a href="<?= $order_prefix ?>&x[order]=name">Name</a></th>
                <th style="width: 20%;">Description</th>
                <th style="width: 14%;">Category</th>
                <th style="width: 10%;"><a href="<?= $order_prefix ?>&x[order]=github_api_last_checked">API Checked</a></th>
                <th style="width: 17%;">Information</th>
                <? if (ACTION) { ?>
                    <th style="width: 6%;">
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($resources as $resource) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $resource['resource_id'] ?></td>
                    <td>
                        <a target='_blank' href='<?= $resource['url'] ?>'><?= TextFromDB($resource['name']) ?></a><br/><br/>
                        <? if ($res->IsGithubUrl($resource['url'])) { ?>
                            <a target='_blank' href='<?= $res->GetGithubApiUrl($resource['url']) ?>'>GITHUB API</a>
                        <? } ?>
                    </td>
                    <td class="content_desc"><?= (TextFromDB($resource['description'])) ?></td>
                    <td>
                        <?
                        $res_cats = $res->GetResourceCategories($resource['resource_id']);
                        foreach ($res_cats as $res_cat) {
                            $cat_info = $category->GetCategoryFullInfo($res_cat);
                            echo "<a href='resources_manage.php?x[cat_id]={$res_cat}'>{$cat_info['full_name']}</a><br/><br/>";
                        }
                        ?>
                    </td>
                    <td><?= $resource['github_api_last_checked'] ?></td>
                    <td>
                        <?
                        echo "Author: <a href='resources_manage.php?x[author_id]={$resource['author_id']}'>" . GetInfoById("authors", "author_id", $resource['author_id'], "name") . "</a><br/><br/>";
                        //echo "Rating: " . $resource['rating'] . "<br/><br/>";
                        //echo "User: user<br/><br/>";
                        echo "Github ID: " . $resource['github_resource_id'] . "<br/><br/>";
                        echo "Github Starred: " . $resource['github_stargazers'] . "<br/><br/>";
                        echo "Github Forks: " . $resource['github_forks'] . "<br/><br/>";
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
                                <a class=" " title="<?= $resource['name'] ?>" href="<?= $table_name ?>_modify.php?action=edit&id=<?= $resource['resource_id'] ?>"/>Edit</a><br/>
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
