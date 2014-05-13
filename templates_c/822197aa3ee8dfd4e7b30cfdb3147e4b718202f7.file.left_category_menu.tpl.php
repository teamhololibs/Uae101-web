<?php /* Smarty version Smarty-3.1.18, created on 2014-05-14 00:27:35
         compiled from "/var/www/libra.com/templates/common/left_category_menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2916888335370e77f942847-60494860%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '822197aa3ee8dfd4e7b30cfdb3147e4b718202f7' => 
    array (
      0 => '/var/www/libra.com/templates/common/left_category_menu.tpl',
      1 => 1400012837,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2916888335370e77f942847-60494860',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.18',
  'unifunc' => 'content_5370e77f97c7c5_98988266',
  'variables' => 
  array (
    'categories_tree' => 0,
    'cat' => 0,
    'child' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5370e77f97c7c5_98988266')) {function content_5370e77f97c7c5_98988266($_smarty_tpl) {?><div class="left_menu">
    <ul class="left_category_menu">
        <?php  $_smarty_tpl->tpl_vars['cat'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['cat']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['categories_tree']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['cat']->key => $_smarty_tpl->tpl_vars['cat']->value) {
$_smarty_tpl->tpl_vars['cat']->_loop = true;
?>
            <li id="">
                <?php if (count($_smarty_tpl->tpl_vars['cat']->value['children'])>0) {?>
                    <span alt='<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
' class="dropdown down_parent expand_parent_<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
">
                        <img src="/images/disclosure_down.png" alt=""/>
                    </span>
                    <span alt='<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
' class="dropdown up_parent minimize_parent_<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
">
                        <img src="/images/disclosure_up.png" alt=""/>
                    </span>
                <?php }?>
                <a class="" alt='<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
' href="/tag/<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
/<?php echo $_smarty_tpl->tpl_vars['cat']->value['hyphenated_name'];?>
">
                    <?php echo $_smarty_tpl->tpl_vars['cat']->value['name'];?>

                </a>
                <?php if (count($_smarty_tpl->tpl_vars['cat']->value['children'])>0) {?>
                    <ul class="children children_<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
">
                        <?php  $_smarty_tpl->tpl_vars['child'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['child']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['cat']->value['children']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['child']->key => $_smarty_tpl->tpl_vars['child']->value) {
$_smarty_tpl->tpl_vars['child']->_loop = true;
?>
                            <li>
                                <a class="" alt='<?php echo $_smarty_tpl->tpl_vars['cat']->value['cat_id'];?>
' href="/tag/<?php echo $_smarty_tpl->tpl_vars['child']->value['cat_id'];?>
/<?php echo $_smarty_tpl->tpl_vars['child']->value['hyphenated_name'];?>
">
                                    <?php echo $_smarty_tpl->tpl_vars['child']->value['name'];?>
 
                                </a>
                            </li>
                        <?php } ?>
                    </ul>
                <?php }?>
            </li>
        <?php } ?>
    </ul>
</div><?php }} ?>
