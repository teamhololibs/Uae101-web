<?php

/**
 * @param MAIN_CONTENT - html page rendered using Smarty fetch method
 * @desc Renders the whole page along with the main content in the middle
 */
function RenderPage($MAIN_CONTENT) {

    $tpl = new SmartyCustom;

//    $user = new User();
//    $tpl->assign('USER_LOGGED_IN', $user->IsUserLoggedIn());
//    $tpl->assign('USER_ID', $user->GetUserID());
//    $tpl->assign('USERNAME', $user->GetUserUsername());
//    $tpl->assign('USER_EMAIL', $user->GetUserEmail());
//    $tpl->assign('USER_INFORMATION', $user->GetUserInformation());
//
//    switch ($GLOBALS['selected_page']) {
//        case '':
//        case '/':
//            $page = "TAGS";
//            break;
//        case 'REGISTER':
//            $page = "REGISTER";
//            break;
//        case 'DUMMY':
//            $page = "DUMMY";
//            break;
//        default:
//            $page = "TAGS";
//    }
//    $tpl->assign("SELECTED_$page", "selected");
//
//    if (IsUserLoggedIn())
//        $tpl->assign('USER_INFORMATION_OR_LOGIN_AREA', GetUserInformationArea());
//    else
//        $tpl->assign('USER_INFORMATION_OR_LOGIN_AREA', GetUserLogin());

    $tpl->assign('MAIN_CONTENT', $MAIN_CONTENT);
    $tpl->assign('LEFT_MENU', GetLeftMenu());

    if (isset($_GET['search']) && $_GET['search'] != '') {
        $tpl->assign('search_text', $_GET['search']);
    }

    if (defined('USE_PQP_PROFILER') && USE_PQP_PROFILER)
        $_SESSION['PQP_SHOW'] = true;

    return $tpl->fetch('main.tpl');
}

function GetLeftMenu() {
    if (isset($_GET['category_name']) && $_GET['category_name'] != '') {
        $cat_name = trim(TextToDB($_GET['category_name']));
    }
    $cat_ins = new Category();
    $categories_tree = $cat_ins->GetCategorySearch($cat_name);
    $tpl = new SmartyCustom;
    if (isset($_GET['category']) && $_GET['category'] != '') {
        $category_id = $_GET['category'];
        for ($i = 0; $i < count($categories_tree); $i++) {
            if ($categories_tree[$i]['cat_id'] == $category_id) {
                $categories_tree[$i]['selected'] = 'selected';
                break;
            }
        }
    }
    $emirate_link = 'all';
    if ($_GET['emirate'] != '' && isset($_GET['emirate']) && is_numeric($_GET['emirate'])) {
        $emirate_link = $_GET['emirate'];
    }
    $tpl->assign('emirate_link', $emirate_link);
    $tpl->assign('links', $categories_tree);
    $html = $tpl->fetch('common/left_category_menu.tpl');
    return $html;
}

function EmiratesRow() {

    $tpl = new SmartyCustom;

    $ajax = false;
    if ($_GET['ajax'] != '' && isset($_GET['ajax']) && $_GET['category'] == '1') {
        $ajax = true;
    }

    $cat_link = 'all';
    $category_search = 'All categories';
    if ($_GET['category'] != '' && isset($_GET['category']) && is_numeric($_GET['category']) && $_GET['category'] != 'all') {
        $cat_link = TextToDB($_GET['category']);
        if($ajax === false)
            $category_search = GetInfoById('categories', 'cat_id', $cat_link, 'name');
    }

    $em_search = 'All emirates';
    $em_link = 'all';
    if ($_GET['emirate'] != '' && isset($_GET['emirate']) && is_numeric($_GET['emirate']) && $_GET['emirate'] != 'all') {
        $em_link = TextToDB($_GET['emirate']);
        if($ajax === false)
            $em_search = GetInfoById('emirates', 'emirate_id', $em_link, 'name');
    }

    $emirates = GetRows('emirates', "1 ORDER BY name");
    if($em_link != 'all' && $ajax === false){
        for ($i = 0; $i < count($emirates); $i++) {
            if($emirates[$i]['emirate_id'] == $em_link){
                $emirates[$i]['selected'] = 'emirate_selected';
            }
        }
    } else {
        $emirate_all_selected = 'emirate_selected';
    }

    $tpl->assign('category_search', $category_search);
    $tpl->assign('em_search', $em_search);
    $tpl->assign('emirate_all_selected', $emirate_all_selected);
    $tpl->assign('cat_link', $cat_link);
    $tpl->assign('emirates', $emirates);
    $html = $tpl->fetch('emirates_row.tpl');
    return $html;
}

function ResourcesPage() {

    $tpl = new SmartyCustom;
    $resources_ins = new Resource;
    $resource_search = '';
    $tpl_name = 'resources_view.tpl';
    $html = '';

    if (isset($_GET['search']) && $_GET['search'] != '') {
        $resource_search = TextToDB($_GET['search']);
        $title = "Search $resource_search";
    }
    $category_search_id = '';
    if (isset($_GET['category']) && $_GET['category'] != '' && $_GET['category'] != 'all') {
        $category_search_id = TextToDB($_GET['category']);
    }
    if (isset($_GET['emirate']) && $_GET['emirate'] != '' && $_GET['emirate'] != 'all') {
        $emirate_id = TextToDB($_GET['emirate']);
    }

    $emirates = $resources_ins->GetResources($resource_search, $category_search_id, $emirate_id);

    $html .= EmiratesRow();

    if (count($emirates) > 0) {

        $cat_link = 'all';
        if ($_GET['category'] != '' && isset($_GET['category']) && is_numeric($_GET['category']) && $_GET['category'] != 'all') {
            $cat_link = $_GET['category'];
        }
        $tpl->assign('cat_link', $cat_link);
        $tpl->assign('info', $emirates);
        $html .= $tpl->fetch($tpl_name);
    } else {

        $html .= $tpl->fetch('resource_box_notfound.tpl');
    }

    $GLOBALS['page_title'] = GetTitle($title);
    $return['title'] = $GLOBALS['page_title'];
    $return['data'] = $html;
    return $return;
}

function GetTitle($title = '') {
    if ($title != '') {
        return $title . " - " . SITE_NAME;
    } else {
        return SITE_NAME;
    }
}

function Page404() {
    $tpl = new SmartyCustom;
    $html = $tpl->fetch('404.tpl');
    return $html;
}

function SubmitLibrary() {
    $tpl = new SmartyCustom;
    $cfg = new Config;
    $res_ins = new Resource;
    $submitted = 0;
    $fields = $_POST['f'];
    if ($_POST['stuff'] != '') {
        $error = 'Argh! You are a bot!';
    } else if (isset($_POST['f']) && count($_POST['f']) > 0) {
        $res = $res_ins->InsertResource($fields);
        if ($res > 0) {
            $submitted = 1;
        } else {
            $error = $res;
        }
    }
    $desc_maxlength = $cfg->GetConfig("RESOURCE_DESCRIPTION_MAXLENGTH");
    $tpl->assign('error', $error);
    $tpl->assign('submitted', $submitted);
    $tpl->assign('desc_maxlength', $desc_maxlength);
    $tpl->assign('f', $fields);
    $tpl->assign('emirates', GetRows('emirates' , "1 ORDER BY name"));
    $html = $tpl->fetch('submit_library.tpl');
    return $html;
}
