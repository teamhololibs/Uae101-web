<?
require_once '../admin.common.prepend.php';

$table_name = 'groups';
CheckPermissions($table_name);

if (isset($_REQUEST['action']) && $_REQUEST['action'] != '')
    $action = $_REQUEST['action'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: {$table_name}.php");
    exit;
}

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = TextFromDB($_GET['id']);

if ($action == 'edit' && $id) {
    $groups = GetRowById($table_name, 'group_id', $id);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE group_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Group Successfully deleted");
    header("Location: {$table_name}");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE group_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Group Successfully enabled");
    header("Location: {$table_name}");
    exit;
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';

    if ($fields['group_name'] == '') {
        $message = "Please enter required information";
    }

    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }
    
    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = " AND group_id != $id ";
        $action_str = "UPDATE";
        $where_str = "WHERE group_id=$id";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str {$table_name} $set_str $where_str";

    if (GetCount($table_name, "group_name = '{$fields['group_name']}' $where_validation ")) {
        $message = "This Group already exists. Please recheck";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Group {$action}ed successfully");
        header("Location: {$table_name}");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $groups = $fields;
}

PreparePage(array(
    'title' => 'Hotline: Modify', // Required
    'page_type' => 'Hotline', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($groups['name'] == null || $action == 'create') ? 'New Hotline' : $groups['name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Group Name:</label>
                    <input id="name" type='text' class="required" required name="q[group_name]" value="<?= $groups['group_name'] ?>" title="Name of the Hotline"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Hotline"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
