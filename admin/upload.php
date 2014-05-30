<?php
require_once '../admin.common.prepend.php';
CheckPermissions("upload", 'super');
ini_set('max_execution_time', 0);

if ($_POST['upload']) {
//Debug::dump($_FILES["file"]);
    if ($_FILES["file"]["error"] > 0) {
        echo "Error: " . $_FILES["file"]["error"] . "<br>";
    } else {
        move_uploaded_file($_FILES["file"]["tmp_name"], "upload_resources.csv");
        $handle = fopen("upload_resources.csv", "r");
        if ($handle) {
            $cfg = new Config;
            $cat_ins = new Category;
            $res_ins = new Resource;
            $auth_ins = new Author;
            ExecuteQuery("DELETE FROM resources");
            ExecuteQuery("DELETE FROM res_cat");
            ExecuteQuery("DELETE FROM categories");
            ExecuteQuery("ALTER TABLE resources AUTO_INCREMENT = 10");
            ExecuteQuery("ALTER TABLE res_cat AUTO_INCREMENT = 10");
            ExecuteQuery("ALTER TABLE categories AUTO_INCREMENT = 10");
            $i = 1;
            while ($csv_line = fgetcsv($handle, 100024)) {
                if ($csv_line[0] == '' || $csv_line[0] == 'Name') {
                    continue;
                }
                $i++;
                $name = TextToDB(trim($csv_line[0]));
                $desc = TextToDB(trim($csv_line[1]));
                $desc = substr($desc, 0, $cfg->GetConfig("RESOURCE_DESCRIPTION_MAXLENGTH"));
                $author = TextToDB(trim($csv_line[2]));
                $url = TextToDB(trim($csv_line[3]));
                $url = trim($url, " /");
                $rating = TextToDB(trim($csv_line[4]));
                $cat = TextToDB(trim($csv_line[5]));
                $parent = TextToDB(trim($csv_line[6]));

                $cat = explode("/", $cat);
                $cat = $cat[0];

                $author_id = $auth_ins->InsertAuthor($author);
                $cat_id = $cat_ins->InsertCategory($cat, $parent);

                $fields['name'] = $name;
                $fields['url'] = $url;
                $fields['description'] = $desc;
                $fields['is_approved'] = 1;
                $fields['author_id'] = $author_id;
                $fields['rating'] = $author_id;
                $r_id = $res_ins->InsertResource($fields);

                $qs_rc = "INSERT INTO res_cat SET res_id='$r_id', cat_id='$cat_id' ";
                ExecuteQuery($qs_rc);
            }
            SetConfirmationMessage("$i Libraries added!");
        }
    }
} else {
    $show_form = 1;
}

PreparePage(array(
    'title' => 'Upload', // Required
    'page_heading' => 'Upload'
));

if ($show_form == 1) {
    ?>
    <form method="post" action="" enctype="multipart/form-data">
        <label for="file">Filename:</label>
        <input type="file" name="file" required id="file"><br><br><br>
        <input class="ui-button" type = "submit" name = "upload" value = "Upload csv"/>
    </form>
    <?
}
footer();
?>

