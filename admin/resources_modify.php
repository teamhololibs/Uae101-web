<?
require_once '../admin.common.prepend.php';

$table_name = 'resources';
CheckPermissions($table_name);
$cfg = new Config;
$desc_maxlength = $cfg->GetConfig("RESOURCE_DESCRIPTION_MAXLENGTH");

if (isset($_REQUEST['action']) && $_REQUEST['action'] != '')
    $action = $_REQUEST['action'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: {$table_name}");
    exit;
}

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = TextFromDB($_GET['id']);

if ($action == 'edit' && $id) {
    $resource = GetRowById($table_name, 'resource_id', $id);
}

foreach ($resource as $key => $value) {
    $resource[$key] = TextFromDB($value);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE $table_name SET active = 0 WHERE resource_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Resource Successfully deleted");
    header("Location: {$table_name}");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE {$table_name} SET active = 1 WHERE resource_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Resource Successfully enabled");
    header("Location: {$table_name}");
    exit;
}

if ($action == 'approve' && $id) {
    $qs = "UPDATE {$table_name} SET is_approved = 1 WHERE resource_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Resource Successfully approved");
    header("Location: {$table_name}");
    exit;
}

if ($action == 'disapprove' && $id) {
    $qs = "UPDATE {$table_name} SET is_approved = 0 WHERE resource_id = $id ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Resource Successfully disapproved");
    header("Location: {$table_name}");
    exit;
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields_res_cats = $_POST['res_cats'];
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';
    $fields['description'] = substr($fields['description'], 0, $desc_maxlength);
    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }

    if ($fields['name'] == '' || $fields['url'] == '') {
        $message = "Please enter required information";
    }
    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = " AND resource_id != $id ";
        $action_str = "UPDATE";
        $where_str = "WHERE resource_id=$id";
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
        if ($id == '') {
            $id = GetLastInsertId();
        }
        ExecuteQuery("DELETE FROM res_cat WHERE res_id = " . $id);
        foreach ($fields_res_cats as $rc) {
            if ($rc != '')
                ExecuteQuery("INSERT INTO res_cat SET res_id = $id, cat_id = $rc ");
        }
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Category {$action}ed successfully");
        header("Location: {$table_name}");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $resource = $fields;
}
$resource['is_approved'] = ($resource['is_approved'] == '' || is_null($resource['is_approved'])) ? '1' : $resource['is_approved'];

PreparePage(array(
    'title' => 'Resource: Modify', // Required
    'page_type' => 'Resource', // Required
    'page_action' => '', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($resource['name'] == null || $action == 'create') ? 'New Resource' : $resource['name'], // Required
));

$res_ins = new Resource();
$cat_ins = new Category();
?>
<script type="text/javascript" src="js/resource.js"></script>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="<?= $table_name ?>_modify.php?<?= $_SERVER['QUERY_STRING'] ?>" enctype="multipart/form-data">
            <ul>
                <li class="wide">
                    <label for="name">Resource Name:</label>
                    <input id="name" type='text' required name="q[name]" value="<?= $resource['name'] ?>" title="Name of the resource"/>
                </li>
                <li class="wide">
                    <label for="URL">URL:</label>
                    <input id="URL" type='text' required name="q[url]" value="<?= $resource['url'] ?>" title="URL of the resource"/>
                </li>
                <li class="wide">
                    <label for="description">Description:</label>
                    <textarea id="description" name="q[description]" maxlength='<?= $desc_maxlength ?>'  cols="" rows="6" placeholder=""><?= htmlspecialchars(TextFromDB($resource['description'])) ?></textarea><br/>
                    <span class='textarea_length_display'></span>
                </li>
                <li class="wide">
                    <label style="padding: 0;" for="">Is this resource approved?:</label>
                    <label class="form_radio" for="is_approved_yes">Yes</label>
                    <input class="form_radio" required id="is_approved_yes" type='radio' name="q[is_approved]" value="1" <?= ($resource['is_approved'] == '1') ? "checked" : '' ?> />
                    <label class="form_radio" for="is_approved_no">No</label>
                    <input class="form_radio" required id="is_approved_no" type='radio' name="q[is_approved]" value="0" <?= ($resource['is_approved'] == '0') ? "checked" : '' ?>/>
                </li>
                <!--li class="wide">
                    <br/><br/>
                    <label for="rating">Rating:</label>
                    <input id="rating" style="width: 3%;" type='text'  name="q[rating]" value="<?= $resource['rating'] ?>" title="Rating of the resource"/>
                    <div id="slider" style="margin-left: 5%;width: 50%;display: inline-block;"></div>
                    <br/><br/>
                </li-->
                <li class="wide">
                    <label for="parent">Emirate:</label>
                    <select id="parent" name="q[emirate_id]">
                        <option value=''>Select a Emirate</option>
                        <?
                        $all_cats = GetRows('emirates', '1 ORDER BY name');
                        foreach ($all_cats as $cat) {
                            echo "<option value='{$cat['emirate_id']}' ";
                            if ($cat['emirate_id'] == $resource['emirate_id'])
                                echo 'selected';
                            echo ">{$cat['name']}</option>";
                        }
                        ?>
                    </select>
                </li>
            </ul>
            <div style="clear: both"></div>
            <table width="95%" style="font-size: 1.11em;" id='res_cat_table'>
                <?
                // Autocomplete categories and category class for cat search with breadcrumbs
                $i = 1;
                if ($resource['resource_id'] != '')
                    $res_cats = $res_ins->GetResourceCategories($resource['resource_id']);
                if ($resource['resource_id'] == '' || count($res_cats) == 0) {
                    include 'resources_tr_cat.php';
                } else {
                    foreach ($res_cats as $res_cat) {
                        $cat_info = $cat_ins->GetCategoryInfo($res_cat);
                        include 'resources_tr_cat.php';
                        $i++;
                    }
                }
                ?>
            </table>
            <button class='form_button' type='button' id="add_cat" onclick="return false;"c>Add a category</button><br/><br/>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Resource"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
