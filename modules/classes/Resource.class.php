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

    public function GetResources($res_text = '', $cat_id = '', $emirate_id = '') {
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

            $query_or[] = " name LIKE '%{$this->resource_search_text}%' ";
            $query_or = trim(implode(" OR ", $query_or), "OR");
            $query_or_s = "($query_or) AND ";
        } else {
            // if listing category, author, or resource
            if ($cat_id != '') {
                $query[] = " r.resource_id IN (SELECT rc.res_id FROM res_cat rc WHERE rc.cat_id = $cat_id) ";
            }
            if ($emirate_id != '') {
                $query[] = " r.emirate_id = $emirate_id ";
            }
        }

        $query[] = " r.active = 1 ";
        $query[] = " r.is_approved = 1 ";
        $query_where = trim(implode(" AND ", $query), "AND");

        // Get res_id
        $res_ids = GetColumnInfo("resources r", "resource_id", $query_or_s . $query_where);

        if (count($res_ids) < 1)
            return null;

        $res_ids_q = trim(implode(", ", $res_ids), ", ");

        // emirates that has res_ids
        $emirates = GetRowsAsAssocArray("
            SELECT DISTINCT(e.emirate_id) as emirate_id, e.name, e.shortform FROM emirates e, resources r
            WHERE e.emirate_id IN (SELECT emirate_id FROM resources WHERE resource_id IN ($res_ids_q) )
            ORDER BY e.name
                ");
        for ($i = 0; $i < count($emirates); $i++) {
            $emirates[$i]['res'] = $this->GetResourceInfoByIds($res_ids, $emirates[$i]['emirate_id']);
        }

        return $emirates;
    }

    public function GetResourceInfoByIds($res_ids = array(), $emirate_id = '') {

        if (count($res_ids) < 1)
            return null;

        $res_ids_q = trim(implode(", ", $res_ids), ", ");

        $res = GetRowsAsAssocArray("
            SELECT r.resource_id, r.name as res_name, REPLACE( r.name,  ' ',  '-' ) AS hyphenated_name, r.emirate_id, r.url, c.name
            FROM resources r 
            LEFT JOIN res_cat rc ON rc.res_id = r.resource_id
            LEFT JOIN categories c ON c.cat_id = rc.cat_id
            WHERE r.resource_id IN ($res_ids_q) AND r.emirate_id = $emirate_id
            ORDER BY c.name, r.name
            ");

        $res_used = array();
        $res_info = array();
        for ($i = 0; $i < count($res); $i++) {
            if (array_search($res[$i]['resource_id'], $res_used) !== false) {
                continue;
            }
            $res_used[] = $res[$i]['resource_id'];

            $res_info[$i] = $res[$i];
            $res_info[$i]['res_name'] = InsertSearchHighlight($res[$i]['res_name'], $this->resource_search_text);

            $res_cat = $this->GetResourceCategories($res[$i]['resource_id']);
            foreach ($res_cat as $rs) {
                $cat = new Category();
                $cat_info = $cat->GetCategoryInfo($rs);
                $cat_info['full_name'] = InsertSearchHighlight($cat_info['name'], $this->resource_search_text);
                $res_info[$i]['res_cat'][] = $cat_info;
            }
        }
        return $res_info;
    }

    public function GetResourceCategories($res_id = '') {
        if ($res_id != '')
            $this->SetResourceId($res_id);

        $this->res_cat = GetColumnInfo("res_cat", "cat_id", "res_id = " . $this->resource_id);
        return $this->res_cat;
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
            return 'Resource with this URL already exists';
        }
        //if (GetCount("resources", "name = '{$fields['name']}'") > 0) {
        //return 'Library with this name already exists';
        //}

        unset($fields['stuff']);
        unset($fields['submit']);
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
        $res_updated_q = '';
        $no_change = false;
        if (isset($_GET['updated']) && $_GET['updated'] != '') {
            $updated = trim(TextToDB($_GET['updated']));

            $cats_updated = GetColumnInfo("categories", "cat_id", "updated >= '$updated'");
            if (count($cats_updated) > 0) {
                $cats_updated_q = implode(", ", $cats_updated);
                $cats_updated_q = "OR cat_id IN ($cats_updated_q) ";
            }

            $res_cat_updated = GetColumnInfo("res_cat", "res_id", "updated >= '$updated' $cats_updated_q ");
            if (count($res_cat_updated) > 0) {
                $res_cat_updated_q = implode(", ", $res_cat_updated);
                $res_cat_updated_q = "OR resource_id IN ($res_cat_updated_q) ";
            }

            $res_updated = GetColumnInfo("resources", "resource_id", "updated >= '$updated' $res_cat_updated_q ");
            if (count($res_updated) > 0) {
                $res_updated_q = implode(", ", $res_updated);
                $res_updated_q = " resource_id IN ($res_updated_q) ";
            } else {
                $no_change = true;
            }
        }
        if ($no_change == false) {
            $resources = GetRows("resources", $res_updated_q);
            $this->resource_info = array();
            $json = array();
            $cat = new Category();
            for ($i = 0; $i < count($resources); $i++) {
                $res_data = array();
                $res_data['resourceId'] = intval($resources[$i]['resource_id']);
                $res_data['name'] = $resources[$i]['name'];
                $res_data['description'] = $resources[$i]['description'];
                $res_data['active'] = intval($resources[$i]['active']);
                $res_data['url'] = $resources[$i]['url'];
                $res_data['userId'] = intval($resources[$i]['user_id']);
                $res_cat = $this->GetResourceCategories($resources[$i]['resource_id']);
                $cat_info = $cat->GetCategoryFullInfo($res_cat[0]);
                $res_data['categoryId'] = intval($cat_info['cat_id']);
                $res_data['categoryName'] = $cat_info['name'];

                /*
                 * If in future we need to have multiple categories per library

                  $rc_count = 0;
                  $res = array();
                  foreach ($res_cat as $rs) {
                  $cat_info = $cat->GetCategoryFullInfo($rs);
                  $res[$rc_count]['categoryId'] = $cat_info['cat_id'];
                  $res[$rc_count]['categoryName'] = $cat_info['name'];
                  $rc_count++;
                  }
                  $res_data['categories'] = $res;
                 */

                $json[] = $res_data;
            }
        }

        $this->resource_info['last_updated'] = $this->LastUpdated();
        $this->resource_info['count'] = count($json);
        usort($json, array("Resource", "CompareCategories"));
        $this->resource_info['data'] = $json;

        return $this->resource_info;
    }

    static function CompareCategories($a, $b) {
        return strcmp($a["categoryName"], $b["categoryName"]);
    }

    public function LastUpdated() {
        $updated = GetColumnInfoByQuery("SELECT NOW()");
        return $updated[0];
    }

    /*
      public function GetResourceInfoById($res_id) {
      $res_cat = $this->GetResourceCategories($res_id);
      $res_info['name'] = InsertSearchHighlight($res_info['name'], $this->resource_search_text);

      foreach ($res_cat as $rs) {
      $cat = new Category();
      $cat_info = $cat->GetCategoryInfo($rs);
      $cat_info['full_name'] = InsertSearchHighlight($cat_info['name'], $this->resource_search_text);
      $res_info['res_cat'][] = $cat_info;
      }

      return $res_info;
      }

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
      if ($res['name'] == '')
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
     */
}
