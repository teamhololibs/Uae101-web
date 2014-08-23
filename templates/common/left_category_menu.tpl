<ul class="left_category_menu left_menu_click_capture">
    <li class="left_cat_header left_menu_click_capture">
        Categories
    </li>
    <ul class="categories_dropdown left_menu_click_capture">
        {foreach from=$links item=link}
            <li>
                <a class="{$link.selected} left_menu_click_capture" alt='{$link.cat_id}' href="/category-{$link.cat_id}/emirate-{$emirate_link}">
                    {$link.name}
                </a>
            </li>
        {/foreach}
    </ul>
</ul>