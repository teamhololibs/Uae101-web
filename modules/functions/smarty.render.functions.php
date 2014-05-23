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
    $categories_tree = Category::GetCategoryFullTree();
    $tpl = new SmartyCustom;
    $tpl->assign('categories_tree', $categories_tree);
    $html = $tpl->fetch('common/left_category_menu.tpl');
    return $html;
}

function ResourcesPage() {
    $tpl = new SmartyCustom;
    $resources_ins = new Resource;
    $resource_search = '';
    if (isset($_GET['res_id']) && $_GET['res_id'] != '') {
        $res_id = TextToDB($_GET['res_id']);
        //$GLOBALS['page_title'] = "$resource_search - Search in ";
        $resources[0] = $resources_ins->GetResourceInfo($res_id);
        $tpl->assign('resources', $resources);
        $html = $tpl->fetch('resource_box.tpl');
        return $html;
    }

    if (isset($_GET['search']) && $_GET['search'] != '') {
        $resource_search = TextToDB($_GET['search']);
        $GLOBALS['page_title'] = "$resource_search - Search in ";
    }
    if (isset($_GET['resource']) && $_GET['resource'] != '') {
        $resource_id = TextToDB($_GET['resource']);
        $GLOBALS['page_title'] = "$resource_id - Search in ";
    }
    $category_search_id = '';
    if (isset($_GET['tag']) && $_GET['tag'] != '') {
        $category_search_id = TextToDB($_GET['tag']);
    }

    $GLOBALS['page_title'] .= "Hololibs";
    $resources = $resources_ins->GetResources($resource_search, $category_search_id, $resource_id, $author_id);

    if (count($resources) > 0) {
        $tpl->assign('resources', $resources);
        $html = $tpl->fetch('resource_box.tpl');
    } else {
        $html = $tpl->fetch('resource_box_notfound.tpl');
    }

    return $html;
}

function Page404() {
    $tpl = new SmartyCustom;
    $html = $tpl->fetch('404.tpl');
    return $html;
}
