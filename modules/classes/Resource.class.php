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

    public function GetResources($res_text = '', $cat_id = '', $res_id = '', $author_id='', $limit_search_to_cats = 'true') {
        if ($res_text != '')
            $this->SetResourceText($res_text);

        $query = array();
        if ($this->resource_search_text != '') {
            $query[] = " name LIKE '%{$this->resource_search_text}%' ";
        }
        if ($cat_id != '' && $limit_search_to_cats != 'false') {
            $query[] = " r.resource_id IN (SELECT rc.res_id FROM res_cat rc WHERE rc.cat_id = $cat_id) ";
        }
        if ($res_id != '' && $res_text == '') {
            $query[] = " r.resource_id = $res_id ";
        }

        $query[] = " r.active = 1 ";
        $query[] = " r.is_approved = 1 ";
        $query_where = trim(implode(" AND ", $query), "AND");
        $this->resource_info = GetRows("resources r", $query_where, "resource_id, name, description, url, points, views, author_id, user_id, REPLACE(name,' ','-') AS hyphenated_name ");
        for ($i = 0; $i < count($this->resource_info); $i++) {
            $res_cat = $this->GetResourceCategories($this->resource_info[$i]['resource_id']);
            $this->resource_info[$i]['author_info'] = GetRowById("authors", "author_id", $this->resource_info[$i]['author_id'], "name, REPLACE(name,' ','-') ");
            $this->resource_info[$i]['author_info']['hyphenated_name'] = ConvertSpacesToHyphens($this->resource_info[$i]['author_info']['name']);
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

        $this->resource_info = GetRowById("resources", "resource_id", $this->resource_id, "resource_id, name, description, url, points, views, author_id, user_id, REPLACE(name,' ','-') AS hyphenated_name ");
        $res_cat = $this->GetResourceCategories($this->resource_id);
        foreach ($res_cat as $rs) {
            $cat = new Category();
            $cat_info = $cat->GetCategoryFullInfo($rs);
            $this->resource_info['res_cat'][] = $cat_info;
        }
        //array_push($this->resource_info, $this->res_cat);
        return $this->resource_info;
    }

    public function SubmitNewResource($fields) {
        if ($fields['name'] == '' || !isset($fields['name'])) {
            return 'Name is missing';
        }
        if ($fields['url'] == '' || !isset($fields['url'])) {
            return 'URL is missing';
        }

        foreach ($fields as $k => $v) {
            $v = TextToDB(trim($v));
            $set_str .= " $k = '$v', ";
        }

        $fields['url'] = trim($fields['url'], '/ ');
        if (strpos($fields['url'], "http://") === 0) {
            $fields['url'] = substr($fields['url'], 7);
        }
        if (strpos($fields['url'], "https://") === 0) {
            $fields['url'] = substr($fields['url'], 8);
        }
        if (GetCount("resources", "url LIKE '%{$fields['url']}%'") > 0) {
            return 'Library with this URL already exists';
        }
        if (GetCount("resources", "name = '{$fields['name']}'") > 0) {
            return 'Library with this name already exists';
        }
        
        $qs = "INSERT INTO resources SET name='{$fields['name']}', url='{$fields['url']}', is_approved=0, description='{$fields['description']}'";
        ExecuteQuery($qs);
        return true;
        //$url = ltrim($fields['url'], 'https://');
    }

}
