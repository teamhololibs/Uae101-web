<?
require_once '../admin.common.prepend.php';

CheckPermissions("configs");

if (isset($_GET['x'])) {
    $fields = $_GET['x'];
    $where_array = array();
    foreach ($fields as $k => $v) {
        $fields[$k] = TextToDB(trim($v));
        $where_array[] = " $k LIKE '$v' ";
    }

    $where = implode(" AND ", $where_array);
    $where = trim($where, 'AND');
}

if ($where != '')
    $where = " WHERE $where";

$configs = GetRowsAsAssocArray("SELECT * FROM configs $where");
$scope_prefix = GetUrlPrefix();

PreparePage(array(
    'title' => 'Config Variables :: SP', // Required
    'page_type' => 'Config Variables', // Required
    'page_action' => 'Manage', // Optional
    'page_heading' => 'Config Variables', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="configs_modify.php?action=create">Create a New Config Variable</a>', // Optional
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
                        <label for="name">Name:</label>
                        <input id="name" type="text" name="x[name]" value="<?= $_GET['x']['name'] ?>" placeholder="Name"/>
                    </li>
                    <li>
                        <label for="value">Value:</label>
                        <input id="value" type="text" name="x[value]" value="<?= $_GET['x']['value'] ?>" placeholder="Value"/>
                    </li>
                    <li>
                        <label for="description">Description:</label>
                        <input id="description" type="text" name="x[description]" value="<?= $_GET['x']['description'] ?>" placeholder="Description"/>
                    </li>
                    <li>
                        <label for="type">Type:</label>
                        <select name="x[type]" id="type">
                            <option value="">Type</option>
                            <option value="text">Text</option>
                            <option value="boolean">Boolean</option>
                            <option value="array">Array</option>
                            <option value="integer">Integer</option>
                        </select>
                    </li>
                </ul>
                <input class="button" type="submit" value="Search"/>
                <input class="button cancel" type="button" onclick="window.location.href = window.location.pathname" value="Clear"/>
            </form>
        </div>
    </div>
<? } ?>
<? if (VIEW) { ?>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>Name</th>
                <th>Value</th>
                <th>Description</th>
                <th>Type</th>
                <? if (ACTION) { ?>
                    <th>
                        Action
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($configs as $config) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $config['name'] ?></td>
                    <td><?= $config['value'] ?></td>
                    <td><?= $config['description'] ?></td>
                    <td><?= $config['type'] ?></td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" title="<?= $config['name'] ?>" href="configs_modify.php?action=edit&id=<?= $config['config_id'] ?>"/>Edit</a><br/><? } ?>
                            <?
                            if (DELETE) {
                                if ($config['active'] == '1') {
                                    ?>
                                    <a onclick="return confirm('Are you sure you want to delete?');" href="configs_modify.php?action=delete&id=<?= $config['config_id'] ?>"/>Delete</a><br/>
                                <? } else { ?>
                                    <a onclick="return confirm('Are you sure you want to enable?');" href="configs_modify.php?action=enable&id=<?= $config['config_id'] ?>"/>Enable</a><br/>
                                <? } ?>
                            </td>
                        <? } ?>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
    <script type="text/javascript" src="/js/config.js"></script>
<? } ?>
<? footer() ?>
