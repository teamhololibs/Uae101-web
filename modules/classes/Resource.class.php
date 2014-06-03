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
        $rs = GetRows("resources", "active=1 ORDER BY github_api_last_checked ASC");
        $i = 0;
        foreach ($rs as $r) {
            if (!$ins->IsGithubUrl($r['url'])) {
                continue;
            }
            $result = $ins->UpdateGithubLibraries($r);
            if ($result !== FALSE) {
                $i++;
            }
            if ($i >= $github_api_limit) {
                break;
            }
        }
        return $i;
    }

    public function IsGithubUrl($url) {
        if (strpos($url, "github.com") !== false) {
            return true;
        } else {
            return false;
        }
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
        $auth_ins = new Author;
        $res_url = $this->GetGithubApiUrl($res['url']);

        //Initiate curl
        $ch = curl_init();
        //Disable SSL verification
        //curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        //Will return the response, if false it print the response
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, GIT_CURL_USERAGENT_HEADER);
        //Set the url
        curl_setopt($ch, CURLOPT_URL, $res_url);
        //Execute
        $result = curl_exec($ch);

        //list($header, $body) = explode("\r\n\r\n", $result, 2);
        $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($result, 0, $header_size);
        $result = substr($result, $header_size);
        $header_arr = explode("\r\n", $header);
        array_shift($header_arr);
        foreach ($header_arr as $h) {
            if (strpos($h, 'Status:') !== false) {
                $msg = explode(": ", $h);
                if ($msg[1] != '200 OK') {
                    Log::Write('lib', $res['resource_id'] . " - FAILED $error - $res_url");
                    return $msg[1];
                }
            }
        }
        //Debug::dump($header);
        //var_dump(preg_match("Status\:\ (.+)", $header));
        //var_dump(preg_match("200 OK", $header));

        $result = json_decode($result, true);

        $res_git['is_github'] = 1;
        $res_git['name'] = $result['name'];
        $res_git['description'] = $result['description'];
        $res_git['github_resource_id'] = $result['id'];
        $res_git['github_stargazers'] = $result['stargazers_count'];
        $res_git['github_updated_at'] = $result['updated_at'];
        $res_git['github_forks'] = $result['forks'];
        $res_git_author['name'] = $result['owner']['login'];
        $res_git_author['github_author_id'] = $result['owner']['id'];
        $res_git_author['url'] = $result['owner']['html_url'];

        $res_git['author_id'] = $auth_ins->InsertAuthor($res_git_author);

        $resq = '';
        foreach ($res_git as $k => $v) {
            $v = TextToDB(trim($v));
            $resq .= " $k = '$v', ";
        }
        $resq = (trim($resq, ' ,'));

        $qs_r = "UPDATE resources SET $resq, github_api_last_checked=NOW() WHERE resource_id = {$res['resource_id']} ";
        ExecuteQuery($qs_r);
        Log::Write('lib', $res['resource_id'] . " - updated");
    }

    public function SetResourceId($res_id) {
        if ($res_id != '')
            $this->resource_id = TextToDB($res_id);
    }

    public function SetResourceText($res_text) {
        if ($res_text != '')
            $this->resource_search_text = TextToDB($res_text);
    }

    public function GetResources($res_text = '', $cat_id = '', $res_id = '', $author_id = '') {
        if ($res_text != '')
            $this->SetResourceText($res_text);

        $query = array();
        $query_or = array();
        $query_or_s = '';
        // If searching 
        if ($this->resource_search_text != '') {
            $query_or[] = " r.resource_id IN "
                    . "(SELECT rc.res_id FROM res_cat rc WHERE rc.cat_id IN "
                    . "(SELECT c.cat_id FROM categories c WHERE c.active = 1 AND c.name like '%{$this->resource_search_text}%') "
                    . ") ";
            $query_or[] = " r.author_id IN (SELECT a.author_id FROM authors a WHERE a.name like '%{$this->resource_search_text}%' ) ";
            $query_or[] = " name LIKE '%{$this->resource_search_text}%' ";
            $query_or = trim(implode(" OR ", $query_or), "OR");
            $query_or_s = "($query_or) AND ";
        } else {
            // if listing category, author, or resource
            if ($cat_id != '') {
                $query[] = " r.resource_id IN (SELECT rc.res_id FROM res_cat rc WHERE rc.cat_id = $cat_id) ";
            } elseif ($res_id != '') {
                $query[] = " r.resource_id = $res_id ";
            } elseif ($author_id != '') {
                //$query = array();
                $query[] = " r.author_id= $author_id ";
            }
        }


        $query[] = " r.active = 1 ";
        $query[] = " r.is_approved = 1 ";
        $query_where = trim(implode(" AND ", $query), "AND");
        $this->resource_info = GetRows("resources r", "$query_or_s . $query_where", "resource_id, name, description, url, github_stargazers, author_id, user_id, REPLACE(name,' ','-') AS hyphenated_name ");
        for ($i = 0; $i < count($this->resource_info); $i++) {
            $res_cat = $this->GetResourceCategories($this->resource_info[$i]['resource_id']);
            $this->resource_info[$i]['author_info'] = GetRowById("authors", "author_id", $this->resource_info[$i]['author_id'], "name");
            $this->resource_info[$i]['author_info']['hyphenated_name'] = ConvertSpacesToHyphens($this->resource_info[$i]['author_info']['name']);
            $this->resource_info[$i]['author_info']['name'] = InsertSearchHighlight($this->resource_info[$i]['author_info']['name'], $this->resource_search_text);
            $this->resource_info[$i]['name'] = InsertSearchHighlight($this->resource_info[$i]['name'], $this->resource_search_text);
            foreach ($res_cat as $rs) {
                $cat = new Category();
                $cat_info = $cat->GetCategoryFullInfo($rs);
                $cat_info['full_name'] = InsertSearchHighlight($cat_info['full_name'], $this->resource_search_text);
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
        //if ($fields['name'] == '' || !isset($fields['name'])) {
        //return 'Name is missing';
        //}
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
        //if (GetCount("resources", "name = '{$fields['name']}'") > 0) {
        //return 'Library with this name already exists';
        //}

        $fields['is_github'] = 0;
        if ($this->IsGithubUrl($fields['url']) == true) {
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

    public function GetResourceJson() {
        $resources = GetRows("resources", $this->resource_id, "resource_id, name, description, url, github_stargazers, author_id, user_id");
        $this->resource_info = array();
        $cat = new Category();
        for ($i = 0; $i < count($resources); $i++) {
            $resources[$i]['author_name'] = GetInfoById("authors", "author_id", $resources[$i]['author_id'], 'name');
            $res_cat = $this->GetResourceCategories($resources[$i]['resource_id']);
            $rc_count = 0;
            $res = array();
            foreach ($res_cat as $rs) {
                $cat_info = $cat->GetCategoryFullInfo($rs);
                $res['res_cat'][$rc_count]['category_id'] = $cat_info['cat_id'];
                $res['res_cat'][$rc_count]['name'] = $cat_info['name'];
                $rc_count++;
            }
            $resources[$i]['categories'] = $res['res_cat'];
        }
        $this->resource_info['last_updated'] = "2014-05-31 14:04:01";
        $this->resource_info['data'] = $resources;
        //array_push($this->resource_info, $this->res_cat);
        return $this->resource_info;
    }

}
