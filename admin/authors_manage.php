<?
require_once '../admin.common.prepend.php';

$table_name = 'authors';
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
    switch ($fields['order']) {
        case 'author_id':
            $order = 'author_id DESC';
            break;
        case 'name':
        default: $order = 'name';
    }
    $scope_where = trim(implode(" AND ", $where_array), "AND");

    $where = implode(" AND ", $where_array);
    $where = trim($where, 'AND');
} else {
    $where = '1';
    $order = 'name';
}

//if ($scope_where != '')
//  $scope_where = " AND $scope_where";

$authors = GetRowsAsAssocArray("SELECT * FROM $table_name WHERE $where ORDER BY $order ");
$active_count = GetCount($table_name, "$scope_where");
$scope_prefix = GetUrlPrefix();
$order_prefix = GetUrlPrefix('order');

$res = new Resource();
$category = new Category();

PreparePage(array(
    'title' => 'Authors', // Required
    'page_type' => "Authors ", // Required
    'page_action' => '', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => "Authors ($active_count)", // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="' . $table_name . '_modify.php?action=create">Create a New Author</a>' // Optional
));
?>
<script type="text/javascript" src="js/author_category.js"></script>
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
                <th><a href="<?= $order_prefix ?>&x[order]=author_id">#</a></th>
                <th><a href="<?= $order_prefix ?>&x[order]=name">Name</a></th>
                <th>Github ID</th>
                <th># of Resources</th>
                <th>URL</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($authors as $author) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $author['author_id'] ?></td>
                    <td><?= TextFromDB($author['name']) ?></td>
                    <td><?= TextFromDB($author['github_author_id']) ?></td>
                    <td><a href='resources_manage.php?x[author_id]=<?= $author['author_id'] ?>'><?= GetCount('resources', "active = 1 AND author_id = {$author['author_id']}") ?></td>
                    <td><a target='_blank' href="<?= TextFromDB($author['url']) ?>"><?= TextFromDB($author['url']) ?></a></td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" title="<?= TextFromDB($author['name']) ?>" href="<?= $table_name ?>_modify.php?action=edit&id=<?= $author['author_id'] ?>"/>Edit</a><br/><? } ?>
                        </td>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
