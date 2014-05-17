<?php

class Category {

    private $category_id;
    private $category_info = array();
    private $category_full_name;
    private $category_search_str;
    private $parent_id;
    private $parent_info = array();
    private $categories = array();
    static private $full_categories_tree = array();

    /**
     * @return array Full Category tree array
     */
    static public function GetCategoryFullTree() {
        if (CATEGORY_TREE_SESSION_FLAG === true) {
            if (time() - $_SESSION['category_last_retrieved'] < CATEGORY_TREE_SESSION_TIMEOUT) {
                self::$full_categories_tree = $_SESSION['FULL_CATEGORIES_TREE'];
                return $_SESSION['FULL_CATEGORIES_TREE'];
            }
        }
        $parents = GetRows("categories", "parent_id = 0 AND active = 1 ORDER BY name", "*, REPLACE(name,' ','-') AS hyphenated_name ");
        foreach ($parents as $parent) {
            self::$full_categories_tree[$parent['cat_id']] = $parent;
            self::$full_categories_tree[$parent['cat_id']]['children'] = GetRows("categories", "parent_id = {$parent['cat_id']} AND active = 1 ORDER BY name", "cat_id, active, name, parent_id, REPLACE(name,' ','-') AS hyphenated_name ");
        }
        $_SESSION['FULL_CATEGORIES_TREE'] = self::$full_categories_tree;
        return self::$full_categories_tree;
        //Debug::dump(self::$full_categories_tree);
    }

    public function SetCategoryId($cat_id) {
        if ($cat_id != '')
            $this->category_id = TextToDB($cat_id);
    }

    public function SetParentId($parent_id) {
        if ($parent_id != '')
            $this->parent_id = TextToDB($parent_id);
    }

    public function SetCategoryString($category_search_str) {
        if ($category_search_str != '')
            $this->category_search_str = TextToDB($category_search_str);
    }

    public function GetCategoryParentId($cat_id = '') {
        if ($cat_id != '')
            $this->SetCategoryId($cat_id);

        $this->parent_id = GetInfoById("categories", "cat_id", $this->category_id, "parent_id");
    }

    public function GetCategoryInfo($cat_id) {
        return GetRowById("categories", "cat_id", $cat_id);
    }

    //Used to retrieve info categories for a resource
    public function GetCategoryFullInfo($cat_id = '') {
        if ($cat_id != '')
            $this->SetCategoryId($cat_id);

        $this->category_info = $this->GetCategoryInfo($this->category_id);

        $this->category_info['full_name'] = $this->GetCategoryFullName($this->category_id, $this->category_info['name'], $this->category_info['parent_id']);
        $this->category_info['hyphenated_name'] = ConvertSpacesToHyphens($this->category_info['name']);

        return $this->category_info;
    }

    public function GetCategoryFullName($cat_id, $cat_name, $parent_id) {

        if ($parent_id == '0') {
            return $cat_name;
        }

        $parent_info = $this->GetCategoryInfo($parent_id);
        $full_name = $parent_info['name'] . " > ";
        $full_name .= $cat_name;

        return $full_name;
    }

    public function GetCategorySearch($category_str = '') {
        if ($category_str != '')
            $this->SetCategoryString($category_str);
    }

    //used to allocate categories to resources
    public function GetCategorySearchFullInfo($category_str = '') {
        if ($category_str != '')
            $this->SetCategoryString($category_str);

        $categories = GetRows("categories", "active = 1 AND name like '%{$this->category_search_str}%' ORDER BY name ");
        $i = 0;
        foreach ($categories as $cat) {
            $cat_full_name = $this->GetCategoryFullName($cat['cat_id'], $cat['name'], $cat['parent_id']);
            $this->categories[$i] = $cat;
            $this->categories[$i]['full_name'] = $cat_full_name;
            $i++;
        }
        return $this->categories;
    }

    public function GetCategoryChildren($parent_id = '') {
        
    }

}
