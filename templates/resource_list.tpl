{foreach from=$info item=cat}
    <div id='' class='category_box'>
        <h2>
            <a class='cat_a' href="/category/{$cat.cat_id}/{$cat.hyphenated_name}" alt="{$cat.cat_id}">{$cat.name} </a>
        </h2>
        <ul>
            {foreach from=$cat.res item=res}
                <li>
                    <a class='expand_resource resource_name' alt="{$res.resource_id}" href="/library/{$res.resource_id}/{$res.hyphenated_name}" >{$res.name}</a>
                </li>
            {/foreach}
        </ul>
    </div>
{/foreach}
{*<div style='clear: both'>&nbsp;</div>*}