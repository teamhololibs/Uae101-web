<?
require_once '../admin.common.prepend.php';

$table_name = 'authors';
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
    $author = GetRowById($table_name, 'author_id', $id);
}

foreach ($author as $key => $value) {
    $author[$key] = TextToDB($value);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE author_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Author Successfully deleted");
    header("Location: {$table_name}_manage.php");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE author_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Author Successfully enabled");
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
        $where_validation = " AND author_id != $id ";
        $action_str = "UPDATE";
        $where_str = "WHERE author_id=$id";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str {$table_name} $set_str $where_str";

    if (GetCount($table_name, "name = '{$fields['name']}' $where_validation ")) {
        $message = "This author already exists. Please recheck";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Category {$action}ed successfully");
        header("Location: {$table_name}_manage.php");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $author = $fields;
}

PreparePage(array(
    'title' => 'Author: Modify', // Required
    'page_type' => 'Author', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($author['name'] == null || $action == 'create') ? 'New Author' : $author['name'], // Required
));
?>
<script type="text/javascript" src="js/author_category.js"></script>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Author Name:</label>
                    <input id="name" type='text' required name="q[name]" value="<?= htmlspecialchars(TextFromDB($author['name'])) ?>" placeholder="Name of the author"/>
                </li>
                <li class="wide">
                    <label for="url">Author URL:</label>
                    <input id="url" type='text' name="q[url]" value="<?= TextFromDB($author['url']) ?>" placeholder="URL of the author"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Author"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
