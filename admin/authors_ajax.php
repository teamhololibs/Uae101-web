<?

require_once '../admin.common.prepend.php';

if (isset($_GET['operation']) && $_GET['operation'] == 'get_authors') {
    $auth_str = $_POST['auto_str'];
    $auth_ins = new Author();
    $auths = $auth_ins->GetAuthorSearchFullInfo($auth_str);
    //$auts = GetColumnInfo("authors", "name", "author_id LIKE '%{$aut_str}%' ");
    echo json_encode($auths);
}