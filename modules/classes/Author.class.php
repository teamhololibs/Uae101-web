<?php

class Author {

    private $author_id;
    private $author_info = array();
    private $author_search_str;

    public function SetAuthorId($auth_id) {
        if ($auth_id != '')
            $this->author_id = TextToDB($auth_id);
    }

    public function SetAuthorString($author_search_str) {
        if ($author_search_str != '')
            $this->author_search_str = TextToDB($author_search_str);
    }

    public function GetAuthorInfo($aut_id) {
        return $this->author_info = GetRowById("authors", "author_id", $aut_id);
    }

    public function GetAuthorFullInfo($auth_id = '') {
        if ($auth_id != '')
            $this->SetAuthorId($auth_id);

        $this->author_info = GetRowById("authors", "author_id", $this->author_id);

        return $this->author_info;
    }

    public function GetAuthorSearch($author_str = '') {
        if ($author_str != '')
            $this->SetAuthorString($author_str);
        
        $authors = GetColumnInfo("authors", "author_id", " name like '%{$this->author_search_str}%' ");
        return $authors;
    }

    public function GetAuthorSearchFullInfo($author_str = '') {
        if ($author_str != '')
            $this->SetAuthorString($author_str);

        $return_info = array();
        $authors = GetColumnInfo("authors", "author_id", " name like '%{$this->author_search_str}%' ORDER BY name ");
        foreach ($authors as $aut) {
            $auth_info = $this->GetAuthorFullInfo($aut);
            $return_info[] = array(
                'name' => $auth_info['name'],
                'author_id' => $aut
            );
        }
        return $return_info;
    }

    /**
     * 
     * @param array $fields to add
     * @return type
     */
    public function InsertAuthor($fields = array()) {

        if ($fields['name'] == '' && $fields['url'] == '' && $fields['github_author_id'] == '') {
            return;
        }

        $authorq = '';
        foreach ($fields as $k => $v) {
            $v = TextToDB(trim($v));
            $authorq .= " $k = '$v', ";
            $fields[$k] = $v;
        }
        $authorq = (trim($authorq, ' ,'));

        $author_id = GetInfoById("authors", "name", $fields['name'], "author_id");
        $git_id = GetInfoById("authors", "github_author_id", $fields['github_author_id'], "author_id", "github_author_id != ''");

        if ($author_id == null && $git_id == null) {
            $qs = "INSERT INTO authors SET $authorq ";
            ExecuteQuery($qs);
            $author_id = GetLastInsertId();
        } else {
            $qs = "UPDATE authors SET $authorq WHERE author_id =$author_id";
            ExecuteQuery($qs);
        }
        /*
         * case where authors with same names and different git id. no need for now
          elseif ($author_id != $git_id) {
          $author_id = $git_id;
          }
         */
        return $author_id;
    }

}
