<?php /* Smarty version Smarty-3.1.18, created on 2014-05-13 21:48:43
         compiled from "/var/www/libra.com/templates/main.tpl" */ ?>
<?php /*%%SmartyHeaderCode:112398431053725afb488af6-14408409%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2d1dc13d881a16a32a71fb494356cd1fd46695fa' => 
    array (
      0 => '/var/www/libra.com/templates/main.tpl',
      1 => 1400000514,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '112398431053725afb488af6-14408409',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'META_NAME_DESCRIPTION' => 0,
    'META_NAME_KEYWORDS' => 0,
    'META_TITLE' => 0,
    'HEADER_VARS' => 0,
    'LEFT_MENU' => 0,
    'MAIN_CONTENT' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.18',
  'unifunc' => 'content_53725afb512778_30996980',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_53725afb512778_30996980')) {function content_53725afb512778_30996980($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <meta http-equiv="content-language" content="en" />
        <meta name="description" content="<?php echo $_smarty_tpl->tpl_vars['META_NAME_DESCRIPTION']->value;?>
" />
        <meta name="keywords" content="<?php echo $_smarty_tpl->tpl_vars['META_NAME_KEYWORDS']->value;?>
" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <link rel='stylesheet' type='text/css' href='//fonts.googleapis.com/css?family=Quintessential|Arimo|Asap|Fauna+One' />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script src="js/jquery.ellipsis.min.js"></script>
        <script src="js/jquery.dotdotdot.min.js"></script>
        <script type="text/javascript">
            if (typeof jQuery == 'undefined') {
                document.write("<script type='text/javascript' src='js/jquery-1.9.1.js'><\/script>");
                //console.log('Server copy of jQuery Loaded');
            }
        </script>
        <script type="text/javascript" src="js/js.functions.js"></script>
        <title><?php echo $_smarty_tpl->tpl_vars['META_TITLE']->value;?>
</title>
    </head>
    <body>
        <div class="wrapper">
            <?php echo $_smarty_tpl->getSubTemplate ("common/header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array('var_name'=>$_smarty_tpl->tpl_vars['HEADER_VARS']->value), 0);?>

            <?php echo $_smarty_tpl->tpl_vars['LEFT_MENU']->value;?>

            <div class='content_holder'>
                <?php echo $_smarty_tpl->tpl_vars['MAIN_CONTENT']->value;?>

            </div>
            <?php echo $_smarty_tpl->getSubTemplate ("common/footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

        </div>
    </body>
</html><?php }} ?>
