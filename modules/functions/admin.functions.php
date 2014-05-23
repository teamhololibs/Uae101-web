<?php

/**
 * @param array Please use this defintion: array(
  'title' => '',  // Required
  'page_type' => '',  // Required
  'page_action' => '',  // Optional
  'page_extra_detail' => '', // Optional
  'page_heading' => '', // Required
  'create_button' => '', // Optional
  )
 * @desc SHOULD ONLY BE CALLED JUST BEFORE RENDERING THE PAGE! Renders Top HTML of the admin page and assigns permissions constants for this page
 */
function PreparePage($page_info) {
//function PreparePage($title, $page_type, $page_action = '', $page_extra_detail = '', $page_heading, $create_button = '', $create_url = '', $permission_page) {

    $admin = Adminuser::GetInstance();

    if (!defined('NONE')) {
        SetConfirmationMessage("Error while checking permissions. Please contact admin", 'error');
        header("Location: index.php");
        exit;
    } else if (NONE) {
        header("Location: 403.php");
        exit;
    }

    $admin_username = $admin->GetAdminUsername();
    $admin_name = $admin->GetAdminName();

    if ($page_info['page_action'] != '')
        $page_info['page_action'] = " / " . $page_info['page_action'];
    if ($page_info['page_extra_detail'] != '')
        $page_info['page_extra_detail'] = " / " . $page_info['page_extra_detail'];

    if (!CREATE)
        $page_info['create_button'] = '';

    $page_info['admin_name'] = $admin_name;
    $page_info['admin_username'] = $admin_username;
    $page_info['menu'] = MakeMenu();
    $page_info['current_url'] = GetEncodedCurrentUrl();
    $page_info['site_name'] = SITE_NAME;

    require_once SERVER_PATH . WEB_DIRECTORY . 'header.php';
}

function footer() {
    require_once 'footer.php';
}

/**
 * @param string Name of the file for which the permissions are to be calculated
 * @param boolean For modify page, URL should have parameter as 'action' and value as 'edit', 'create', 'duplicate' or 'delete'
 * @desc Makes boolen constants of the assigned permissions
 */
function CheckPermissions($page, $type = '') {
    $admin = Adminuser::GetInstance();
    $admin->PagePermissions($page);

    // Check of modification permissions for the current page
    $permit_modify = true;
    switch ($type) {
        case '': break;
        case 'modify':
            switch ($_GET['action']) {
                case 'edit':
                    if (!EDIT)
                        $permit_modify = false;
                    break;
                case 'enable':
                case 'create':
                case 'duplicate':
                    if (!CREATE)
                        $permit_modify = false;
                    break;
                case 'delete':
                    if (!DELETE)
                        $permit_modify = false;
                    break;
                default:
                    $permit_modify = false;
                    break;
            }
            break;
        case 'super':
            CheckSuperAdminPrivileges();
            break;
        default:
            $permit_modify = false;
    }
    if (NONE || $permit_modify === false) {
        header("Location: 403.php");
        exit;
    }
}

/**
 * @return string HTML Menu rendered per user
 */
function MakeMenu() {

    include_once SERVER_PATH . WEB_DIRECTORY . 'menu.php';

    if (!isset($_SESSION['top_menu']) || $_SESSION['top_menu'] == null) {
        $pages_with_minimum_permissions = Adminuser::GetInstance()->GetAdminMenu();
        $_SESSION['top_menu'] = $pages_with_minimum_permissions;
    }
    $display_menu = CreateMenuHTML($full_menu, $_SESSION['top_menu']);

    return $display_menu;
}

/**
 * 
 * @param array Full menu array
 * @param array Pages that the admin is permitted to see
 * @return boolean|string
 */
function CreateMenuHTML($full_menu, $pages_to_display) {

    $html = "<ul>";
    foreach ($full_menu as $menu_name => $href_tag) {
        if (is_array($href_tag)) {
            $val = CreateMenuHTML($href_tag, $pages_to_display);
            if ($val !== false)
                $html .= "<li class = 'drop_down'>$menu_name" . $val . "</li>";
        } else {
            $item = explode(';', $href_tag);
            $href = $item[0];
            $tag = $item[1];
            if (array_search($tag, $pages_to_display) !== false) {
                $html .= "<li";
                if (trim($_SERVER['REDIRECT_URL'], " /") == $href)
                    $html .= " class = 'selected' ";
                $html .= "><a href = '$href'>$menu_name</a></li>";
            }
        }
    }
    $html .= "</ul>";

    if ($html == "<ul></ul>")
        return false;
    else
        return $html;
}

/**
 * @param string The parameter to clean up
 * @return string The same URL without the parameter mentioned
 */
function GetUrlPrefix($type = 'scope') {
    $site_prefex = "?" . preg_replace("/&*x\[$type\]=(\w|[-_.])+/", "", $_SERVER['QUERY_STRING']);
    return $site_prefex;
}

/**
 * @desc Called after permissins are allocated. Checks if all the permissions are allocated to the user for this page. Used for pages that control whole site functionality.
 */
function CheckSuperAdminPrivileges() {
    if (NONE || !(VIEW && EDIT && CREATE && SEARCH && DELETE)) {
        header("Location: 403.php");
        exit;
    }
}

function GetProgLangsMenu($scope_var = 'lang') {
    $lang_prefix = GetUrlPrefix($scope_var);
    $prog_langs = GetRows('prog_languages', 'active = 1');
    $html = '';
    if (count($prog_langs) > 0) {
        foreach ($prog_langs as $prog_lang) {
            $lang_selected = "lang_{$prog_lang['prog_lang_id']}_selected";
            global $$lang_selected;
            $html .= "<span class='{$$lang_selected}'>";
            $html .= "<a href='{$lang_prefix}&x[lang]={$prog_lang['prog_lang_id']}'>{$prog_lang['name']}</a></span>";
        }
    }
    return $html;
}

function GetProgLangFromUrl() {
    $prog_land_id_url = '1';
    if (isset($_REQUEST['x'])) {
        $x = $_REQUEST['x'];
        if (isset($x['lang']) && $x['lang'] != '') {
            $prog_land_id_url = $x['lang'];
        }
    }
    return $prog_land_id_url;
}

function AdminGetArticleTagsHtml($art_tags) {
    $html = '';
    foreach ($art_tags as $tag) {
        $html .= "<span class='tag_whole' title='$tag_id' id='tag_{$tag['tag_id']}'>";
        $html .= "<span class='tag'>{$tag['tag_name']}</span>";
        $html .= "<span id='tag_x_{$tag['tag_id']}' class='tag tag_x'>X</span>";
        $html .= "</span>";
    }
    return $html;
}