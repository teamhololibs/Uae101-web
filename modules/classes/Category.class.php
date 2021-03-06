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

    public function SetCategoryId($cat_id) {
        if ($cat_id != '')
            $this->category_id = TextToDB($cat_id);
    }

    public function SetCategoryString($category_search_str) {
        if ($category_search_str != '')
            $this->category_search_str = TextToDB($category_search_str);
    }

    //Used to retrieve info categories for a resource
    public function GetCategoryInfo($cat_id = '') {
        if ($cat_id != '')
            $this->SetCategoryId($cat_id);

        $this->category_info = GetRowById("categories", "cat_id", $this->category_id);
        $this->category_info['hyphenated_name'] = ConvertSpacesToHyphens($this->category_info['name']);

        return $this->category_info;
    }

    //used to allocate categories to resources
    public function GetCategorySearch($category_str = '') {
        if ($category_str != '')
            $this->SetCategoryString($category_str);

        $categories = GetRows("categories", "active = 1 AND name LIKE '%{$this->category_search_str}%' ORDER BY name", "*, REPLACE(name,' ','-') AS hyphenated_name ");
        return $categories;
    }

    public function InsertCategory($category_name = '', $parent_name_or_id = '') {
        if ($category_name == '' && $parent_name_or_id == '') {
            return;
        }

        $category_name = TextToDB($category_name);
        $parent_name_or_id = TextToDB($parent_name_or_id);

        $cat_id = GetInfoById("categories", "name", "$category_name", "cat_id");
        if ($cat_id == null) {
            $p_id1 = GetInfoById("categories", "name", "$parent_name_or_id", "cat_id");
            $p_id2 = GetInfoById("categories", "cat_id", "$parent_name_or_id", "cat_id", "cat_id != ''");
            if ($p_id1 == null && $p_id2 == null && $parent_name_or_id != '') {
                $parent_id = $this->InsertCategory($parent_name_or_id);
            }

            if ($p_id1 == null && $p_id2 != null) {
                $parent_id = $p_id2;
            } elseif ($p_id1 != null && $p_id2 == null) {
                $parent_id = $p_id1;
            }

            $qs = "INSERT INTO categories SET name='$category_name', parent_id='$parent_id' ";
            ExecuteQuery($qs);
            $cat_id = GetLastInsertId();
        }
        return $cat_id;
    }
    
     /*
     * Unused code
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

      $categories = GetColumnInfo("categories", "cat_id", "active = 1 AND name like '%{$this->category_search_str}%' ");
      return $categories;
      }
      static public function GetCategoryFullTree($cat_name = '') {

      if ($category_str != '')
      $this->SetCategoryString($category_str);
      $cat_name = trim(TextToDB($cat_name));
      if (CATEGORY_TREE_SESSION_FLAG === true && $cat_name == '') {
      if (time() - $_SESSION['category_last_retrieved'] < CATEGORY_TREE_SESSION_TIMEOUT) {
      self::$full_categories_tree = $_SESSION['FULL_CATEGORIES_TREE'];
      return $_SESSION['FULL_CATEGORIES_TREE'];
      }
      }
      $parents = GetRows("categories", "active = 1 AND name LIKE '%$cat_name%' ORDER BY name", "*, REPLACE(name,' ','-') AS hyphenated_name ");
      self::$full_categories_tree = $parents;
      $_SESSION['FULL_CATEGORIES_TREE'] = self::$full_categories_tree;
      return self::$full_categories_tree;
      }
     */

}
