<div class="header">
    <ul class='header_ul_left'>
        <li style='margin-left: 30px;'>
            <a href="/"><img class='logo' src="http://upload.wikimedia.org/wikipedia/commons/c/cb/Flag_of_the_United_Arab_Emirates.svg" {*src='{$PIC_PATH}/android icon.png'*}/></a>
        </li>
        <li style='margin-left: 253px;'>
            <input type='text' class='input_resource_search' placeholder="SEARCH HERE" value="{$search_text}"/>
            {*<span id='in_all_tags' style='margin-left: 15px; display: none'><input id='limit_search_checkbox' type='checkbox' checked value="1"/> 
            <label for='limit_search_checkbox'>Limit search to this category?</label></span>*}
        </li>
    </ul>
    <ul class='header_ul_right'>
        <li>
            <a id='submit_library' href="/submit">SUBMIT A PAGE</a>
            {*<span class='login_dropdown'>LOGIN</span>
            {include file="common/login_dropdown.tpl" var_name1=$HEADER_VARS}*}
        </li>
    </ul>
    {$var_name}
    <div style='clear: both'></div>
</div>