<?
require_once '../admin.common.prepend.php';

$table_name = 'emirates';
CheckPermissions($table_name);

if (isset($_REQUEST['action']) && $_REQUEST['action'] != '')
    $action = $_REQUEST['action'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: {$table_name}_manage.php");
    exit;
}

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = TextToDB($_GET['id']);

if ($action == 'edit' && $id) {
    $emirate = GetRowById($table_name, 'emirate_id', $id);
}

foreach ($emirate as $key => $value) {
    $emirate[$key] = TextToDB($value);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE emirate_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Emirate Successfully deleted");
    header("Location: {$table_name}_manage.php");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE emirate_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Emirate Successfully enabled");
    header("Location: {$table_name}_manage.php");
    exit;
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';
    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }

    if ($fields['name'] == '') {
        $message = "Please enter required information";
    }

    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = " AND emirate_id != $id ";
        $action_str = "UPDATE";
        $where_str = "WHERE emirate_id=$id";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str {$table_name} $set_str $where_str";

    if (GetCount($table_name, "name = \"{$fields['name']}\" $where_validation ")) {
        $message = "This emirate already exists. Please recheck";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Emirate {$action}ed successfully");
        header("Location: {$table_name}_manage.php");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $emirate = $fields;
}

PreparePage(array(
    'title' => 'Emirate: Modify', // Required
    'page_type' => 'Emirate', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($emirate['name'] == null || $action == 'create') ? 'New Emirate' : $emirate['name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Emirate Name:</label>
                    <input id="name" type='text' required name="q[name]" value="<?= htmlspecialchars(TextFromDB($emirate['name'])) ?>" placeholder="Name of the Emirate"/>
                </li>
                <li class="wide">
                    <label for="shortform">Emirate Shortform:</label>
                    <input id="shortform" type='text' required name="q[shortform]" value="<?= htmlspecialchars(TextFromDB($emirate['shortform'])) ?>" placeholder="shortform"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Emirate"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
