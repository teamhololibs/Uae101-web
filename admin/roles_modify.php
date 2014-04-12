<?
require_once '../admin.common.prepend.php';

CheckPermissions("adminroles", 'super');

$action = false;
if (isset($_GET['action']) && $_GET['action'] != '')
    $action = $_GET['action'];

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = $_GET['id'];

if ($action == 'delete' && $id) {
    $res = ExecuteQuery("UPDATE admin_roles SET active = 0 WHERE role_id = '$id' ");
    if (!$res) {
        SetConfirmationMessage("Mysql query could not be executed", 'error');
    } else {
        SetConfirmationMessage("Role successfully deleted");
        header("Location: roles_manage.php");
        exit;
    }
}
if ($action == 'edit' && $id) {
    $role = GetRowById('admin_roles', 'role_id', $id);
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';
    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        $set_str .= " $k = '$v', ";
    }

    $addition_where = '';
    if ($action == 'edit')
        $addition_where = "AND role_id != '$id' ";

    if (count(GetRowById("admin_roles", "role_name", $fields['role_name'], '*', "active = 1 $addition_where")) > 0)
        $message = "This role name is taken. Please use another";

    if ($message == '') {
        $action_str = false;
        $set_str = (trim($set_str, ' ,'));
        if ($action == 'edit' && $id) {
            $action_str = "UPDATE";
            $where_str = "WHERE role_id='$id'";
        }
        if ($action == 'create')
            $action_str = "INSERT INTO";

        if ($action_str)
            $qs = "$action_str admin_roles $set_str $where_str";

        $res = ExecuteQuery($qs);
        if (!$res) {
            SetConfirmationMessage("Mysql query could not be executed", 'error');
        } else {
            SetConfirmationMessage("Role successfully updated");
            header("Location: roles_manage.php");
            exit;
        }
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $role = $fields;
}

PreparePage(array(
    'title' => 'Roles', // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Role', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($role['role_name'] == null) ? 'New Role' : $role['role_name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="roles_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="role_name">Name:</label>
                    <input id="role_name" type='text' requied name="q[role_name]" value="<?= $role['role_name'] ?>" title="Name of the role"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> User"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
