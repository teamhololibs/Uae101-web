<div class='submit_library'>
    {if $submitted == 0}
        <p>Submit a Library!</p>
        <br/>
        <p style='display: {if isset($error)}block{else}none{/if}' class='error'>Error: {$error}</p>
        <br/>
        <form method="post" action="" name='submit_library'>
            <input class='' style='display: none' name='f[stuff]' placeholder="" value="" />
            <table width='100%'>
                <tr>
                    <td style="width: 30%;">Library Name: *</td>
                    <td style="width: 69%;">
                        <input type='text' class='textbox_android' name='f[name]' required placeholder="Library Name" value="{$f.name}" />
                    </td>
                </tr>
                <tr>
                    <td>Library URL: *</td>
                    <td><input type='text' class='textbox_android' name='f[url]' placeholder="Library URL" required value="{$f.url}" /></td>
                </tr>
                <tr>
                    <td>Short Description (optional)</td>
                    <td class="description">
                        <textarea class='' id="description" name="q[description]" maxlength='{$desc_maxlength}' cols="" rows="5" placeholder="">{$f.description}</textarea>
                        <br/><span>Max characters: {$desc_maxlength} (Characters left: <i id="char_left">{$desc_maxlength}</i>)</span>
                    </td>
                </tr>
                <tr style='display: none'>
                    <td>Your Github URL<br/>(optional; for crediting)</td>
                    <td><input type='text' class='textbox_android' name='f[submitter_url]' placeholder="Your Github URL" value="{$f.submitter_url}" /></td>
                </tr>
                <tr style=''>
                    <td></td>
                    <td>
                        <input type='submit' class='submit_button' name='f[submit]' placeholder="" value="Submit Library" /><br/>
                        <span style='font-size: .8em;'>Note: The library will only appear in the site after admin approval</span>
                    </td>
                </tr>
            </table>
        </form>
    {else}
        <p>Library has been submitted for admin approval. Please check back soon!</p>
        {literal}
            <script type='text/javascript'>
                setTimeout(function() {
                    window.location.href = '/';
                }, 5000);
            </script>
        {/literal}
    {/if}
</div>