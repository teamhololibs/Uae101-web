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
    header("Location: {$table_name}.php");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE cat_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Category Successfully enabled");
    header("Location: {$table_name}.php");
    exit;
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';
    foreach ($fields as $k => $v) {
        if ($k == 'is_parent')
            continue;

        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }

    if ($fields['name'] == '' || $fields['is_parent'] == '') {
        $message = "Please enter required information";
    }

    if ($fields['is_parent'] == '0' && $fields['parent_id'] == '') {
        $message = "Choose a parent";
    } elseif ($fields['is_parent'] == '1') {
        $fields['parent_id'] = '0';
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
        header("Location: {$table_name}.php");
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
<script type="text/javascript" src="js/category.js"></script>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Category Name:</label>
                    <input id="name" type='text' class="required" required name="q[name]" value="<?= $cats['name'] ?>" title="Name of the category"/>
                </li>
                <li class="wide">
                    <label style="padding: 0;" for="is_parent_">Is this a root/parent category?:</label>
                    <label class="form_radio" for="is_parent_yes">Yes</label>
                    <input class="form_radio" required id="is_parent_yes" type='radio' class="required is_parent" name="q[is_parent]" value="1" <?= ($cats['is_parent'] == '1') ? "checked" : '' ?> />
                    <label class="form_radio" for="is_parent_no">No</label>
                    <input class="form_radio" required id="is_parent_no" type='radio' class="required is_parent" name="q[is_parent]" value="0" <?= ($cats['is_parent'] == '0') ? "checked" : '' ?>/>
                </li>
                <li class="wide">
                    <label for="parent">Parent Category:</label>
                    <select id="parent" name="q[parent_id]">
                        <option value=''>Select a Parent</option>
                        <?
                        $all_cats = GetRows($table_name, 'active = 1 AND parent_id = 0 ORDER BY name');
                        //var_dump($all_cats);
                        foreach ($all_cats as $cat) {
                            echo "<option value='{$cat['cat_id']}' ";
                            if ($cat['cat_id'] == $cats['parent_id'])
                                echo 'selected';
                            echo ">{$cat['name']}</option>";
                        }
                        ?>
                    </select>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Category"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
