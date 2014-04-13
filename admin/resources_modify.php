<?
require_once '../admin.common.prepend.php';

$table_name = 'resources';
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
    $id = TextFromDB($_GET['id']);

if ($action == 'edit' && $id) {
    $resource = GetRowById($table_name, 'cat_id', $id);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE cat_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Resource Successfully deleted");
    header("Location: {$table_name}_manage.php");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE cat_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Resource Successfully enabled");
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

    if ($fields['name'] == '' || $fields['is_parent'] == '') {
        $message = "Please enter required information";
    }

    if ($fields['is_parent'] == '0' && $fields['parent_id'] == '') {
        $message = "Choose a parent";
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
        $message = "This resource already exists. Please recheck";
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

    $resource = $fields;
}
$resource['is_parent'] = ($resource['is_parent'] == '' || is_null($resource['is_parent'])) ? '0' : $resource['is_parent'];

PreparePage(array(
    'title' => 'Resource: Modify', // Required
    'page_type' => 'Resource', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($resource['name'] == null || $action == 'create') ? 'New Page' : $resource['name'], // Required
));
?>
<script type="text/javascript" src="js/category.js"></script>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Resource Name:</label>
                    <input id="name" type='text' required name="q[name]" value="<?= $resource['name'] ?>" title="Name of the resource"/>
                </li>
                <li class="wide">
                    <label for="name">Resource Description:</label>
                    <textarea id="name" name="q[description]" required placeholder="">
                        <?= $resource['description'] ?>
                    </textarea>
                </li>
                <li class="wide">
                    <label style="padding: 0;" for="">Is this resource approved?:</label>
                    <label class="form_radio" for="is_approved_yes">Yes</label>
                    <input class="form_radio" required id="is_approved_yes" type='radio' class="required" name="q[is_approved]" value="1" <?= ($resource['is_approved'] == '1') ? "checked" : '' ?> />
                    <label class="form_radio" for="is_approved_no">No</label>
                    <input class="form_radio" required id="is_approved_no" type='radio' class="required" name="q[is_approved]" value="0" <?= ($resource['is_approved'] == '0') ? "checked" : '' ?>/>
                </li>
                <li class="wide">
                    <label for="author">Author:</label>
                    <input id="author" type='text' required name="q[author]" value="<?= $resource['author'] ?>" title="Author of the resource"/>
                </li>
            </ul>
            <table width="95%" style="font-size: 1.11em;">
                <?
                // Autocomplete categories and category class for cat search with breadcrumbs
                include 'resources_li_cat.php';
                ?>
            </table>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Resource"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
