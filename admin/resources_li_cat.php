<?
require_once '../admin.common.prepend.php';
?>
<tr>
    <td width="21.5%" class=""><label for="tag_search">Category:</label></td>
    <td width="" >
        <input style="width:95%;" id="tagsearch_<?= $i ?>" class="tag_autocomplete" autocomplete="off" type='text' name="" value="<?= $tags[$i]['word'] ?>" placeholder="Search for..." title="Category Search"/>
    </td>
    <td  width="20%" >
        <input style="width:100%; background-color: lightgrey" id="wordid_<?= $i ?>" type='text' readonly name="q[word_id][]" value="<?= $tags[$i]['word_id'] ?>" title="Cat ID"/>
    </td>

</tr>
