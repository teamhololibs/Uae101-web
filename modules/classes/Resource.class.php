<?php

class Resource {

    private $resource_id;
    private $resource_info = array();
    private $res_cat = array();
    private $resource_search_text;
    private $name;
    private $desc;
    private $author_id;
    private $user_id;
    private $points;
    private $views;
    private $is_approved;

    public function SetResourceId($res_id) {
        if ($res_id != '')
            $this->resource_id = TextToDB($res_id);
    }

    public function SetResourceText($res_text) {
        if ($res_text != '')
            $this->resource_search_text = TextToDB($res_text);
    }

    public function GetResources($res_text = '') {
        if ($res_text != '')
            $this->SetResourceText($res_text);

        $this->resource_info = GetRows("resources", "name LIKE '%{$this->resource_search_text}%' AND active = 1 AND is_approved = 1");
        for ($i = 0; $i < count($this->resource_info); $i++) {
            $res_cat = $this->GetResourceCategories($this->resource_info[$i]['resource_id']);
            foreach ($res_cat as $rs) {
                $cat = new Category();
                $cat_info = $cat->GetCategoryFullInfo($rs);
                $this->resource_info[$i]['res_cat'][] = $cat_info;
            }
        }
        return $this->resource_info;
    }

    public function GetResourceCategories($res_id = '') {
        if ($res_id != '')
            $this->SetResourceId($res_id);

        $this->res_cat = GetColumnInfo("res_cat", "cat_id", "res_id = " . $this->resource_id);
        return $this->res_cat;
    }

    public function GetResourceInfo($res_id = '') {
        if ($res_id != '')
            $this->SetResourceId($res_id);

        $this->resource_info = GetRowById("resources", "resource_id", $this->resource_id);
        $this->GetResourceCategories();
        array_push($this->resource_info, $this->res_cat);

        return $this->resource_info;
    }

}
