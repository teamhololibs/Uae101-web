<div class='submit_library'>
    {if $submitted == 0}
        <p>Submit a Page!</p>
        <br/>
        <p style='display: {if isset($error)}block{else}none{/if}' class='error'>Error: {$error}</p>
        <br/>
        <form method="post" action="" name='submit_library'>
            <input class='' style='display: none' name='stuff' placeholder="" value="" />
            <table width='100%'>
                <tr>
                    <td class='submit_label' style="width: 30%;">Page Name: *</td>
                    <td style="width: 69%;">
                        <input type='text' class='textbox_android' name='f[name]' required placeholder="Page Name" value="{$f.name}" />
                    </td>
                </tr>
                <tr>
                    <td class='submit_label' >Page URL: *</td>
                    <td><input type='text' class='textbox_android' name='f[url]' placeholder="Page URL" required value="{$f.url}" /></td>
                </tr>
                <tr>
                    <td colspan="2"><br/><br/>Additional optional information:</td>
                </tr>
                <tr>
                    <td>Page is for Emirates:</td>
                    <td>
                        <select name='f[emirate_id]' value='Choose Emirates' style='font-size: 1em'>
                            {foreach from=$emirates item=em}
                                <option value='{$em.emirate_id}'>{$em.name}</a>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Short Description (optional)</td>
                    <td class="description">
                        <textarea class='' id="description" name="q[description]" maxlength='{$desc_maxlength}' cols="" rows="5" placeholder="">{$f.description}</textarea>
                        <br/><span>Max characters: {$desc_maxlength} (Characters left: <i id="char_left">{$desc_maxlength}</i>)</span>
                    </td>
                </tr>
                <tr style=''>
                    <td></td>
                    <td>
                        <input type='submit' class='submit_button' name='submit' placeholder="" value="Submit Page" /><br/>
                        <span style='font-size: .8em;'>Note: The page will only appear in the site after admin approval</span>
                    </td>
                </tr>
            </table>
        </form>
    {else}
        <p>Page has been submitted for admin approval. Please check back soon!</p>
        {literal}
            <script type='text/javascript'>
                setTimeout(function() {
                    window.location.href = '/';
                }, 5000);
            </script>
        {/literal}
    {/if}
</div>