<?php

class Category {

    private $category_id;
    private $category_info = array();
    private $category_full_name;
    private $category_search_str;
    private $parent_id;
    private $parent_info = array();
    private $categories = array();

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

    public function GetCategoryFullName($cat_id = '') {
        if ($cat_id != '')
            $this->SetCategoryId($cat_id);

        $this->GetCategoryParentId();

        $this->category_full_name = '';
        
        if ($this->parent_id != '0') {
            $this->parent_info = $this->GetCategoryInfo($this->parent_id);
            $this->category_full_name = $this->parent_info['name'] . " > ";
        }

        $this->category_info = $this->GetCategoryInfo($this->category_id);
        $this->category_full_name .= $this->category_info['name'];

        return $this->category_full_name;
    }

    public function GetCategorySearch($category_str = '') {
        if ($category_str != '')
            $this->SetCategoryString($category_str);
    }

    public function GetCategorySearchFullInfo($category_str = '') {
        if ($category_str != '')
            $this->SetCategoryString($category_str);

        $categories = GetColumnInfo("categories", "cat_id", "active = 1 AND name like '%{$this->category_search_str}%' ORDER BY name ");
        foreach ($categories as $cat) {
            $cat_full_name = $this->GetCategoryFullName($cat);
            $this->categories[] = array(
                'full_name' => $cat_full_name,
                'category_id' => $cat
            );
        }
        return $this->categories;
    }

    public function GetCategoryFullTree() {
        
    }

    public function GetCategoryChildren($parent_id = '') {
        
    }

}
