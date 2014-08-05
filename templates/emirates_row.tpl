<div class='emirates_row'>
    Search in Emirates: 
    {foreach from=$emirates item=em}
        <a class='emirates_link {$em.selected}' href="/category-{$cat_link}/emirate-{$em.emirate_id}" >{$em.name}</a>
    {/foreach}
    <a class='emirates_link {$emirate_all_selected}' href="/category-{$cat_link}/emirate-all" >ALL</a>

    <br/><br/><br/>
    <span class='search_details'>
    	Currently showing search results from <span class='cat_search_details'>{$category_search}</span> for <span class='em_search'>{$em_search}</span>. 
        <a class='clear_filter' href="/" >[Clear filters]</a>
	</span>
</div>
{*<div style='clear: both'>&nbsp;</div>*}