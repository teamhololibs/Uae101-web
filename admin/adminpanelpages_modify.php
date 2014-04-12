<?
require_once '../admin.common.prepend.php';

CheckPermissions("adminpages", 'super');

if (isset($_REQUEST['action']) && $_REQUEST['action'] != '')
    $action = $_REQUEST['action'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: adminpanelpages_manage.php");
    exit;
}

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = TextFromDB($_GET['id']);

if ($action == 'edit' && $id) {
    $pages = GetRowById('admin_pages', 'page_id', $id);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE admin_pages SET active = 0 WHERE page_id = '$id' ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Page Successfully deleted");
    header("Location: adminpanelpages_manage.php");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE admin_pages SET active = 1 WHERE page_id = '$id' ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Page Successfully enabled");
    header("Location: adminpanelpages_manage.php");
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

    $set_str = (trim($set_str, ' ,'));

    $action_str = false;
    if ($action == 'edit' && $id) {
        $where_validation = "&& page_id != '$id' ";
        $action_str = "UPDATE";
        $where_str = "WHERE page_id='$id'";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str admin_pages $set_str $where_str";

    if (GetCount("admin_pages", "page_type = '{$fields['page_type']}' $where_validation ")) {
        $message = "This file already exists. Please use another page_type";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Page {$action}ed successfully");
        header("Location: adminpanelpages_manage.php");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $pages = $fields;
}

PreparePage(array(
    'title' => 'Pages in Admin Panel', // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Pages in Admin Panel', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($pages['file_description'] == null || $action == 'create') ? 'New Page' : $pages['file_description'], // Required
));
?>
<script type="text/javascript">
</script>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="adminpanelpages_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="page_type">Page Type:</label>
                    <input id="page_type" type='text' class="required" name="q[page_type]" value="<?= $pages['page_type'] ?>" title="Type of the file"/>
                </li>
                <li class="wide">
                    <label for="file_description">File Description:</label>
                    <input id="file_description" type='text' class="required" name="q[file_description]" value="<?= $pages['file_description'] ?>" title="Name of the file"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Page"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
