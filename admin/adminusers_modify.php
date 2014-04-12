<?
require_once '../admin.common.prepend.php';

CheckPermissions("adminusers", 'super');

$action = false;
if (isset($_GET['action']) && $_GET['action'] != '')
    $action = $_GET['action'];

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = $_GET['id'];

if ($action == 'delete' && $id) {
    $res = ExecuteQuery("UPDATE admin_users SET active = 0 WHERE admin_id = '$id' ");
    if (!$res) {
        SetConfirmationMessage("Mysql query could not be executed", 'error');
    } else {
        SetConfirmationMessage("User successfully deleted");
        header("Location: adminusers_manage.php");
        exit;
    }
}
if ($action == 'edit' && $id) {
    $user = GetRowById('admin_users', 'admin_id', $id);
}

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $fields = $_POST['q'];
    $set_str = 'SET ';
    $message = '';
    foreach ($fields as $k => $v) {
        $v = TextToDB(trim($v));
        if ($k == 'password')
            continue;
        $set_str .= " $k = '$v', ";
    }

    if ($action == 'create') {
        if ($fields['password'] == '')
            $message = "Password cannot be empty for admin creation";


        $set_str .= " created=NOW(), ";
    }

    $addition_where = '';
    if ($action == 'edit')
        $addition_where = "AND admin_id != '$id' ";

    if (count(GetRowById("admin_users", "email", $fields['email'], '*', "active = 1 $addition_where")) > 0)
        $message = "This email is taken. Please use another email";

    if (count(GetRowById("admin_users", "username", $fields['username'], '*', "active = 1 $addition_where")) > 0)
        $message = "This username is taken. Please use another username";

    if ($fields['password'] != '')
        $set_str .= " password = '" . HashPassword($fields['password']) . "', ";

    if ($message == '') {
        $action_str = false;
        $set_str = (trim($set_str, ' ,'));
        if ($action == 'edit' && $id) {
            $action_str = "UPDATE";
            $where_str = "WHERE admin_id='$id'";
        }
        if ($action == 'create')
            $action_str = "INSERT INTO";

        if ($action_str)
            $qs = "$action_str admin_users $set_str $where_str";

        $res = ExecuteQuery($qs);
        if (!$res) {
            SetConfirmationMessage("Mysql query could not be executed", 'error');
        } else {
            SetConfirmationMessage("User successfully updated");
            header("Location: adminusers_manage.php");
            exit;
        }
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $user = $fields;
}

PreparePage(array(
    'title' => 'Administrators', // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Administrators', // Optional
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($user['name'] == null) ? 'New Administrator' : $user['name'], // Required
));
?>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="adminusers_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Name:</label>
                    <input id="name" type='text' class="required" name="q[name]" value="<?= $user['name'] ?>" title="Name of the admin"/>
                </li>
                <li class="wide">
                    <label for="email">Email:</label>
                    <input id="email" type='text' class="required" name="q[email]" value="<?= $user['email'] ?>" title="Email of the admin"/>
                </li>
                <li class="wide">
                    <label for="username">Username:</label>
                    <input id="username" type='text' class="required" name="q[username]" value="<?= $user['username'] ?>" title="Username of the admin"/>
                </li>
                <li class="wide">
                    <label for="role">Role:</label>
                    <select id="role" name="q[admin_role_id]">
                        <option>Select a Role</option>
                        <?
                        $roles = GetRows('admin_roles', 'active = 1');
                        foreach ($roles as $role) {
                            echo "<option value='{$role['role_id']}' ";
                            if ($role['role_id'] == $user['admin_role_id'])
                                echo 'selected';
                            echo ">{$role['role_name']}</option>";
                        }
                        ?>
                    </select>
                </li>

                <li class="wide">
                    <label for="password">Password (if not changing, then leave it empty):</label>
                    <input id="password" type='password' class="" name="q[password]" />
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> User"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
