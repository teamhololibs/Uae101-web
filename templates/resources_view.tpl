{foreach from=$info item=emirate}
    <div id='' class='category_box'>
        <h2>
            <a class='emirate_a' href="/category-{$cat_link}/emirate-{$emirate.emirate_id}/" alt="{$emirate.emirate_id}">{$emirate.name} </a>
        </h2>
        <ul>
            {foreach from=$emirate.res item=res}
                <li>
                    <a class='resource_name' target="_blank" href="{$res.url}" >{$res.res_name}</a>
{*                    <a class='expand_resource resource_name' alt="{$res.resource_id}" href="/page/{$res.resource_id}/{$res.hyphenated_name}" >{$res.res_name}</a>*}
                    <br/>
                    <div class='cat_container'>
                        {assign var="first" value=true}
                        {foreach from=$res.res_cat item=res_cat}
                            {if !$first}<span class='cat_separator'>&nbsp;|&nbsp;</span>{/if}
                            {assign var="first" value=false}
                            <a class='cat_a' href="/category-{$res_cat.cat_id}/emirate-{$emirate.emirate_id}/" alt="{$res_cat.cat_id}">{$res_cat.full_name} </a>
                        {/foreach}
                    </div>
                </li>
            {/foreach}
        </ul>
    </div>
{/foreach}
{*<div style='clear: both'>&nbsp;</div>*}