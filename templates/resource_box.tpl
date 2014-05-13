{foreach from=$resources item=res}
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
                        <span class='resource_points'>{$res.points}</span>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <img class='resource_star' src='images/star.jpg'/>
                    </td>
                </tr>
            </table>
        </div>
        <a class='expand_resource resource_name' href="#" >{$res.name}</a>
        <p class='resource_tags_p'>
            {foreach from=$res.res_cat item=res_cat}
                <a class='' href="/tag/{$res_cat.cat_id}/{$res_cat.hyphenated_name}" alt="{$res_cat.cat_id}">{$res_cat.full_name} </a><br/>
            {/foreach}
        </p>
        <p class='resource_desc'>
            {$res.description}
            <a class='expand_resource readmore' href="#" >...</a>
        </p>
        <p class='resource_views_points'>
            <span class='resource_views'>Views: {$res.views}</span>
        </p>
    </div>
{/foreach}