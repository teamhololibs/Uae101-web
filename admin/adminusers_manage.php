<?
require_once '../admin.common.prepend.php';

CheckPermissions("adminusers", 'super');

$users = GetRowsAsAssocArray("SELECT * FROM admin_users WHERE active = 1");

PreparePage(array(
    'title' => 'Administrators', // Required
    'page_type' => 'Super Admin', // Required
    'page_action' => 'Administrators', // Optional
    'page_extra_detail' => '', // Optional
    'page_heading' => 'Administrators', // Required
    'create_button' => '<a class="make_dialog anchor_button create_button_text" href="adminusers_modify.php?action=create">Create a New Users</a>', // Optional
));
?>
<? if (VIEW) { ?>
    <div class="data_container">
        <table class="paginated_data" cellspacing='0' cellpadding="0">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Username</th>
                <th>Role</th>
                <th>Last Updated</th>
                <th>Last Login</th>
                <th>Recent Activity</th>
                <? if (ACTION) { ?>
                    <th>
                        Actions
                    </th>
                <? } ?>
            </tr>
            <?
            $i = 0;
            foreach ($users as $user) {
                $login = GetRowsAsAssocArray("SELECT additional_remark FROM admin_user_activities WHERE admin_user_id = '{$user['admin_id']}' AND activity = 'login' ORDER BY activity_id DESC LIMIT 1 ");
                $recent_activities = GetRowsAsAssocArray("SELECT * FROM admin_user_activities WHERE admin_user_id = '{$user['admin_id']}' AND activity != 'login' ORDER BY activity_id DESC LIMIT 5 ");
                ?>
                <tr <?= ($i++ % 2 != 0) ? "class='odd'" : '' ?> >
                    <td><?= $user['admin_id'] ?></td>
                    <td><?= $user['name'] ?></td>
                    <td><?= $user['email'] ?></td>
                    <td><?= $user['username'] ?></td>
                    <td><a href="/rolepermissions_manage.php?action=edit&id=<?= $user['admin_role_id'] ?>"><?= GetInfoById('admin_roles', 'role_id', $user['admin_role_id'], 'role_name') ?></a></td>
                    <td><?= $user['last_updated'] ?></td>
                    <td><?= $login[0]['additional_remark'] ?></td>
                    <td>
                        <?
                        if (count($recent_activities) > 0) {
                            foreach ($recent_activities as $recent_activity) {
                                echo $recent_activity['created'] . ": " . $recent_activity['activity'] . " - " . $recent_activity['additional_remark'];
                                echo "<br/>";
                            }
                            echo "<a href=''>Full list of activity</a>";
                        } else {
                            echo "No recent activity";
                        }
                        ?>
                    </td>
                    <? if (ACTION) { ?>
                        <td>
                            <? if (EDIT) { ?><a class="make_dialog" href="adminusers_modify.php?action=edit&id=<?= $user['admin_id'] ?>"/>Edit</a><br/><? } ?>
                            <? if (DELETE) { ?><a onclick="return confirm('Are you sure you want to delete this user?')" href="adminusers_modify.php?action=delete&id=<?= $user['admin_id'] ?>"/>Delete</a><br/><? } ?>
                        </td>
                    <? } ?>
                </tr>
            <? } ?>
        </table>
    </div>
<? } ?>
<? footer() ?>
