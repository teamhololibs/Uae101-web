<?php
define('CHECK_IF_LOGGED_IN', false);
require_once '../admin.common.prepend.php';

$credential = GetUrlDecodedValue($_GET['username']);
if (isset($_POST['login'])) {
    $admin = new Adminuser;
    if ($admin->LoginUser(TextToDB($_POST['credential']), TextToDB($_POST['password']))) {
        $_SESSION['last_activity'] = time();
        $url = 'index.php';
        if (isset($_GET['from']) && $_GET['from'] != '') {
            $redirect_to = GetUrlDecodedValue($_GET['from']);
            if (ValidateFileExistsFromUrl($redirect_to))
                $url = $redirect_to;
        }
        header("Location: $url");
        exit;
    } else {
        $credential = $_POST['credential'];
    }
}
?>

<form action="" method="post">
    <input placeholder="Username/Email" type="text" name="credential" id="credential" value="<?= $credential ?>"/><br/>
    <input placeholder="Password" type="password" name="password" id="password"/><br/>
    <script>
<? if ($credential != '') { ?>
                document.getElementById('password').focus();
<? } else { ?>
                document.getElementById('credential').focus();
<? } ?>
    </script>
    <input type="submit" name="login" value="Login"/>
</form>