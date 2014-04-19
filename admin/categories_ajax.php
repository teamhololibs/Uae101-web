<?

require_once '../admin.common.prepend.php';

if (isset($_GET['operation']) && $_GET['operation'] == 'get_categories') {
    $cat_str = $_POST['auto_str'];
    $cat_ins = new Category();
    $cats = $cat_ins->GetCategorySearchFullInfo($cat_str);
    echo json_encode($cats);
}