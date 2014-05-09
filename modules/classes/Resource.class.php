<?php

class Resource {

    private $resource_id;
    private $resource_info = array();
    private $res_cat = array();
    private $name;
    private $desc;
    private $author_id;
    private $user_id;
    private $points;
    private $views;
    private $is_approved;

    public function SetCategoryId($res_id) {
        if ($res_id != '')
            $this->resource_id = TextToDB($res_id);
    }

    public function GetResourceCategories($res_id = '') {
        if ($res_id != '')
            $this->SetCategoryId($res_id);

        $this->res_cat = GetColumnInfo("res_cat", "cat_id", "res_id = " . $this->resource_id);
        return $this->res_cat;
    }

    public function GetResourceInfo($res_id = '') {
        if ($res_id != '')
            $this->SetCategoryId($res_id);
    
        $this->resource_info = GetRowById("resources", "resource_id", $this->resource_id);
        $this->GetResourceCategories();
        array_push($this->resource_info, $this->res_cat);
        
        return $this->resource_info;
    }

}
