<?
require_once '../admin.common.prepend.php';

CheckPermissions("prog_languages", 'modify');

if (isset($_REQUEST['action']) && $_REQUEST['action'] != '')
    $action = $_REQUEST['action'];
else {
    SetConfirmationMessage("Invalid URL parameters", 'error');
    header("Location: prog_languages_manage.php");
    exit;
}

$id = false;
if (isset($_GET['id']) && $_GET['id'] != '')
    $id = $_GET['id'];

if ($action == 'edit' && $id) {
    $lang = GetRowById('prog_languages', 'prog_lang_id', $id);
}

if ($action == 'delete' && $id) {
    $qs = "UPDATE prog_languages SET active = 0 WHERE prog_lang_id = '$id' ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Page Successfully deleted");
    header("Location: prog_languages_manage.php?&x[scope]=0");
    exit;
}

if ($action == 'enable' && $id) {
    $qs = "UPDATE prog_languages SET active = 1 WHERE prog_lang_id = '$id' ";
    $res = ExecuteQuery($qs);
    if (!$res) {
        echo "error";
    }
    SetConfirmationMessage("Page Successfully re-enabled");
    header("Location: prog_languages_manage.php");
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
        $where_validation = "&& prog_lang_id != '$id' ";
        $action_str = "UPDATE";
        $where_str = "WHERE prog_lang_id='$id'";
    }
    if ($action == 'create')
        $action_str = "INSERT INTO";

    if ($action_str)
        $qs = "$action_str prog_languages $set_str $where_str";

    if (GetCount("prog_languages", "name = '{$fields['name']}' $where_validation ")) {
        $message = "This language already exists.";
    }

    if ($message == '') {
        $res = ExecuteQuery($qs);
        if (!$res) {
            echo "error";
        }
        SetConfirmationMessage("Prog Lang created successfully");
        header("Location: prog_languages_manage.php");
        exit;
    } else {
        SetConfirmationMessage($message, 'error');
    }

    $lang = $fields;
}

PreparePage(array(
    'title' => 'Prog Languages :: SP', // Required
    'page_type' => 'Prog Languages', // Required
    'page_extra_detail' => "$action", // Optional
    'page_heading' => ($lang['name'] == null || $action == 'create') ? 'New Page' : $lang['name'], // Required
));
?>
<script type="text/javascript">
</script>
<div class="data_container">
    <div class="form_fields">
        <form method="post" action="prog_languages_modify.php?<?= $_SERVER['QUERY_STRING'] ?>">
            <ul>
                <li class="wide">
                    <label for="name">Name:</label>
                    <input id="name" type='text' class="required" name="q[name]" value="<?= $lang['name'] ?>" title="Name of the prog language"/>
                </li>
            </ul>
            <div class='form_button'>
                <input class="button" type="submit" name="submit" value="<?= $action ?> Prog Language"/>
            </div>
        </form>
    </div>
</div>
<? footer() ?>
