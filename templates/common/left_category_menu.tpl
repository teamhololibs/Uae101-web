<ul class="left_category_menu">
    {foreach from=$categories_tree item=cat}
        <li id="">
            {if count($cat.children) > 0}
                <span alt='{$cat.cat_id}' class="dropdown down_parent expand_parent_{$cat.cat_id}">
                    <img src="{$PIC_PATH}/arrow_right.png" alt=""/>
                </span>
                <span alt='{$cat.cat_id}' class="dropdown up_parent minimize_parent_{$cat.cat_id}">
                    <img src="{$PIC_PATH}/arrow_down.png" alt=""/>
                </span>
            {/if}
            <a class="" alt='{$cat.cat_id}' href="/tag/{$cat.cat_id}/{$cat.hyphenated_name}">
                {$cat.name}
            </a>
            {if count($cat.children) > 0}
                <ul class="children children_{$cat.cat_id}">
                    {foreach from=$cat.children item=child}
                        <li>
                            <a class="" alt='{$cat.cat_id}' href="/tag/{$child.cat_id}/{$child.hyphenated_name}">
                                {$child.name} 
                            </a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </li>
    {/foreach}
</ul>
<!--div style='clear: both'></div-->