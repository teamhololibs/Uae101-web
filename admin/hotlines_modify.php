<?
require_once '../admin.common.prepend.php';

$table_name = 'hotlines';
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
    $hotlines = GetRowById($table_name, 'hotline_id', $id);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE hotline_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Hotline Successfully deleted");
    header("Location: {$table_name}");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE hotline_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Hotline Successfully enabled");
    header("Location: {$table_name}");
    exit;
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';

    if ($fields['hotline_name'] == '') {
        $message = "Please enter required information";
    }

    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }
    
    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = " AND hotline_id != $id ";
        $action_str = "UPDATE";
        $where_str = "WHERE hotline_id=$id";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str {$table_name} $set_str $where_str";

    if (GetCount($table_name, "hotline_name = '{$fields['hotline_name']}' $where_validation ")) {
        $message = "This Hotline already exists. Please recheck";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Hotline {$action}ed successfully");
        header("Location: {$table_name}");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $hotlines = $fields;
}

PreparePage(array(
    'title' => 'Hotline: Modify', // Required
    'page_type' => 'Hotline', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($hotlines['name'] == null || $action == 'create') ? 'New Hotline' : $hotlines['name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Hotline Name:</label>
                    <input id="name" type='text' class="required" required name="q[hotline_name]" value="<?= $hotlines['hotline_name'] ?>" title="Name of the Hotline"/>
                </li>
                <li class="wide">
                    <label for="name">Hotline Number:</label>
                    <input id="name" type='text' class="required" required name="q[hotline_number]" value="<?= $hotlines['hotline_number'] ?>" title="Number of the Hotline"/>
                </li>
                <li class="wide">
                    <label for="parent">Emirate:</label>
                    <select id="parent" name="q[emirate_id]">
                        <option value=''>Select a Emirate</option>
                        <?
                        $all_cats = GetRows('emirates', '1 ORDER BY name');
                        foreach ($all_cats as $cat) {
                            echo "<option value='{$cat['emirate_id']}' ";
                            if ($cat['emirate_id'] == $hotlines['emirate_id'])
                                echo 'selected';
                            echo ">{$cat['name']}</option>";
                        }
                        ?>
                    </select>
                </li>
                <li class="wide">
                    <label for="parent">Group:</label>
                    <select id="parent" name="q[group_id]">
                        <option value=''>Select a Group</option>
                        <?
                        $all_cats = GetRows('groups', '1 ORDER BY group_name');
                        foreach ($all_cats as $cat) {
                            echo "<option value='{$cat['group_id']}' ";
                            if ($cat['group_id'] == $hotlines['group_id'])
                                echo 'selected';
                            echo ">{$cat['group_name']}</option>";
                        }
                        ?>
                    </select>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Hotline"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
