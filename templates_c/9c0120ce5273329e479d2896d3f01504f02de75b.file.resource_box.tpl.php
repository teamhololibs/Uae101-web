<?php /* Smarty version Smarty-3.1.18, created on 2014-05-14 00:28:17
         compiled from "/var/www/libra.com/templates/resource_box.tpl" */ ?>
<?php /*%%SmartyHeaderCode:113498259953725adbceda06-71668634%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9c0120ce5273329e479d2896d3f01504f02de75b' => 
    array (
      0 => '/var/www/libra.com/templates/resource_box.tpl',
      1 => 1400012894,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '113498259953725adbceda06-71668634',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.18',
  'unifunc' => 'content_53725adbd2d3c4_35684960',
  'variables' => 
  array (
    'resources' => 0,
    'res' => 0,
    'res_cat' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_53725adbd2d3c4_35684960')) {function content_53725adbd2d3c4_35684960($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['res'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['res']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['resources']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['res']->key => $_smarty_tpl->tpl_vars['res']->value) {
$_smarty_tpl->tpl_vars['res']->_loop = true;
?>
    <div class='resource_box'>
        <div class="upvote_container">
            <table width="100%">
                <tr>
                    <td align="center">
                        <img class='upvote' src='images/upvote.png'/>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <span class='resource_points'><?php echo $_smarty_tpl->tpl_vars['res']->value['points'];?>
</span>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <img class='resource_star' src='images/star.jpg'/>
                    </td>
                </tr>
            </table>
        </div>
        <a class='expand_resource resource_name' href="#" ><?php echo $_smarty_tpl->tpl_vars['res']->value['name'];?>
</a>
        <p class='resource_tags_p'>
            <?php  $_smarty_tpl->tpl_vars['res_cat'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['res_cat']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['res']->value['res_cat']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['res_cat']->key => $_smarty_tpl->tpl_vars['res_cat']->value) {
$_smarty_tpl->tpl_vars['res_cat']->_loop = true;
?>
                <a class='' href="/tag/<?php echo $_smarty_tpl->tpl_vars['res_cat']->value['cat_id'];?>
/<?php echo $_smarty_tpl->tpl_vars['res_cat']->value['hyphenated_name'];?>
" alt="<?php echo $_smarty_tpl->tpl_vars['res_cat']->value['cat_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['res_cat']->value['full_name'];?>
 </a><br/>
            <?php } ?>
        </p>
        <p class='resource_desc'>
            <?php echo $_smarty_tpl->tpl_vars['res']->value['description'];?>

            <a class='expand_resource readmore' href="#" >...</a>
        </p>
        <p class='resource_views_points'>
            <span class='resource_views'>Views: <?php echo $_smarty_tpl->tpl_vars['res']->value['views'];?>
</span>
        </p>
    </div>
<?php } ?><?php }} ?>
