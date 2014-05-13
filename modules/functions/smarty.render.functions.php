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

    $tpl->assign('META_TITLE', $GLOBALS['page_title']);
    $tpl->assign('MAIN_CONTENT', $MAIN_CONTENT);
    $tpl->assign('LEFT_MENU', GetLeftMenu());

    if (defined('USE_PQP_PROFILER') && USE_PQP_PROFILER)
        $_SESSION['PQP_SHOW'] = true;

    return $tpl->fetch('main.tpl');
}

function GetLeftMenu() {
    $categories_tree = Category::GetCategoryFullTree();
    $tpl = new SmartyCustom;
    $tpl->assign('categories_tree', $categories_tree);
    $html = $tpl->fetch('common/left_category_menu.tpl');
    return $html;
}

function ResourcesPage() {
    $GLOBALS['page_title'] = 'Yuhoo! Hololibs';
    //$cat_text = $_GET['cat_text'];
    $resources_ins = new Resource;
    $resources = $resources_ins->GetResources();
    
    $tpl = new SmartyCustom;
    $tpl->assign('resources', $resources);
    $html = $tpl->fetch('resource_box.tpl');
    
    return RenderPage($html);
}
