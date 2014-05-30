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
     */
    public function InsertAuthor($name = '', $url = '', $github_author_id = '', $is_github = '') {
        if ($name == '' && $github_author_id == '') {
            return;
        }

        $name = TextToDB($name);
        $url = TextToDB($url);
        $github_author_id = TextToDB($github_author_id);
        $is_github = TextToDB($is_github);

        $author_id = GetInfoById("authors", "name", "$name", "author_id");
        $git_id = GetInfoById("authors", "github_author_id", "$github_author_id", "author_id", "github_author_id != ''");
        if ($author_id == null && $git_id == null) {
            $qs = "INSERT INTO authors SET name='$name', url='$url', github_author_id='$github_author_id', is_github='$is_github' ";
            ExecuteQuery($qs);
            $author_id = GetLastInsertId();
        }
        return $author_id;
    }

}
