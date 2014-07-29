<ul class="left_category_menu">
    <li class="left_cat_header">
        Categories
    </li>
    {foreach from=$links item=link}
        <li>
            <a class="{$link.selected}" alt='{$link.cat_id}' href="/category-{$link.cat_id}/emirate-{$emirate_link}">
                {$link.name}
            </a>
        </li>
    {/foreach}
</ul>