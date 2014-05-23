<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <meta http-equiv="content-language" content="en" />
        <meta name="description" content="" />
        <meta name="keywords" content="" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.10.2.custom.css"/>
        <!--link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/base/jquery-ui.css"/-->
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <link rel='stylesheet' type='text/css' href='//fonts.googleapis.com/css?family=Quintessential|Arimo|Asap|Fauna+One' />
        <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script type="text/javascript">
            if (typeof jQuery == 'undefined') {
                document.write("<script type='text/javascript' src='js/jquery-1.9.1.js'><\/script>");
                //console.log('Server copy of jQuery Loaded');
            }
        </script>
        <!--script type="text/javascript" src="js/jquery-ui-1.10.2.custom.js"></script-->
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>
        <!--script type='text/javascript' src="//tinymce.cachefly.net/4.0/tinymce.min.js"></script-->
        <script type='text/javascript' src="js/tinymce/tinymce.min.js"></script>
<!--        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>-->
        <script type="text/javascript">
            if (typeof (tinyMCE) == "undefined") {
                document.write("<script type='text/javascript' src='js/tinymce/tinymce.min.js'><\/script>");
            }
//            is_tinyMCE_active = false;
//            if (typeof (tinyMCE) != "undefined") {
//                if (tinyMCE.activeEditor == null || tinyMCE.activeEditor.isHidden() != false) {
//                    is_tinyMCE_active = true;
//                } 
//            }
        </script>
        <script type="text/javascript" src="js/js.functions.js"></script>
        <!--[if IE]>
        <style type="text/css">
            .data_top_options span.selected{
                border: 1px solid #323232;
            }
        </style>
        <![endif]-->
        <title><?= $page_info['title'] ?></title>
    </head>
    <body>
        <div class="wrapper">
            <div class="heading_bar">
                <div class="site_name">
                    <a href='/'><?= $page_info['site_name'] ?></a>
                </div>
                <div class="logout_area">
                    <span class="logout">
                        <a href="logout.php?from=<?= $page_info['current_url'] ?>&username=<?= $page_info['admin_username'] ?>">Logout</a>
                    </span>
                    <span class="admin_name">
                        <?= $page_info['admin_name'] ?>
                    </span>
                </div>
                <div class="menu">
                    <?= $page_info['menu'] ?>
                </div>
                <div style="clear:both"></div>
            </div>
            <div class="page_heading">
                <?= $page_info['page_type'] . $page_info['page_action'] . $page_info['page_extra_detail'] ?>
                <? if ($page_info['create_button'] != '') { ?>
                    <div class="create_button">
                        <?= $page_info['create_button'] ?>
                    </div>
                <? } ?>
                <div class="page_heading_text">
                    <?= $page_info['page_heading'] ?>
                    <span class="loading_gif">
                        <img style="height: 10px; width:50px" src="images/loading1.gif"/>
                    </span>
                </div>
            </div>
            <div class="main_content">
                <div class="confirmation_message <?= $_SESSION['confirmation_message']['type'] ?>" style="<?= !isset($_SESSION['confirmation_message']['message']) ? 'display: none' : ''; ?>">
                    <?= $_SESSION['confirmation_message']['message'] ?>
                </div>
                <? ClearConfirmationMessage(); ?>

