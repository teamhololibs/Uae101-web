<?
require_once '../admin.common.prepend.php';

CheckPermissions("rolepermissions", 'super');

if (isset($_GET['id']) && $_GET['id'] != '')
    $role_id = $_GET['id'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: roles_manage.php");
    exit;
}

if ($role_id)
    $role = GetRowById('admin_roles', 'role_id', $role_id);

if (isset($_POST['submit']) && ($_POST['submit'] != '')) {
    $none_pages = $_POST['NONE'];
    $permissions = $_POST['permission'];
    $none = array();

    if (count($none_pages) > 0) {
        foreach ($none_pages as $none_page => $v) {
            AssignPermission($none_page, 'NONE');
            $none[] = $none_page;
        }
    }
    if (count($permissions) > 0) {
        foreach ($permissions as $page_id => $permission) {
            if (array_search($page_id, $none) !== false)
                continue;

            AssignPermission($page_id, implode(";", $permission));
        }
    }
    SetConfirmationMessage("Permissions successfully updated");
}

function AssignPermission($page_id, $type) {
    global $role_id;
    if (GetCount('admin_role_permissions', "role_id = '$role_id' AND page_id = '$page_id' ") > 0) {
        ExecuteQuery("UPDATE admin_role_permissions SET permission_type = '$type' WHERE role_id = '$role_id' AND page_id = '$page_id'");
    } else {
        ExecuteQuery("INSERT INTO admin_role_permissions SET permission_type = '$type', role_id = '$role_id', page_id = '$page_id'");
    }
}

$pages = GetRowsAsAssocArray("SELECT * FROM admin_pages WHERE active = 1");

PreparePage(array(
    'title' => "Permissions - " . SITE_NAME, // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Permissions', // Optional
    'page_extra_detail' => 'Edit', // Optional
    'page_heading' => $role['role_name'], // Required
));
?>
<? if (VIEW) { ?>
    <style type="text/stylesheet">
        table.td_center tr td{
            text-align: center;
        }
    </style>
    <div class="data_container">
        <form action="" method="post">
            <table class="paginated_data td_center" cellspacing='0' border="1" cellpadding="0">
                <tr>
                    <th>#</th>
                    <th>Filename</th>
                    <th>NONE</th>
                    <th>VIEW</th>
                    <th>SEARCH</th>
                    <th>CREATE</th>
                    <th>EDIT</th>
                    <th>DELETE</th>
                </tr>
                <?
                $i = 0;
                foreach ($pages as $page) {
                    $permission = array();
                    $permissions = GetRowsAsAssocArray("SELECT permission_type FROM admin_role_permissions WHERE role_id = '$role_id' AND page_id = '{$page['page_id']}' LIMIT 1");
                    $permissions = explode(";", $permissions[0]['permission_type']);
                    if (array_search("NONE", $permissions) !== false) {
                        $permission['NONE'] = 'checked';
                    } else {
                        foreach ($permissions as $p) {
                            $permission[$p] = 'checked';
                        }
                    }
                    ?>
                    <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                        <td><?= $page['page_id'] ?></td>
                        <td><?= $page['page_type'] ?></td>
                        <td><input type="checkbox" class="NONE" id="<?= $page['page_id'] ?>" name="NONE[<?= $page['page_id'] ?>]" value="NONE" <?= $permission['NONE'] ?>/></td>
                        <td><input type="checkbox" class="<?= $page['page_id'] ?>" name="permission[<?= $page['page_id'] ?>][]" value="VIEW" <?= $permission['VIEW'] ?>/></td>
                        <td><input type="checkbox" class="<?= $page['page_id'] ?>" name="permission[<?= $page['page_id'] ?>][]" value="SEARCH" <?= $permission['SEARCH'] ?>/></td>
                        <td><input type="checkbox" class="<?= $page['page_id'] ?>" name="permission[<?= $page['page_id'] ?>][]" value="CREATE" <?= $permission['CREATE'] ?>/></td>
                        <td><input type="checkbox" class="<?= $page['page_id'] ?>" name="permission[<?= $page['page_id'] ?>][]" value="EDIT" <?= $permission['EDIT'] ?>/></td>
                        <td><input type="checkbox" class="<?= $page['page_id'] ?>" name="permission[<?= $page['page_id'] ?>][]" value="DELETE" <?= $permission['DELETE'] ?>/></td>
                    </tr>
                <? } ?>
            </table>
            <input type="button" value="NONE" id="none_to_all"/>
            <input type="button" title="Recommended for Super Admins only" value="ALL to ALL" id="all_to_all"/>
            <input type="submit" value="Update Permissions" name="submit"/>
        </form>
        <script type="text/javascript">
            $(document).ready(function(){
                $('input[type="checkbox"]').each(function(){
                    if($(this).hasClass('NONE')){
                        if($(this).is(':checked')){
                            var page_id = $(this).attr('id');
                            DisableCheck(page_id);
                        }
                    }
                });
                $('#all_to_all').click(function(){
                    $('.NONE').prop('checked', false);
                    $('input[type="checkbox"]:not(.NONE)').prop('disabled', false);
                    $('input[type="checkbox"]:not(.NONE)').prop('checked', true);
                });
                $('#none_to_all').click(function(){
                    $('.NONE').prop('checked', true);
                    $('input[type="checkbox"]:not(.NONE)').prop('disabled', true);
                    $('input[type="checkbox"]:not(.NONE)').prop('checked', false);
                });
                $('.NONE').change(function(){
                    if($(this).is(':checked')){
                        var page_id = $(this).attr('id');
                        DisableCheck(page_id);
                    } else {
                        var page_id = $(this).attr('id');
                        EnableCheck(page_id);
                    }
                });
                function EnableCheck(page_id){
                    $('.' + page_id).prop('disabled', false);
                }
                function DisableCheck(page_id){
                    $('.' + page_id).prop('checked', false);
                    $('.' + page_id).prop('disabled', true);
                }
            });
        </script>
    </div>
<? } ?>
<? footer() ?>
