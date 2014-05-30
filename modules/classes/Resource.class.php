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

    static public function UpdateAllGithubLibraries() {
        ini_set('max_execution_time', 0);
        $ins = new static();
        $cfg = new Config;
        $github_api_limit = $cfg->GetConfig('GITHUB_API_CALL_LIMIT');
        $rs = GetRows("resources", "is_github=1 AND active=1 AND resource_id=46 ORDER BY github_updated ASC LIMIT $github_api_limit");
        $i = 1;
        foreach ($rs as $r) {
            $result = $ins->UpdateGithubLibraries($r);
            if ($result !== FALSE){
                $i++;
            }
        }
        return $i;
    }

    public function GetGithubApiUrl($res_url) {
        $cfg = new Config;
        $github_url = $cfg->GetConfig('GITHUB_API_URL');
        $res_url = substr($res_url, 19);
        $res_url = $github_url . $res_url;
        return $res_url;
    }
    /**
     * 
     * @param array $resources
     */
    public function UpdateGithubLibraries($res) {
        $res_url = $this->GetGithubApiUrl($res['url']);

        //Initiate curl
        $ch = curl_init();
        //Disable SSL verification
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        //Will return the response, if false it print the response
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, GIT_CURL_USERAGENT_HEADER);
        //Set the url
        curl_setopt($ch, CURLOPT_URL, $res_url);
        //Execute
        $result = curl_exec($ch);

        $result = json_decode($result, true);
        if (count($result) == 0 || $result == null) {
            return false;
        }

        $res_git['github_resource_id'] = $result['id'];
        $res_git['github_stargazers'] = $result['stargazers_count'];
        $res_git['github_forks'] = $result['forks'];
        $res_git['github_forks'] = $result['forks'];
        $res_git_author['github_author_id'] = $result['owner']['id'];
        $res_git_author['url'] = $result['owner']['html_url'];

        $resq = '';
        foreach ($res_git as $k => $v) {
            $v = TextToDB(trim($v));
            $resq .= " $k = '$v', ";
        }
        $resq = (trim($resq, ' ,'));

        $authorq = '';
        foreach ($res_git_author as $k => $v) {
            $v = TextToDB(trim($v));
            $authorq .= " $k = '$v', ";
        }
        $authorq = (trim($authorq, ' ,'));

        $qs_r = "UPDATE resources SET $resq, github_updated=NOW() WHERE resource_id = {$res['resource_id']} ";
        $qs_a = "UPDATE authors SET $authorq WHERE author_id = {$res['author_id']} ";
        ExecuteQuery($qs_r);
        ExecuteQuery($qs_a);
    }

    public function SetResourceId($res_id) {
        if ($res_id != '')
            $this->resource_id = TextToDB($res_id);
    }

    public function SetResourceText($res_text) {
        if ($res_text != '')
            $this->resource_search_text = TextToDB($res_text);
    }

    public function GetResources($res_text = '', $cat_id = '', $res_id = '', $author_id = '', $limit_search_to_cats = 'true') {
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
        $this->resource_info = GetRows("resources r", $query_where, "resource_id, name, description, url, github_stargazers, author_id, user_id, REPLACE(name,' ','-') AS hyphenated_name ");
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

        $this->resource_info = GetRowById("resources", "resource_id", $this->resource_id, "resource_id, name, description, url, github_stargazers, author_id, user_id, REPLACE(name,' ','-') AS hyphenated_name ");
        $res_cat = $this->GetResourceCategories($this->resource_id);
        foreach ($res_cat as $rs) {
            $cat = new Category();
            $cat_info = $cat->GetCategoryFullInfo($rs);
            $this->resource_info['res_cat'][] = $cat_info;
        }
        //array_push($this->resource_info, $this->res_cat);
        return $this->resource_info;
    }

    /**
     * $fields = array('name', 'url', 'description', 'is_approved', 'author_id')
     * @param type $fields
     * @return boolean|string
     */
    public function InsertResource($fields) {
        if ($fields['name'] == '' || !isset($fields['name'])) {
            return 'Name is missing';
        }
        if ($fields['url'] == '' || !isset($fields['url'])) {
            return 'URL is missing';
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

        $fields['is_github'] = 0;
        if (strpos($fields['url'], "github.com") !== false) {
            $fields['url'] = "https://" . $fields['url'];
            $fields['is_github'] = 1;
        } else {
            $fields['url'] = "http://" . $fields['url'];
        }
        foreach ($fields as $k => $v) {
            $v = TextToDB(trim($v));
            $set_str .= " $k = '$v', ";
        }
        $set_str = (trim($set_str, ' ,'));
        $qs = "INSERT INTO resources SET $set_str ";
        //$qs = "INSERT INTO resources SET name='{$fields['name']}', url='{$fields['url']}', is_approved='{$fields['is_approved']}', description='{$fields['description']}', is_github='{$fields['is_github']}', author_id='{$fields['author_id']}', rating='{$fields['rating']}' ";
        ExecuteQuery($qs);
        return GetLastInsertId();
        //return true;
    }

}
