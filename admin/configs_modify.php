<?
require_once '../admin.common.prepend.php';

CheckPermissions("configs", 'modify');

$table = 'configs';

if (isset($_REQUEST['action']) && $_REQUEST['action'] != '')
    $action = $_REQUEST['action'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: {$table}_manage.php");
    exit;
}

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = $_GET['id'];

if ($action == 'edit' && $id) {
    $config = GetRowById($table, 'config_id', $id);
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';
    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }

    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = "AND config_id != '$id' ";
        $action_str = "UPDATE";
        $where_str = "WHERE config_id='$id'";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str {$table} $set_str $where_str";

    if (GetCount("{$table}", "name = '{$fields['name']}' $where_validation ")) {
        $message = "This config already exists.";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Configs created successfully");
        header("Location: {$table}_manage.php");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $config = $fields;
}

PreparePage(array(
    'title' => 'Configs', // Required
    'page_type' => 'Configs', // Required
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($config['name'] == null || $action == 'create') ? 'New Page' : $config['name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="configs_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Name:</label>
                    <input id="name" type='text' required name="q[name]" value="<?= $config['name'] ?>" title="Name "/>
                </li>
                <li class="wide">
                    <label for="value">Value:</label>
                    <input id="value" type='text' required name="q[value]" value="<?= $config['value'] ?>" title="Value"/>
                </li>
                <li class="wide">
                    <label for="description">Description:</label>
                    <input id="description" type='text' required name="q[description]" value="<?= $config['description'] ?>" title="Description"/>
                </li>
                <li class="wide">
                    <label for="type">Type:</label>
                    <select id="type" name="q[type]">
                        <option value="">Type</option>
                        <option value="string">String</option>
                        <option value="boolean">Boolean</option>
                        <option value="array">Array</option>
                        <option value="integer">Integer</option>
                    </select>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Config"/>
            </div>
        </form>
        <script type="text/javascript" src="/js/config.js"></script>
    </div>
</div>
<? footer() ?>
