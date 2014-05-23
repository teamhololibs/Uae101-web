{foreach from=$resources item=res}
    <div class='resource_box'>
        <p>
            <a class='expand_resource resource_name' alt="{$res.resource_id}" href="/library/{$res.resource_id}/{$res.hyphenated_name}" >{$res.name}</a>
        </p>
        <p>
            <a class='author_name' alt="{$res.author_id}" href="/author/{$res.author_id}/{$res.author_info.hyphenated_name}" >{$res.author_info.hyphenated_name}</a>
        </p>
        <p class='resource_tags_p'>
            {foreach from=$res.res_cat item=res_cat}
                <a class='' href="/tag/{$res_cat.cat_id}/{$res_cat.hyphenated_name}" alt="{$res_cat.cat_id}">{$res_cat.full_name} </a><br/>
            {/foreach}
        </p>
        <div class='resource_desc'>
            {$res.description}
        </div>
        <div class="upvote_container">
            <table width="100%">
                <tr>
                    <td align="left">
                        <a class='' href="{$res.url}">VIEW SOURCE</a>
                    </td>
                    <td align="right">
                        <span class=''>{$res.points}</span>
                        <img class='resource_point' src='{$PIC_PATH}/like.png'/>
                    </td>
                    <td align="right">
                        <img class='resource_star' src='{$PIC_PATH}/favourites.png'/>
                    </td>
                </tr>
            </table>
        </div>
        {if $res.user_id != '0'}
            <div class="submitter">
                <a class='author_name' alt="{$res.author_id}" href="/author/{$res.author_id}/{$res.author_info.hyphenated_name}" >Submitted by: {$res.author_info.hyphenated_name}</a>
            </div>
        {/if}
    </div>
{/foreach}
{*<div style='clear: both'>&nbsp;</div>*}