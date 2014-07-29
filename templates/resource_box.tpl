{foreach from=$info item=res}
    <div class='resource_box'>
        <table>
            <tr>
                <td class='emirate_container' valign='bottom'>
                    <a class='emirate_a' href="/emirate/{$res.emirate_id}/{$res.shortform}" alt="{$res.emirate_id}">{$res.shortform}</a> 
                </td>
                <td>
                </td>
            </tr>
        </table>
        <a class='expand_resource resource_name' alt="{$res.resource_id}" href="/page/{$res.resource_id}/{$res.hyphenated_name}" >{$res.res_name}</a>
        <div class='cat_container'>
            {assign var="first" value=true}
            {foreach from=$res.res_cat item=res_cat}
                {if !$first}<span class='cat_separator'>&nbsp;|&nbsp;</span>{/if}
                {assign var="first" value=false}
                <a class='cat_a' href="/category/{$res_cat.cat_id}/{$res_cat.hyphenated_name}" alt="{$res_cat.cat_id}">{$res_cat.full_name} </a>
            {/foreach}
        </div>
        {*
        <div class='resource_desc'>
        {$res.description}
        </div>
        *}
    </div>
{/foreach}
{*<div style='clear: both'>&nbsp;</div>*}