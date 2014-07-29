{foreach from=$info item=res}
    <div class='resource_box'>
        <p>
            <a class='expand_resource resource_name' alt="{$res.resource_id}" href="/page/{$res.resource_id}/{$res.hyphenated_name}" >{$res.name}</a>
        </p>
        <p class='resource_tags_p'>
            {foreach from=$res.res_cat item=res_cat}
                <a class='cat_a' href="/category/{$res_cat.cat_id}/{$res_cat.hyphenated_name}" alt="{$res_cat.cat_id}">{$res_cat.full_name} </a><br/>
            {/foreach}
        </p>
        <div class='resource_desc'>
            {$res.description}
        </div>
    </div>
{/foreach}
{*<div style='clear: both'>&nbsp;</div>*}