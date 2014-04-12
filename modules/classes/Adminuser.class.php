<?php

class Adminuser {

    protected $admin_id;
    protected $admin_info = array();
    static protected $admin_instance = null;

    function __construct($admin_info = NULL) {
        if ($admin_info !== NULL) {
            $this->admin_info = $admin_info;
            $this->admin_id = $admin_info['admin_id'];
            return $this;
        }
    }

    static public function GetInstance() {
        if (self::$admin_instance) {
            return self::$admin_instance;
        } else {
             $admin = new Adminuser($_SESSION['adminuser_information']);
            if ($admin->IsAdminLoggedIn()) {
                self::$admin_instance = $admin;
                return self::$admin_instance;
            } else {
                header("Location: logout.php");
                exit;
            }
        }
    }

    /**
     * @return bool Validates User with his email or password. Sets a session with user's information and returns true OR returns false if the validations fails
     * @param string Either user's username or email
     * @param string Password entered by user
     */
    public function LoginUser($email_or_username, $password_entered) {
        if (stripos($email_or_username, "@")) {
            $field = 'email';
        } else {
            $field = 'username';
        }
        $user_count = GetCount('admin_users', " $field = '$email_or_username' AND active = '1'");
        if ($user_count == 0) {
            return false;
        } else {
            $user_password = GetInfoById('admin_users', $field, $email_or_username, 'password');
            $password_validation = HashPassword($password_entered, $user_password);
            if ($password_validation == true) {
                $this->admin_info = GetRowById("admin_users", $field, $email_or_username, "admin_id, name, email, username, admin_role_id");
                $this->admin_id = $this->admin_info['admin_id'];
                $_SESSION['adminuser_information'] = $this->admin_info;
                ExecuteQuery("INSERT INTO admin_user_activities SET admin_user_id = '$this->admin_id', activity='login', additional_remark = NOW()");
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * @param string Name of the file for which the permissions are to be calculated
     * @desc Makes boolen constants of the assigned permissions
     */
    public function PagePermissions($permission_page) {

        $current_page = trim($permission_page);

        $current_page_id = GetInfoById('admin_pages', 'page_type', $current_page, 'page_id');
        if (!$current_page_id) {
            define('NONE', true);
            return;
        }
        $page_permissions = GetInfoById('admin_role_permissions', "role_id", $this->admin_info['admin_role_id'], 'permission_type', "page_id = '$current_page_id'");

        $page_permissions = explode(';', $page_permissions);
        if (!count($page_permissions) || (array_search('NONE', $page_permissions, true) !== false)) {
            define('NONE', true);
            return;
        } else {
            define('NONE', false);
        }

        $all_permissions = array('VIEW', 'SEARCH', 'EDIT', 'CREATE', 'DELETE');

        foreach ($all_permissions as $permission) {
            if (array_search($permission, $page_permissions, true) !== false)
                define("$permission", true);
            else
                define("$permission", false);
        }
        if (EDIT || DELETE)
            define("ACTION", true);
        else
            define("ACTION", false);
    }

    /**
     * @return array Returns a list of pages with minimum permissions for Menu generation
     */
    public function GetAdminMenu() {
        $role_id = $this->admin_info['admin_role_id'];
        $where = "
                page_id IN (
                SELECT rp.page_id
                FROM admin_role_permissions rp
                WHERE
                rp.role_id = '$role_id'
                AND rp.permission_type NOT LIKE '%NONE%'
                )
                ORDER BY page_type";
        $pages_with_minimum_permissions = GetColumnInfo("admin_pages ", "page_type", $where);
        return $pages_with_minimum_permissions;
    }

    /**
     * @return bool True if admin is logged in, false if not
     */
    public function IsAdminLoggedIn() {
        if (isset($_SESSION['adminuser_information']) && $_SESSION['adminuser_information'] !== NULL && is_array($_SESSION['adminuser_information'])) {
            if (!isset($_SESSION['last_activity']) || (time() - $_SESSION['last_activity'] > LOGIN_SESSION_TIMEOUT)) {
                $current_url = GetEncodedCurrentUrl();
                header("Location: logout.php?from=$current_url&username=" . $this->admin_info['username']);
                exit;
            } else
                $_SESSION['last_activity'] = time();
            return true;
        } else {
            return false;
        }
    }

    /**
     * @return integer User's ID
     */
    public function GetAdminId() {
        return $this->admin_id;
    }

    public function GetAdminUsername() {
        return $this->admin_info['username'];
    }

    public function GetAdminName() {
        return $this->admin_info['name'];
    }

    public function GetAdminEmail() {
        return $this->admin_info['email'];
    }

    public function GetAdminPagePermissions() {
        return $this->page_permissions;
    }

    /**
     * @return array Returs admin_id, name, email, username
     */
    public function GetAdminInformation() {
        return $this->admin_info;
    }

}

?>
