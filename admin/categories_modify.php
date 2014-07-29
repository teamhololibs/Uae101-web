<?
require_once '../admin.common.prepend.php';

$table_name = 'categories';
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
    $cats = GetRowById($table_name, 'cat_id', $id);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE cat_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Category Successfully deleted");
    header("Location: {$table_name}");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE cat_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Category Successfully enabled");
    header("Location: {$table_name}");
    exit;
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';

    if ($fields['name'] == '') {
        $message = "Please enter required information";
    }

    if ($fields['is_parent'] == '0' && $fields['parent_id'] == '') {
        $message = "Choose a parent";
    } elseif ($fields['is_parent'] == '1') {
        $fields['parent_id'] = '0';
    }

    foreach ($fields as $k => $v) {
        if ($k == 'is_parent')
            continue;

        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }
    
    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = " AND cat_id != $id ";
        $action_str = "UPDATE";
        $where_str = "WHERE cat_id=$id";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str {$table_name} $set_str $where_str";

    if (GetCount($table_name, "name = '{$fields['name']}' $where_validation ")) {
        $message = "This category already exists. Please recheck";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Category {$action}ed successfully");
        header("Location: {$table_name}");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $cats = $fields;
}
$cats['is_parent'] = ($cats['parent_id'] == '0') ? '1' : '0';

PreparePage(array(
    'title' => 'Category: Modify', // Required
    'page_type' => 'Category', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($cats['name'] == null || $action == 'create') ? 'New Category' : $cats['name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Category Name:</label>
                    <input id="name" type='text' class="required" required name="q[name]" value="<?= $cats['name'] ?>" title="Name of the category"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Category"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
