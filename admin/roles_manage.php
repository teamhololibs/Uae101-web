<?
require_once '../admin.common.prepend.php';

CheckPermissions("adminroles", 'super');

$roles = GetRowsAsAssocArray("SELECT * FROM admin_roles WHERE active = 1 ORDER BY role_name");

PreparePage(array(
    'title' => 'Roles :: SP', // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Roles', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => 'Roles', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="roles_modify.php?action=create">Create a New Role</a>', // Optional
));
?>
<? if (VIEW) { ?>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Actions</th>
            </tr>
            <?
            $i = 0;
            foreach ($roles as $role) {
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $role['role_id'] ?></td>
                    <td><?= $role['role_name'] ?></td>
                    <? if (ACTION) { ?>
                        <td>
                            <a href="rolepermissions_manage.php?action=edit&id=<?= $role['role_id'] ?>"/>Edit Permissions</a><br/>
                            <? /* if (DELETE) { ?>
                              <a onclick="return confirm('Are you sure you want to delete this role?')" href="roles_modify.php?action=delete&id=<?= $role['role_id'] ?>"/>Delete</a>
                              <br/>
                              <? } */ ?>
                        </td>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
